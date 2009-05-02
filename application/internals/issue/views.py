from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden

from django.utils.translation import ugettext_lazy as _

from issue.models import Issue, ParticipateIssue

def issues(request, template_name='issues.html'):
    """docstring for issues"""
    return render_to_response(template_name, {
    }, context_instance=RequestContext(request))
    
def details(request, title, template_name='issue_details.html'):
    """docstring for issues"""
    return render_to_response(template_name, {
    }, context_instance=RequestContext(request))
