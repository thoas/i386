import random
import StringIO

from PIL import Image
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from square.models import Square, SquareOpen
from datetime import datetime

@login_required
def book(request, pos_x, pos_y):
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