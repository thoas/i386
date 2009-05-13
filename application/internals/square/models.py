import StringIO

from os import unlink
from os.path import join, exists
from PIL import Image
from datetime import datetime

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django import forms
from django.utils.translation import ugettext_lazy as _

from issue.models import Issue
from square.constance import *

class AbstractSquareManager(models.Manager):
    def __init__(self):
        super(AbstractSquareManager, self).__init__()

    def neighbors(self, square):
        return self.extra(where=['coord IN %s' % str(tuple(square.neighbors().keys()))])\
            .filter(status=1).order_by('pos_x', 'pos_y')

class SquareManager(AbstractSquareManager):
    pass

class SquareOpenManager(AbstractSquareManager):
    def neighbors_standby(self, square, is_standby=False):
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
        self.coord = str((self.pos_x, self.pos_y))
        super(AbstractSquare, self).save(force_insert, force_update)

    def neighbors(self):
        if not hasattr(self, 'square_neighbors'):
            self.square_neighbors = dict((str((self.pos_x + POS_X[i], self.pos_y + POS_Y[i])), i)\
                for i in range(LEN_POS))
        return self.square_neighbors
    
    @staticmethod
    def retrieve_template(template_name):
        template_path = join(settings.TEMPLATE_ROOT, template_name)
        if not exists(template_path):
            return False
        template = Image.open(template_path)
        template.filename = template_name
        return template

    @staticmethod
    def buffer(template_image):
        buffer = StringIO.StringIO()
        template_image.save(buffer, format=FORMAT_IMAGE, quality=90)
        return buffer

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
    
    def save(self, force_insert=False, force_update=False):
        if force_insert:
            now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
            self.template_name = '%s__x%s_y%s__%s__template.tif' %\
                                    (self.user.username, self.pos_x, self.pos_y, now)

            image = Image.new('RGB', (self.issue.size_with_double_margin,\
                                        self.issue.size_with_double_margin), 'white')

            neighbors_key = self.neighbors()
            neighbors = Square.objects.neighbors(self)

            # creation d'un square
            for neighbor in neighbors:
                index = neighbors_key[neighbor.coord]
                im = Image.open(neighbor.background_image_path.path)

                print '%s -> %s (%s)' % (self.issue.crop_pos[index], self.issue.paste_pos[index], LITERAL[index])
                crop = im.crop(self.issue.crop_pos[index])
                image.paste(crop, self.issue.paste_pos[index])

            image.save(self.template_path(), format=FORMAT_IMAGE, quality=90)
            image.filename = self.template_name
            self.template = image
        if self.status:
            self.date_finished = datetime.now()
        super(Square, self).save(force_insert, force_update)

    def __unicode__(self):
        return self.coord

    def get_template(self):
        return Square.objects.retrieve_template(self.template_name)\
                    if not self.template else self.template

    def template_path(self):
        return join(settings.TEMPLATE_ROOT, self.template_name)

    def delete(self):
        template_path = self.template_path()
        if exists(template_path):
            unlink(template_path)
        super(Square, self).delete()

class SquareOpen(AbstractSquare):
    date_created = models.DateField(_('date_created'), auto_now_add=True)

    # 0 : can be booked ; 1 : a square has been booked next to
    is_standby = models.BooleanField(_('is_standby'), default=settings.DEFAULT_IS_STANDBY)
    objects = SquareOpenManager()
