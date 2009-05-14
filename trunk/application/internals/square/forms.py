import logging

from PIL import Image
from datetime import datetime
from os import rename
from os.path import join

from django.forms import ModelForm
from django import forms
from django.conf import settings
from django.utils.translation import ugettext_lazy as _

from square.models import Square
from square.constance import *

class SquareForm(ModelForm):
    background_image_name = forms.ImageField(required=True)
    
    def clean_background_image_path(self):
        """docstring for clean_background_image_path"""
        background_image_name = self.cleaned_data['background_image_name']
        if not background_image_name is None:
            if not background_image_name.content_type in settings.ALLOWED_EXTENSIONS:
                raise forms.ValidationError(_('Mimetype %s not allowed')\
                                            % background_image_name.content_type)
        return background_image_name

    def save(self):
        """docstring for save"""
        square = super(SquareForm, self).save()
        
        template_full_path = square.get_template_full_path()
        
        rename(join(settings.MEDIA_ROOT, square.background_image_name.name), template_full_path)
        
        template = Image.open(template_full_path)
        issue = square.issue
        
        neighbors_keys = square.neighbors()
        logging.info(neighbors_keys)
        
        neighbors = Square.objects.neighbors(square)
        logging.info(neighbors)
        for neighbor in neighbors:
            index = neighbors_keys[tuple((neighbor.x, neighbor.y))]
            logging.info(index)
            
            image = Image.open(neighbor.get_background_image_path())
            logging.info(neighbor.get_background_image_path())
            
            image.paste(template.crop(issue.paste_pos[index]), issue.crop_pos[index])
            del neighbors_keys[index]
            logging.info('- %d' % index)
        
        now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
        size =  tuple((issue.size, issue.size))
        
        # create square side by side
        for x, y in neighbors_keys.keys():
            if (x >= 0 and x < issue.nb_case_y) and (y >= 0 and y < issue.nb_case_x):
                index = neighbors_keys[tuple((x, y))]
                
                background_image = 'x%s_y%s__%s__%s.tif' %\
                                        (x, y, square.issue.slug, now)
                
                image = Square.image(
                    size=size,
                    background_image=background_image,
                    im_crop=template.crop(issue.paste_pos[index]),
                    paste_pos=issue.crop_pos[index],
                    directory_root=settings.TMP_ROOT
                )
                
                logging.info('+ (%d, %d)' % (x, y))
        
        # current square
        background_image = '%s__x%s_y%s__%s__%s.tif' %\
                                (square.user.username, square.pos_x, square.pos_y, square.issue.slug, now)
        image = Square.image(
            size=size,
            background_image=background_image,
            im_crop=template.crop(issue.creation_position_crop),
            paste_pos=issue.creation_position_paste,
            directory_root=settings.UPLOAD_HD_ROOT
        )
        
        logging.info('+ %s' % image)
        return square
    
    class Meta:
        model = Square
        exclude = ('pos_x', 'pos_y', 'issue', 'square_parent',\
                    'coord', 'user', 'status', 'template_name',\
                        'date_finished', 'date_booked')