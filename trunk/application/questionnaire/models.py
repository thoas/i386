from django.db import models
from django.forms import ModelForm
from django.utils.translation import ugettext_lazy as _

PROFESSION_CHOICES = (
    ('DA', 'Directeur Artistique'),
    ('Graphiste', 'Graphiste'),
    ('Illustrateur', 'Illustrateur'),
    ('MD', 'Motion designer'),
    ('Photographe', 'Photographe'),
    ('Autre', 'Autre')
)

class Enquete(models.Model):
    first_name = models.CharField(_('first name'), max_length=255)
    last_name = models.CharField(_('last name'), max_length=255)
    email = models.CharField(_('email'), max_length=255)
    profession = models.CharField(max_length=20, choices=PROFESSION_CHOICES)
    birth_date = models.DateField(blank=True, null=True)
    
    creation_date = models.DateTimeField(_('creation date'), auto_now_add=True)
    
class EnqueteForm(ModelForm):
    class Meta:
        model = Enquete
