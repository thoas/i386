from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _

class Chapter(models.Model):
    title = models.CharField(_('title'), max_length=255)
    text_presentation = models.TextField(_('title'))
    nb_case_x = models.IntegerField(_('nb_case_x'))
    nb_case_y = models.IntegerField(_('nb_case_y'))
    date_creation = models.DateField(_('date_creation'), auto_now_add=True)
    date_finished = models.DateField(_('date_finished'))
    max_participation = models.IntegerField(_('max_participation'))
    
class ParticipateChapter(models.Model):
    user = models.ForeignKey(User, verbose_name=_('user'))
    chapter = models.ForeignKey(Chapter, verbose_name=_('chapter'))