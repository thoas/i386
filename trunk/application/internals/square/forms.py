import logging

from PIL import Image
from datetime import datetime

from django.forms import ModelForm
from django import forms
from django.conf import settings
from django.utils.translation import ugettext_lazy as _

from square.models import Square
from square.constance import *

class SquareForm(ModelForm):
    background_image_path = forms.ImageField(required=True)
    
    def clean_background_image_path(self):
        """docstring for clean_background_image_path"""
        background_image_path = self.cleaned_data['background_image_path']
        if not background_image_path is None:
            if not background_image_path.content_type in settings.ALLOWED_EXTENSIONS:
                raise forms.ValidationError(_('Mimetype %s not allowed')\
                                            % background_image_path.content_type)
        return background_image_path

    def save(self):
        """docstring for save"""
        square = super(SquareForm, self).save()
        
        template = Image.open(square.get_template_full_path())
        issue = square.issue
        
        neighbors_keys = square.neighbors()
        logging.info(neighbors_keys)
        
        neighbors = Square.objects.neighbors(square)
        logging.info(neighbors)
        for neighbor in neighbors:
            coord_tuple = tuple((neighbor.x, neighbor.y))
            index = neighbors_keys[coord_tuple]
            logging.info(index)
            
            image = Image.open(neighbor.background_image_path.path)
            logging.info(neighbor.background_image_path.path)
            
            image.paste(template.crop(issue.paste_pos[index]), issue.crop_pos[index])
            del neighbors_keys[index]
            logging.info('del %d' % index)
        
        now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
        for x, y in neighbors_keys.keys():
            if (x > 0 and issue.nb_case_y) and (y > 0 and y < issue.nb_case_x):
                continue
            index = neighbors_keys[tuple((x, y))]
            
            background_image = 'x%s_y%s__%s__%s.tif' %\
                                    (self.pos_x, self.pos_y, issue.slug, now)
            Square.objects.create(issue=issue, pos_x=x, pos_y=y, background_image_path=background_image)
            image = Image.new(DEFAULT_IMAGE_MODE, (issue.size, issue.size), DEFAULT_IMAGE_BACKGROUND_COLOR)
            image.paste(template.crop(issue.paste_pos[index]), issue.crop_pos[index])
            image.save(join(settings.TEMPLATE_TMP_ROOT, background_image), format=FORMAT_IMAGE, quality=90)
            logging.info('+ %s' % background_image)
        
        # current square
        background_image = '%s__x%s_y%s__%s__%s.tif' %\
                                (self.user.username, self.pos_x, self.pos_y, issue.slug, now)
        image = Image.new(DEFAULT_IMAGE_MODE, (issue.size, issue.size), DEFAULT_IMAGE_BACKGROUND_COLOR)
        image.paste(template.crop(issue.creation_position_crop), issue.creation_position_paste)
        image.save(join(settings.TEMPLATE_TMP_ROOT, background_image), format=FORMAT_IMAGE, quality=90)
        return square
    class Meta:
        model = Square
        exclude = ('pos_x', 'pos_y', 'issue', 'square_parent',\
                    'coord', 'user', 'status', 'template_name',\
                        'date_finished', 'date_booked')