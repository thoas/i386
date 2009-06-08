import logging

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, Http404, HttpResponseRedirect, QueryDict
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from django.conf import settings
from django.db import transaction
from django.db.models import Q

from square.models import Square, SquareOpen
from issue.models import Issue
from square.forms import SquareForm
from issue.views import issue

MIMETYPE_IMAGE = 'image/tiff'

@transaction.commit_manually
def book(request, issue, square_open):
    pos_x = square_open.pos_x
    pos_y = square_open.pos_y
    
    transaction.commit()
    try:
        try:
            # Q() object raise an error when at the bottom : non-keyword arg after keyword arg
            square = Square.objects.get(Q(user__isnull=True) | Q(user=request.user),\
                        pos_x=pos_x, pos_y=pos_y, issue=issue)
            
            if not square.user:
                square.user = request.user
                square.save()
        except Square.DoesNotExist:
            square = Square.objects.create(pos_x=pos_x, pos_y=pos_x, issue=issue,\
                        user=request.user, status=0)
        if not square.status:
            SquareOpen.objects.neighbors_standby(square_open, 1)
    except Exception, error:
        print error
        logging.error(error)
        transaction.rollback()
    else:
        transaction.commit()
        return template(request, square.template())
    return templates(request)

def release(request, issue, square_open):
    square = get_object_or_404(Square, pos_x=square_open.pos_x,\
                pos_y=square_open.pos_y, issue=issue, status=0)
    SquareOpen.objects.neighbors_standby(square_open, False)
    square.delete()
    return HttpResponseRedirect(reverse('square_templates'))

@transaction.commit_manually
def fill(request, issue, square_open):
    # http://groups.google.com/group/django-developers/browse_thread/thread/818c2ee766550426/e311d8fe6a04bb22
    # no get_object_or_404 with select_related()
    try:
        square = Square.objects.select_related('user', 'issue').get(pos_x=square_open.pos_x,\
                    pos_y=square_open.pos_y, user=request.user, issue=issue)
    except Square.DoesNotExist:
        raise Http404
    
    if request.method == 'POST':
        square.status = 1
        form = SquareForm(request.POST, request.FILES, instance=square)
        if form.is_valid():
            transaction.commit()
            try:
                square = form.save()
                
                # upload good, now allow book square open
                SquareOpen.objects.neighbors_standby(square_open, 0)
                
                # delete old square open
                square_open.delete()
            except Exception, error:
                print error
                logging.error(error)
                transaction.rollback()
            else:
                transaction.commit()
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
    logging.debug('x: %s - y: %s - issue: %s' % (pos_x, pos_y, issue_slug))
    issue = get_object_or_404(Issue, slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)
    #getattr(__import__(__name__), action)(request, issue, issue_slug)
    return globals()[action](request, issue, square_open)

@login_required
def templates(request, template_name):
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