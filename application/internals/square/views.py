import StringIO

from PIL import Image
from square.models import Square, SquareOpen, ParticipateSquare
from issue.models import Issue
from datetime import datetime
from square.constance import *

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.conf import settings

@login_required
def book(request, pos_x, pos_y, issue_slug):
    image = Image.new("RGB", (1200, 1200), 'black')
    response = HttpResponse(mimetype="image/png")
    issue = get_object_or_404(Issue, slug=issue_slug)
    print issue
    square_open = get_object_or_404(SquareOpen, pos_x=pos_x, pos_y=pos_y)
    neighbors_key = square_open.neighbors()
    neighbors = Square.objects.neighbors(square_open)
    
    # creation d'un square
    square = Square.objects.create(pos_x=square_open.pos_x, pos_y=square_open.pos_y,\
                status=0, issue=issue)
    participate_square = ParticipateSquare.objects.create(square=square, user=request.user)
    square_open.delete()
    for neighbor in neighbors:
        index = neighbors_key[neighbor.coord]
        im = Image.open(neighbor.background_image_path.path)
        
        print '%s -> %s (%s)' % (CROP_POS[index], PASTE_POS[index], LITERAL[index])
        crop = im.crop(CROP_POS[index])
        image.paste(crop, PASTE_POS[index])

    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    #response['Content-Disposition'] = 'attachment; filename=%s_x%s_y%s_%s_template.tif'\
    #    % (request.user.username, pos_x, pos_y, now)
    buffer = StringIO.StringIO()
    image.save(buffer, format='PNG', quality=90)
    jpeg = buffer.getvalue()
    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    response.write(jpeg)
    return response