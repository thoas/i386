from django.forms import forms
from django.forms import ModelForm, Textarea
from survey.models import Enquete

class EnqueteForm(ModelForm):
    class Meta:
        model = Enquete
    def __init__(self, *args, **kwargs):
        super(EnqueteForm, self).__init__(*args, **kwargs)
        for i in range(7):
            self.fields['question%d' % (i + 1)].widget.attrs = {'rows': 5, 'cols': 53}