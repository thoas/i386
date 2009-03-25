# -*- coding: utf-8 -*-
from django.db import models
from django.forms import ModelForm
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
    first_name = models.CharField(_('Nom'), max_length=255, null=False, blank=False)
    last_name = models.CharField(_('Prenom'), max_length=255, null=False, blank=False)
    nickname = models.CharField(_('Pseudonyme'), max_length=255, null=True, blank=True)
    age = models.CharField(_('Age'), max_length=255, null=True, blank=True)
    email = models.EmailField(_('Mail'), max_length=255, null=False, blank=False)
    profession = models.CharField(_('Profession'), max_length=20, choices=PROFESSION_CHOICES, null=True, blank=True)
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
