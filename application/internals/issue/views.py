from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden
from django.contrib.auth.decorators import login_required
from django.utils.translation import ugettext_lazy as _

from issue.models import Issue, ParticipateIssue

@login_required
def issues(request, template_name='issues.html'):
    """docstring for issues"""
    return render_to_response(template_name, {
        'issues': Issue.objects.all()
    }, context_instance=RequestContext(request))

@login_required
def issue(request, slug, template_name='issue_details.html'):
    """docstring for issues"""
    issue = get_object_or_404(Issue, slug=slug)
    return render_to_response(template_name, {
        'issue': issue,
        'nb_case_x': range(issue.nb_case_x),
        'nb_case_y': range(issue.nb_case_y)
    }, context_instance=RequestContext(request))
