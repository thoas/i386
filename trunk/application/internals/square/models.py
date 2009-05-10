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
    def neighbors_standby(self, square, is_standby=False):
        """docstring for neighbors_standby"""
        neighbors = square.neighbors().keys()
        neighbors.append(str(square.coord))
        from django.db import connection, transaction
        cursor = connection.cursor()
        cursor.execute("UPDATE square_squareopen SET is_standby = %d WHERE coord IN %s"
                            % (int(is_standby), str(tuple(neighbors))))
        transaction.commit_unless_managed()

class AbstractSquare(models.Model):
    pos_x = models.IntegerField(_('pos_x'))
    pos_y = models.IntegerField(_('pos_y'))
    coord = models.CharField(_('coord'), max_length=20, unique=True, blank=True)
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
    background_image_path = models.ImageField(upload_to=settings.UPLOAD_DIR, blank=True, null=True)
    date_booked = models.DateField(_('date_booked'), auto_now_add=True)
    date_finished = models.DateField(_('date_finished'), blank=True, null=True)
    # 1 : full | 0 : booked
    status = models.BooleanField(_('status'))
    
    user = models.ForeignKey(User, verbose_name=_('user'), related_name=_('participations'))
    square_parent = models.ForeignKey('Square', verbose_name=_('square_parent'),\
                        related_name=_('squares_child'), blank=True, null=True)
    template_name = models.CharField(_('template_name'), max_length=150, blank=True, null=True)
    
    objects = SquareManager()

    def __unicode__(self):
        """docstring for __unicode__"""
        return self.coord

    def template_path(self):
        """docstring for template_path"""
        from os.path import join
        return join(settings.TEMPLATE_ROOT, self.template_name)

    def delete(self):
        """docstring for delete"""
        from os import unlink
        from os.path import exists
        template_path = self.template_path()
        if exists(template_path):
            unlink(template_path)
        super(Square, self).delete()

class SquareOpen(AbstractSquare):
    date_created = models.DateField(_('date_created'), auto_now_add=True)
    
    # 0 : can be booked ; 1 : a square has been booked next to
    is_standby = models.BooleanField(_('is_standby'), default=settings.DEFAULT_IS_STANDBY)
    objects = SquareOpenManager()