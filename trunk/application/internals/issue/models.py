from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _


class IssueManager(models.Manager):
    """docstring for IssueManager"""
    pass

class Issue(models.Model):
    title = models.CharField(_('title'), max_length=255)
    text_presentation = models.TextField(_('text_presentation'))
    nb_case_x = models.IntegerField(_('nb_case_x'))
    nb_case_y = models.IntegerField(_('nb_case_y'))
    nb_step = models.IntegerField(_('nb_step'), default=settings.DEFAULT_NB_STEP)
    size = models.IntegerField(_('size'), default=settings.DEFAULT_SIZE)
    margin = models.IntegerField(_('margin'), default=settings.DEFAULT_MARGIN)
    date_created = models.DateField(_('date_creation'), auto_now_add=True)
    date_finished = models.DateField(_('date_finished'), blank=True, null=True)
    max_participation = models.IntegerField(_('max_participation'),\
        default=settings.DEFAULT_MAX_PARTICIPATION)
    slug = models.SlugField(unique=True)
    
    objects = IssueManager()
    
    def steps(self):
        """docstring for steps"""
        size = self.size
        steps = []
        for i in range(self.nb_step):
            steps.append(size)
            size /= 2
        return steps
    
    def __unicode__(self):
        """docstring for __unicode__"""
        return self.title

    @models.permalink
    def get_absolute_url(self):
        """docstring for get_absolute_url"""
        return ('issue.views.issue', [str(self.slug)])