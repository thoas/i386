from pyamf import register_class
from pyamf.remoting.gateway.django import DjangoGateway

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden
from django.contrib.auth.decorators import login_required
from django.utils.translation import ugettext_lazy as _

from issue.models import Issue
from square.models import Square, SquareOpen

def _issues(request):
    """docstring for issues"""
    datas = {
        'issues': Issue.objects.all()
    }
    
    return datas

def _issue(request, slug):
    """docstring for issues"""
    issue = get_object_or_404(Issue, slug=slug)
    squares_open = SquareOpen.objects.filter(issue=issue, is_standby=1)
    squares = Square.objects.filter(issue=issue)
    
    t_squares_open = dict((square_open.coord, square_open) for square_open in squares_open)
    t_squares = dict((square.coord, square) for square in squares)

    datas = {
        'issue': issue,
        't_squares_open': t_squares_open,
        't_squares': t_squares,
        'nb_case_x': range(issue.nb_case_x),
        'nb_case_y': range(issue.nb_case_y)
    }
    
    return datas

#@login_required
def issues(request, format, template_name):
    return _issues(request)

#@login_required
def issue(request, slug, format, template_name):
    return _issue(request, slug)

services = {
    'issue.issues': _issues,
    'issue.issue': _issue
}

issueGateway = DjangoGateway(services)