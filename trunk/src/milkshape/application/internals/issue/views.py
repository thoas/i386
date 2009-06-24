import pyamf

from django.shortcuts import get_object_or_404
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.utils.translation import ugettext_lazy as _

from misc.views import MultiResponse
from issue.models import Issue
from square.models import Square, SquareOpen

from misc.views import pyamf_format

def _issues(request):
    """docstring for issues"""
    datas = {
        'issues': Issue.objects.all()
    }
    
    return datas

@pyamf_format
def _issue(request, slug):
    """docstring for issues"""
    issue = get_object_or_404(Issue, slug=slug)
    squares_open = SquareOpen.objects.filter(issue=issue, is_standby=0)
    squares = Square.objects.select_related('user', 'issue').filter(issue=issue)
    
    # bad, but defer() (in django 1.1 beta) function raises an error in PyAMF
    for square in squares:
        if square.user:
            square.user.password = None
    
    datas = {
        'issue': issue,
        'squares_open': squares_open,
        'squares': squares,
        'nb_case_x': range(issue.nb_case_x),
        'nb_case_y': range(issue.nb_case_y)
    }
    
    return datas

@MultiResponse()
def issues(request, format, template_name):
    return _issues(request)

@MultiResponse()
def issue(request, slug, format, template_name):
    datas = _issue(request, slug)
    datas['t_squares_open'] = dict((square_open.coord, square_open) for square_open in datas['squares_open'])
    datas['t_squares'] = dict((square.coord, square) for square in datas['squares'])
    return datas