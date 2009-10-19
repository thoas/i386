from django.shortcuts import get_object_or_404
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
        return pyamf_success({
            'user': request.user,
            'remain_participations': request.user.get_profile().remain_participations()
        })
    return pyamf_errors()

@pyamf_format
def _login(request, username=None, password=None, remember=None):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.login(request):
            return pyamf_success({
                'user': request.user,
                'remain_participations': request.user.get_profile().remain_participations()
            })
        return pyamf_errors(form.errors.values()[0])
    return None

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

