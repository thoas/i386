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
    
    # DateField makes an error on pyamf
    date_created = models.DateTimeField(_('date_creation'), auto_now_add=True)
    date_finished = models.DateTimeField(_('date_finished'), blank=True, null=True)
    max_participation = models.IntegerField(_('max_participation'),\
        default=settings.DEFAULT_MAX_PARTICIPATION)
    slug = models.SlugField(unique=True)
    
    objects = IssueManager()
    
    def values(self):
        """docstring for values"""
        values = {}
        for field in self._meta.fields:
            if hasattr(field, 'values'):
                values[field.name] = field.values()
            else:
                values[field.name] = self.__dict__.get(field.name)
        return values
    
    def __init__(self, *args, **kwargs):
        """docstring for __init__"""
        super(Issue, self).__init__(*args, **kwargs)
        self.size_without_margin = self.size - self.margin
        self.size_with_margin = self.size + self.margin
        self.size_with_double_margin = self.size + self.margin * 2

        self.crop_pos = (
            (0, self.size_without_margin, self.size, self.size), # h_c
            (0, self.size_without_margin, self.margin, self.size), # h_r
            (0, 0, self.margin, self.size), # c_r
            (0, 0, self.margin, self.margin), # l_r
            (0, 0, self.size, self.margin), # l_c
            (self.size_without_margin, 0, self.size, self.margin), # l_l
            (self.size_without_margin, 0, self.size, self.size), # c_l
            (self.size_without_margin, self.size_without_margin, self.size, self.size), # h_l
        )

        self.paste_pos = (
            (self.margin, 0, self.size_with_margin, self.margin), # h_c
            (self.size_with_margin, 0, self.size_with_double_margin, self.margin), # h_r
            (self.size_with_margin, self.margin, self.size_with_double_margin, self.size_with_margin), # c_r
            (self.size_with_margin, self.size_with_margin, self.size_with_double_margin, self.size_with_double_margin), # l_r
            (self.margin, self.size_with_margin, self.size_with_margin, self.size_with_double_margin), # l_c
            (0, self.size_with_margin, self.margin, self.size_with_double_margin), # l_l
            (0, self.margin, self.margin, self.size_with_margin), # c_l
            (0, 0, self.margin, self.margin), # h_l
        )
        
        self.creation_position_crop = (self.margin, self.margin,\
            self.size + self.margin, self.size + self.margin)
        self.creation_position_paste = (0, 0, self.size, self.size)
    
    @property
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