from django.db import models
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
    coordonnees = models.CharField(_('Coordonnees'), max_length=255, null=False, blank=False)
    age = models.CharField(_('Age'), max_length=255, null=True, blank=True)
    email = models.EmailField(_('Mail'), max_length=255, null=False, blank=False)
    profession = models.CharField(_('Profession'), max_length=20, null=True, blank=True)
    place_to_work = models.CharField(_('Societe'), max_length=255, null=True, blank=True)
    
    question1 = models.TextField(_('Question_1'), null=True, blank=True)
    question2 = models.TextField(_('Question_2'), null=True, blank=True)
    question3 = models.TextField(_('Question_3'), null=True, blank=True)
    question4 = models.TextField(_('Question_4'), null=True, blank=True)
    question5 = models.TextField(_('Question_5'), null=True, blank=True)
    question6 = models.TextField(_('Question_6'), null=True, blank=True)
    question7 = models.TextField(_('Question_7'), null=True, blank=True)
    
    date_created = models.DateTimeField(_('creation_date'), auto_now_add=True)
    
    def __unicode__(self):
        return '%s - %s' % (self.coordonnees, self.email)