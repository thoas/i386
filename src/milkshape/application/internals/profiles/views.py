from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden
from django.utils.translation import ugettext_lazy as _, ugettext
from django.contrib.auth.decorators import login_required

from profiles.models import Profile
from profiles.forms import ProfileForm

from misc.views import pyamf_format

try:
    from notification import models as notification
except ImportError:
    notification = None

def profiles(request, template_name):
    return render_to_response(template_name, {
        'users': User.objects.all().order_by('-date_joined'),
    }, context_instance=RequestContext(request))

@login_required
def profile(request, username, template_name):
    other_user = get_object_or_404(User, username=username)
    if request.user.is_authenticated():
        if request.user == other_user:
            is_me = True
        else:
            is_me = False
    else:
        is_me = False
    if is_me:
        if request.method == 'POST':
            if request.POST['action'] == 'update':
                profile_form = ProfileForm(request.POST, instance=other_user.get_profile())
                if profile_form.is_valid():
                    profile = profile_form.save(commit=False)
                    profile.user = other_user
                    profile.save()
            else:
                profile_form = ProfileForm(instance=other_user.get_profile())
        else:
            profile_form = ProfileForm(instance=other_user.get_profile())
    else:
        profile_form = None

    return render_to_response(template_name, {
        'profile_form': profile_form,
        'is_me': is_me,
        'other_user': other_user,
    }, context_instance=RequestContext(request))

@login_required
def _profile(request):        
    return request.user.get_profile()

@login_required
@pyamf_format
def _profile_change(request, name, location, website):
    if request.method == 'POST':
        profile_form = ProfileForm(request.POST, instance=request.user)
        if profile_form.is_valid():
            profile = profile_form.save()
            return profile
    return False

def _last_profiles(request):
    return Profile.objects.select_related('user').order_by('user__date_joined')