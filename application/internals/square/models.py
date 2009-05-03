from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from issue.models import Issue
from django.utils.translation import ugettext_lazy as _
from square.constance import *

class AbstractSquareManager(models.Manager):
    def __init__(self):
        """docstring for __init__"""
        super(AbstractSquareManager, self).__init__()

    def neighbors(self, square):
        """docstring for neighbor"""
        return self.extra(where=['coord IN %s' % str(tuple(square.neighbors().keys()))])\
            .filter(status=1).order_by('pos_x', 'pos_y')

class SquareManager(AbstractSquareManager):
    pass

class SquareOpenManager(AbstractSquareManager):
    pass

class AbstractSquare(models.Model):
    pos_x = models.IntegerField(_('pos_x'))
    pos_y = models.IntegerField(_('pos_y'))
    coord = models.CharField(_('coord'), max_length=20, unique=True)
    issue = models.ForeignKey(Issue, verbose_name=_('issue'))

    class Meta:
        abstract = True

    def save(self, force_insert=False, force_update=False):
        """docstring for save"""
        self.coord = str((self.pos_x, self.pos_y))
        super(AbstractSquare, self).save(force_insert, force_update)

    def neighbors(self):
        """docstring for neighbors"""
        if not hasattr(self, 'square_neighbors'):
            self.square_neighbors = dict((str((self.pos_x + POS_X[i], self.pos_y + POS_Y[i])), i)\
                for i in range(LEN_POS))
        return self.square_neighbors

class Square(AbstractSquare):
    background_image_path = models.ImageField(upload_to=settings.UPLOAD_ROOT, blank=True, null=True)
    date_booked = models.DateField(_('date_booked'), auto_now_add=True)
    date_finished = models.DateField(_('date_finished'), blank=True, null=True)
    # 1 : full | 0 : booked
    status = models.BooleanField(_('status'))
    
    objects = SquareManager()

    def __unicode__(self):
        """docstring for __unicode__"""
        return self.coord

class SquareOpen(AbstractSquare):
    date_created = models.DateField(_('date_created'), auto_now_add=True)
    objects = SquareOpenManager()
    
class ParticipateSquare(models.Model):
    user = models.ForeignKey(User, verbose_name=_('user'))
    square = models.ForeignKey(Square, verbose_name=_('square'))