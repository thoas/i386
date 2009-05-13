from django.forms import ModelForm
from django import forms
from django.conf import settings
from django.utils.translation import ugettext_lazy as _
from square.models import Square

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

    class Meta:
        model = Square
        exclude = ('pos_x', 'pos_y', 'issue', 'square_parent',\
                    'coord', 'user', 'status', 'template_name', 'date_finished')