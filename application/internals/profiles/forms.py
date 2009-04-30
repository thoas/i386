from django.conf import settings
from django import forms

from profiles.models import Profile, Invitation

try:
    from notification import models as notification
except ImportError:
    notification = None

class ProfileForm(forms.ModelForm):
    
    class Meta:
        model = Profile
        exclude = ('user', 'nb_invitation', 'max_participation')
        
class InvitationForm(forms.ModelForm):

    class Meta:
        model = Invitation
        exclude = ('user', 'date_sent', 'date_burned', 'confirmation_key')