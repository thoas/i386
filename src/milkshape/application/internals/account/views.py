from django.conf import settings
from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect
from django.contrib.auth import authenticate, login as auth_login
from django.contrib.auth.decorators import login_required
from django.contrib.sites.models import Site
from django.contrib.auth.models import User
from django.template import RequestContext
from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

from account.models import Invitation
from account.forms import SignupForm, AddEmailForm, LoginForm, \
    ChangePasswordForm, ResetPasswordForm, ChangeTimezoneForm, \
        ChangeLanguageForm, InvitationForm
from emailconfirmation.models import EmailAddress, EmailConfirmation

from misc.views import pyamf_format, pyamf_errors, pyamf_success

def _logout(request):
    from django.contrib.auth import logout
    logout(request)
    return True

def _is_authenticated(request):
    if request.user.is_authenticated():
        return pyamf_success(request.user)
    return pyamf_errors()

@pyamf_format
def _login(request, username=None, password=None, remember=None):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.login(request):
            return pyamf_success(request.user)
        return pyamf_errors(form.errors.values()[0])
    return None

def login(request, template_name, form_class=LoginForm):
    if request.method == 'POST':
        default_redirect_to = getattr(settings, 'LOGIN_REDIRECT_URLNAME', None) 
        if default_redirect_to:
            default_redirect_to = reverse(default_redirect_to)
        else:
            default_redirect_to = settings.LOGIN_REDIRECT_URL
        redirect_to = request.REQUEST.get('next')
        # light security check -- make sure redirect_to isn't garabage.
        if not redirect_to or '://' in redirect_to or ' ' in redirect_to:
            redirect_to = default_redirect_to
        form = form_class(request.POST)
        if form.login(request):
            return HttpResponseRedirect(redirect_to)
    else:
        form = form_class()
    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))

@pyamf_format
def _signup(request, username, email, password1, password2, confirmation_key):
    if request.method == 'POST':
        form = SignupForm(request.POST)
        if form.is_valid():
            username, password = form.save()
            user = authenticate(username=username, password=password)
            auth_login(request, user)
            return pyamf_success(user)
        return pyamf_errors(form.errors.values()[0])
    return False

def signup(request, confirmation_key, template_name, form_class=SignupForm):
    if request.method == 'POST':
        form = form_class(request.POST)
        if form.is_valid():
            username, password = form.save()
            user = authenticate(username=username, password=password)
            auth_login(request, user)
            request.user.message_set.create(message=_('Successfully logged in as %(username)s.') 
                % {'username': user.username})
            return HttpResponseRedirect(reverse('what_next'))
    else:
        initial = {'confirmation_key': confirmation_key}
        try:
            invitation = Invitation.objects.get(confirmation_key=confirmation_key)
            initial['email'] = invitation.email
        except Invitation.DoesNotExist:
            pass
        form = form_class(initial=initial)
    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))

def password_reset(request, form_class=ResetPasswordForm,
        template_name='password_reset.html',
        template_name_done='account/password_reset_done.html'):
    if request.method == 'POST':
        password_reset_form = form_class(request.POST)
        if password_reset_form.is_valid():
            email = password_reset_form.save()
            return render_to_response(template_name_done, {
                'email': email,
            }, context_instance=RequestContext(request))
    else:
        password_reset_form = form_class()

    return render_to_response(template_name, {
        'password_reset_form': password_reset_form,
    }, context_instance=RequestContext(request))

@login_required
def email(request, template_name, form_class=AddEmailForm):
    if request.method == 'POST' and request.user.is_authenticated():
        if request.POST['action'] == 'add':
            add_email_form = form_class(request.user, request.POST)
            if add_email_form.is_valid():
                add_email_form.save()
                add_email_form = form_class() # @@@
        else:
            add_email_form = form_class()
            if request.POST['action'] == 'send':
                email = request.POST['email']
                try:
                    email_address = EmailAddress.objects.get(user=request.user, email=email)
                    request.user.message_set.create(message=_('Confirmation email sent to %s') % email)
                    EmailConfirmation.objects.send_confirmation(email_address)
                except EmailAddress.DoesNotExist:
                    pass
            elif request.POST['action'] == 'remove':
                email = request.POST['email']
                try:
                    email_address = EmailAddress.objects.get(user=request.user, email=email)
                    email_address.delete()
                    request.user.message_set.create(message=_('Removed email address %s') % email)
                except EmailAddress.DoesNotExist:
                    pass
            elif request.POST['action'] == 'primary':
                email = request.POST['email']
                email_address = EmailAddress.objects.get(user=request.user, email=email)
                email_address.set_as_primary()
    else:
        add_email_form = form_class()
    return render_to_response(template_name, {
        'add_email_form': add_email_form,
    }, context_instance=RequestContext(request))

