from datetime import datetime

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, Http404, HttpResponseRedirect, QueryDict
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from django.conf import settings

from square.models import Square, SquareOpen
from issue.models import Issue
from square.forms import SquareForm

MIMETYPE_IMAGE = 'image/tiff'

def book(request, issue, square_open):
    pos_x = square_open.pos_x
    pos_y = square_open.pos_y
    try:
        square = Square.objects.get(pos_x=pos_x, pos_y=pos_y, issue=issue, user__isnull=True)
        square.user = request.user
        square.status = 0
        square.save()
    except Square.DoesNotExist:
        square = Square.objects.create(pos_x=pos_x, pos_y=pos_x,\
                    status=0, issue=issue, user=request.user)
    SquareOpen.objects.neighbors_standby(square_open, True);
    
    return template(request, square.get_template())

def release(request, issue, square_open):
    square = get_object_or_404(Square, pos_x=square_open.pos_x,\
                pos_y=square_open.pos_y, issue=issue)
    SquareOpen.objects.neighbors_standby(square_open, False);
    square.delete()
    return HttpResponseRedirect(reverse('square_templates'))

def fill(request, issue, square_open):
    square = get_object_or_404(Square, pos_x=square_open.pos_x,\
                pos_y=square_open.pos_y, issue=issue)
    if request.method == 'POST':
        #square.status = True
        form = SquareForm(request.POST, request.FILES, instance=square)
        if form.is_valid():
            square = form.save()
            #return HttpResponseRedirect(reverse('issue', kwargs={'slug': issue.slug }))
    else:
        form = SquareForm(instance=square)
    return render_to_response('fill.html', {
        'square': square,
        'issue': issue,
        'form': form
    }, context_instance=RequestContext(request))

@login_required
def square(request, action, pos_x, pos_y, issue_slug):
    issue = get_object_or_404(Issue, slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)
    #getattr(__import__(__name__), action)(request, issue, issue_slug)
    return globals()[action](request, issue, square_open)

@login_required
def templates(request, template_name='templates.html'):
    return render_to_response(template_name, {
        'participations_by_issues': request.user.get_profile().participations_by_issues()
    }, context_instance=RequestContext(request))

@login_required
def template(request, template):
    if isinstance(template, unicode):
        template = Square.retrieve_template(template)
        if not template:
            raise Http404

    buffer = Square.buffer(template)
    response = HttpResponse(mimetype=MIMETYPE_IMAGE)
    response['Content-Disposition'] = 'attachment; filename=%s' % template.filename
    response.write(buffer.getvalue())
    return response