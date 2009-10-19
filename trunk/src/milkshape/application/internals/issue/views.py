import pyamf

from django.shortcuts import get_object_or_404
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.translation import ugettext_lazy as _

from misc.views import pyamf_format
from issue.models import Issue
from square.models import Square, SquareOpen

def _issues(request):
    """docstring for issues"""
    return {
        'issues': Issue.objects.all()
    }

def _issue(request, slug):
    """docstring for issues"""
    issue = get_object_or_404(Issue, slug=slug)
    squares_open = SquareOpen.objects.filter(issue=issue, is_standby=0)
    squares = Square.objects.select_related('user', 'issue').filter(issue=issue)
    
    datas = {
        'issue': issue,
        'squares_open': squares_open,
        'squares': squares,
        'nb_case_x': range(issue.nb_case_x),
        'nb_case_y': range(issue.nb_case_y)
    }
    
    return datas

def _last_issues(request):
    return {
        'current_issues': Issue.objects.get_current_issues(),
        'complete_issues': Issue.objects.get_complete_issues()
    }