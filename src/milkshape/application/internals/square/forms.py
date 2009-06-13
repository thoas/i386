
from django.forms import ModelForm
from django import forms
from django.utils.translation import ugettext_lazy as _
from django.conf import settings

from square.models import Square

class SquareForm(ModelForm):
    background_image = forms.ImageField(required=True)
    
    def clean_background_image(self):
        """docstring for clean_background_image"""
        background_image = self.cleaned_data['background_image']
        if not background_image is None:
            if not background_image.content_type in settings.ALLOWED_EXTENSIONS:
                raise forms.ValidationError(_('Mimetype %s not allowed')\
                                            % background_image.content_type)
        return background_image

    def save(self):
        """docstring for save"""
        dest = open(self.instance.template_full_path(), 'wb+')
        for chunk in self.files['background_image'].chunks():
            dest.write(chunk)
        dest.close()
        return super(SquareForm, self).save()
    
    class Meta:
        model = Square
        exclude = ('pos_x', 'pos_y', 'issue', 'square_parent',\
                    'coord', 'user', 'status', 'template_name',\
                        'date_finished', 'date_booked')