@login_required
def password_change(request, template_name, form_class=ChangePasswordForm):
    if request.method == 'POST':
        password_change_form = form_class(request.user, request.POST)
        if password_change_form.is_valid():
            password_change_form.save()
            password_change_form = form_class(request.user)
    else:
        password_change_form = form_class(request.user)
    return render_to_response(template_name, {
        'password_change_form': password_change_form,
    }, context_instance=RequestContext(request))

@login_required
@pyamf_format
def _password_change(request, oldpassword, password1, password2):
    if request.method == 'POST':
        password_change_form = ChangePasswordForm(request.user, request.POST)
        if password_change_form.is_valid():
            password_change_form.save()
            return request.user
        else:
            return password_change_form.errors['__all__']
    return False

@login_required
def timezone_change(request, template_name, form_class=ChangeTimezoneForm):
    if request.method == 'POST':
        form = form_class(request.user, request.POST)
        if form.is_valid():
            form.save()
    else:
        form = form_class(request.user)
    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))

@login_required
def language_change(request, template_name, form_class=ChangeLanguageForm):
    if request.method == 'POST':
        form = form_class(request.user, request.POST)
        if form.is_valid():
            form.save()
            next = request.META.get('HTTP_REFERER', None)
            return HttpResponseRedirect(next)
    else:
        form = form_class(request.user)
    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))

@login_required
def invitations(request, template_name, confirmation_key, form_class=InvitationForm):
    invitations = _invitations(request)
    form = form_class()
    
    if request.method == 'POST':
        if request.POST['action'] == 'add':
            if invitations['remain_invitation'] > 0:
                new_invitation = Invitation.objects.create(user=request.user, 
                    confirmation_key=User.objects.make_random_password())
                
                invitations['unused_invitations'].append(new_invitation)
                invitations['remain_invitation'] -= 1
        elif request.POST['action'] == 'update':
            from datetime import datetime
            current_site = Site.objects.get_current()
            user_profile = request.user.get_profile()
            for i in range(len(invitations['unused_invitations'])):
                index = str(i)
                email = request.POST['email_' + index]
                confirmation_key = request.POST['confirmation_key_' + index]
                content = request.POST['content_' + index]
                invitation = _send_invitation(request, confirmation_key, email, content)
                if not invitation:
                    request.user.message_set.create(message=_('%s already exists in our database') % email)
                else:
                    invitations['unused_invitations'].remove(invitation)
    return render_to_response(template_name, {
        'form': form,
        'invitations': invitations,
    }, context_instance=RequestContext(request))

@login_required
def _create_invitation(request):
    remain_invitation = request.user.get_profile().remain_invitation()
    if remain_invitation > 0:
        new_invitation = Invitation.objects.create(
            user=request.user,
            confirmation_key=User.objects.make_random_password()
        )
        return new_invitation
    return False


@login_required
def _invitations(request):
    remain_invitation = request.user.get_profile().remain_invitation()
    users_invited = request.user.get_profile().users_invited()
    unused_invitations = list(request.user.get_profile().unused_invitations())
    sent_invitations = request.user.get_profile().sent_invitations()
    return {
        'remain_invitation': remain_invitation,
        'users_invited': users_invited,
        'unused_invitations': unused_invitations,
        'sent_invitations': sent_invitations
    }

@login_required
def _send_invitation(request, confirmation_key, email, content):
    from django.forms.fields import email_re
    if email_re.match(email):
        try:
            invitation = Invitation.objects.get(email=email)
        except Invitation.DoesNotExist:
            invitation = get_object_or_404(Invitation, confirmation_key=confirmation_key)
            invitation.email = email
            invitation.content = content
            invitation.save()
            return invitation
    return False

