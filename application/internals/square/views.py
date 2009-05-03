import random
import os.path
import StringIO

from PIL import Image
from square.models import Square, SquareOpen
from datetime import datetime
from square.constance import *

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.contrib.auth.models import User
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.conf import settings

@login_required
def book(request, pos_x, pos_y):
    INK = "red", "blue", "green", "yellow", 'black'
    image = Image.new("RGB", (1200, 1200), random.choice(INK))
    response = HttpResponse(mimetype="image/png")
    square = get_object_or_404(Square, pos_x=pos_x, pos_y=pos_y)
    neighbors_key = square.neighbors()
    neighbors = Square.objects.neighbors(square)
    
    for neighbor in neighbors:
        index = neighbors_key[neighbor.coord]
        im = Image.open(neighbor.background_image_path.path)
        pos = POSITIONS[index]
        size = SIZE[index]
        crop_pos = (pos[0], pos[1], size[0] + pos[0], size[1] + pos[1])
        
        print '%s -> %s (%s)' % (pos + size, CROP_POS[index], LITERAL[index])
        crop = im.crop(CROP_POS[index])
        image.paste(crop, PASTE_POS[index])
    
    buffer = StringIO.StringIO()
    image.save(buffer, format='PNG', quality=90)
    jpeg = buffer.getvalue()
    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    response.write(jpeg)
    return response

def test(request, pos_x, pos_y):
    INK = "red", "blue", "green", "yellow"
    image = Image.new("RGB", (800, 600), random.choice(INK))

    # to save as a file
    #import os.path
    #from django.conf import settings
    #IMAGE_PATH = os.path.join(settings.FILE_UPLOAD_TEMP_DIR, 'test.tif')
    #image.save(IMAGE_PATH, "TIFF")

    buffer = StringIO.StringIO()
    image.save(buffer, format='TIFF', quality=90)
    jpeg = buffer.getvalue()
    now = datetime.now().strftime('%Y-%m-%d_%H-%M-%S')
    response = HttpResponse(mimetype="image/tif")
    response['Content-Disposition'] = 'attachment; filename=%s_x%s_y%s_%s_template.tif'\
        % (request.user.username, pos_x, pos_y, now)
    response.write(jpeg)
    return response