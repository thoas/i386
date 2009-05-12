import StringIO

from os import unlink
from os.path import join, exists
from PIL import Image
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
from square.constance import *
from square.forms import SquareForm

FORMAT_IMAGE = 'PNG'
MIMETYPE_IMAGE = 'image/png'

def book(request, issue, square_open):
    image = Image.new('RGB', (1200, 1200), 'white')
    neighbors_key = square_open.neighbors()
    neighbors = Square.objects.neighbors(square_open)
    
    # creation d'un square
    for neighbor in neighbors:
        index = neighbors_key[neighbor.coord]
        im = Image.open(neighbor.background_image_path.path)
        
        print '%s -> %s (%s)' % (CROP_POS[index], PASTE_POS[index], LITERAL[index])
        crop = im.crop(CROP_POS[index])
        image.paste(crop, PASTE_POS[index])

    pos_x = square_open.pos_x
    pos_y = square_open.pos_y
    now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
    template_name = '%s__x%s_y%s__%s__template.tif' % (request.user.username, pos_x, pos_y, now)
    square = Square.objects.create(pos_x=pos_x, pos_y=pos_y,\
                status=0, issue=issue, user=request.user, template_name=template_name)

    SquareOpen.objects.neighbors_standby(square_open, True);

    image.save(square.template_path(), format=FORMAT_IMAGE, quality=90)
    image.filename = template_name
    return template(request, image)

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
        datas = request.POST.copy()
        form = SquareForm(request.POST, request.FILES, square)
        if form.is_valid():
            pass
    else:
        form = SquareForm(square)
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
        template_path = join(settings.TEMPLATE_ROOT, template)
        if not exists(template_path):
            raise Http404
        template = Image.open(template_path)
    
    buffer = StringIO.StringIO()
    template.save(buffer, format=FORMAT_IMAGE, quality=90)
    response = HttpResponse(mimetype=MIMETYPE_IMAGE)
    response['Content-Disposition'] = 'attachment; filename=%s' % template.filename
    response.write(buffer.getvalue())
    return response