import StringIO

from os import unlink
from os.path import join, exists
from PIL import Image
from square.models import Square, SquareOpen
from issue.models import Issue
from datetime import datetime
from square.constance import *

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.contrib.auth.decorators import login_required
from django.conf import settings

FORMAT_IMAGE = 'PNG'
MIMETYPE_IMAGE = 'image/png'

@login_required
def book(request, pos_x, pos_y, issue_slug):
    image = Image.new("RGB", (1200, 1200), 'white')
    issue = get_object_or_404(Issue, slug=issue_slug)
    
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue=issue)
    neighbors_key = square_open.neighbors()
    neighbors = Square.objects.neighbors(square_open)
    
    # creation d'un square
    for neighbor in neighbors:
        index = neighbors_key[neighbor.coord]
        im = Image.open(neighbor.background_image_path.path)
        
        print '%s -> %s (%s)' % (CROP_POS[index], PASTE_POS[index], LITERAL[index])
        crop = im.crop(CROP_POS[index])
        image.paste(crop, PASTE_POS[index])

    now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
    template_name = '%s__x%s_y%s__%s__template.tif' % (request.user.username, pos_x, pos_y, now)    
    square = Square.objects.create(pos_x=square_open.pos_x, pos_y=square_open.pos_y,\
                status=0, issue=issue, user=request.user, template_name=template_name)

    SquareOpen.objects.neighbors_standby(square_open, True);

    buffer = StringIO.StringIO()
    image.save(buffer, format=FORMAT_IMAGE, quality=90)
    image.save(square.template_path(), format=FORMAT_IMAGE, quality=90)
    
    response = HttpResponse(mimetype=MIMETYPE_IMAGE)
    response['Content-Disposition'] = 'attachment; filename=%s' % template_name
    response.write(buffer.getvalue())
    return response

@login_required
def templates(request, template_name='templates.html'):
    return render_to_response(template_name, {
        'participations_by_issues': request.user.get_profile().participations_by_issues()
    }, context_instance=RequestContext(request))

@login_required
def template(request, template_name):
    buffer = StringIO.StringIO()
    template_path = join(settings.TEMPLATE_ROOT, template_name)
    if not exists(template_path):
        raise Http404
    image = Image.open(template_path)
    image.save(buffer, format=FORMAT_IMAGE, quality=90)
    response = HttpResponse(mimetype=MIMETYPE_IMAGE)
    response['Content-Disposition'] = 'attachment; filename=%s' % template_name
    response.write(buffer.getvalue())
    return response

@login_required
def release(request, pos_x, pos_y, issue_slug):
    """docstring for release"""
    square = get_object_or_404(Square, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug)
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y, issue__slug=issue_slug)

    SquareOpen.objects.neighbors_standby(square_open, False);
    
    square.delete()
    return HttpResponseRedirect(reverse('square_templates'))

@login_required
def fill(request, pos_x, pos_y, issue_slug):
    pass