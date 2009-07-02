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
def _book(request, pos_x, pos_y, issue_slug):
    issue = get_object_or_404(Issue, slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue, is_standby=False)
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
            square = Square.objects.create(pos_x=pos_x, pos_y=pos_y, issue=issue,\
                        user=request.user, status=0)
        if not square.status:
            SquareOpen.objects.neighbors_standby(square_open, True)
    except Exception, error:
        print error
        logging.error(error)
        transaction.rollback()
    else:
        transaction.commit()
        return square
    return False

@login_required
def book(request, pos_x, pos_y, issue_slug):
    result = _book(request, pos_x, pos_y, issue_slug)
    if result:
        return __template(request, result.template())
    return templates('templates.html')

@login_required
def _release(request, pos_x, pos_y, issue_slug):
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug)
    square = get_object_or_404(Square, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug, status=0)
    SquareOpen.objects.neighbors_standby(square_open, False)
    print square
    if square.background_image:
        square.user = None
        square.save()
        return True
    else:
        square.delete()
        return True
    return False
    
@login_required
def release(request, pos_x, pos_y, issue_slug):
    _release(request, pos_x, pos_y, issue_slug)
    return HttpResponseRedirect(reverse('square_templates'))


@transaction.commit_manually
def fill(request, pos_x, pos_y, issue_slug):
    issue = get_object_or_404(Issue, slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)
    
    # http://groups.google.com/group/django-developers/browse_thread/thread/818c2ee766550426/e311d8fe6a04bb22
    # no get_object_or_404 with select_related()
    try:
        square = Square.objects.select_related('user', 'issue').get(pos_x=pos_x,\
                    pos_y=pos_y, user=request.user, issue=issue)
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
                SquareOpen.objects.neighbors_standby(square_open, False)
                
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

@transaction.commit_manually
def _fill(request, pos_x, pos_y, issue_slug, background_image):
    issue = get_object_or_404(Issue, slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)

    # http://groups.google.com/group/django-developers/browse_thread/thread/818c2ee766550426/e311d8fe6a04bb22
    # no get_object_or_404 with select_related()
    try:
        square = Square.objects.select_related('user', 'issue').get(pos_x=pos_x,\
                    pos_y=pos_y, user=request.user, issue=issue)
    except Square.DoesNotExist:
        return False

    if request.method == 'POST':
        square.status = 1
        transaction.commit()
        try:
            dest = open(square.template_full_path(), 'wb+')
            dest.write(background_image.getvalue())
            dest.close()
            
            square.save()
            
            # upload good, now allow book square open
            SquareOpen.objects.neighbors_standby(square_open, False)

            # delete old square open
            square_open.delete()
        except Exception, error:
            print error
            logging.error(error)
            transaction.rollback()
        else:
            transaction.commit()
            return square
    else:
        return False

@login_required
def templates(request, template_name):
    return render_to_response(template_name, {
        'participations_by_issues': request.user.get_profile().participations_by_issues()
    }, context_instance=RequestContext(request))

@login_required
def template(request, pos_x, pos_y, issue_slug):
    square = get_object_or_404(Square, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug)
    return __template(request, square.template())

@login_required
def _template(request, pos_x, pos_y, issue_slug):
    square = get_object_or_404(Square, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug)
    return square.template_url

def __template(request, template):
    buffer = Square.buffer(template)
    response = HttpResponse(mimetype=MIMETYPE_IMAGE)
    response['Content-Disposition'] = 'attachment; filename=%s' % template.filename
    response.write(buffer.getvalue())
    return response

def _squares_full_by_issues(request):
    squares = Square.objects.select_related('issue', 'user').filter(status=True).order_by('issue__id')
    datas = []
    issues = {}
    for square in squares:
        if not issues.has_key(square.issue.id):
            datas.append({
                'issue': square.issue,
                'squares': []
            })
            issues[square.issue.id] = len(datas) - 1
        datas[issues[square.issue.id]]['squares'].append(square)
    return datas

#def square(request, action, pos_x, pos_y, issue_slug):
#    logging.debug('x: %s - y: %s - issue: %s' % (pos_x, pos_y, issue_slug))
#    issue = get_object_or_404(Issue, slug=issue_slug)
#    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)
    #getattr(__import__(__name__), action)(request, issue, issue_slug)
#    return globals()[action](request, issue, square_open)