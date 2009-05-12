from django.forms import ModelForm
from django import forms
from square.models import Square

class SquareForm(ModelForm):
#    pos_x = forms.IntegerField(widget=forms.HiddenInput())
    background_image_path = forms.ImageField(required=True)
    class Meta:
        model = Square
        exclude = ('pos_x', 'pos_y', 'issue', 'square_parent',\
                    'coord', 'user', 'status', 'template_name', 'date_finished')