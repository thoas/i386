from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden
from django.utils.translation import ugettext_lazy as _, ugettext
from django.contrib.auth.decorators import login_required

from profiles.models import Profile
from profiles.forms import ProfileForm

from misc.views import pyamf_format

@login_required
def _profile(request):        
    return request.user.get_profile()

@login_required
@pyamf_format
def _profile_change(request, name, website, location):
    if request.method == 'POST':
        profile_form = ProfileForm(request.POST, instance=request.user.get_profile())
        if profile_form.is_valid():
            profile = profile_form.save()
            return profile
    return False

def _last_profiles(request):
    return Profile.objects.select_related('user').order_by('user__date_joined')

@login_required
def _creations(request):
    return request.user.get_profile().participations()