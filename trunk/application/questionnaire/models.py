# -*- coding: utf-8 -*-
from django.db import models
from django.forms import forms
from django.forms import ModelForm, Textarea
from django.utils.translation import ugettext_lazy as _

PROFESSION_CHOICES = (
    ('DA', 'Directeur Artistique'),
    ('Graphiste', 'Graphiste'),
    ('Illustrateur', 'Illustrateur'),
    ('MD', 'Motion designer'),
    ('Photographe', 'Photographe'),
    ('Etudiant', 'Etudiant'),
    ('Autre', 'Autre')
)

class Enquete(models.Model):
    coordonnees = models.CharField(_('Nom / Prenom / Pseudonyme'), max_length=255, null=False, blank=False)
    age = models.CharField(_('Age'), max_length=255, null=True, blank=True)
    email = models.EmailField(_('Mail'), max_length=255, null=False, blank=False)
    profession = models.CharField(_('Profession'), max_length=20, null=True, blank=True)
    place_to_work = models.CharField(_('Societe'), max_length=255, null=True, blank=True)
    
    question1 = models.TextField(_('Question 1'), null=True, blank=True)
    question2 = models.TextField(_('Question 2'), null=True, blank=True)
    question3 = models.TextField(_('Question 3'), null=True, blank=True)
    question4 = models.TextField(_('Question 4'), null=True, blank=True)
    question5 = models.TextField(_('Question 5'), null=True, blank=True)
    question6 = models.TextField(_('Question 6'), null=True, blank=True)
    question7 = models.TextField(_('Question 7'), null=True, blank=True)
    
    date_created = models.DateTimeField(_('creation date'), auto_now_add=True)
    
class EnqueteForm(ModelForm):
    class Meta:
        model = Enquete
    def __init__(self, *args, **kwargs):
        super(EnqueteForm, self).__init__(*args, **kwargs)
        for i in range(7):
            self.fields['question%d' % (i + 1)].widget.attrs = {'rows': 5, 'cols': 53}
