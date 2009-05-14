import StringIO
import logging

from os import unlink, rename
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
        return self.extra(where=['coord IN %s' % str(tuple(str(coord) for coord in square.neighbors().keys()))])\
            .filter(status=1).order_by('pos_x', 'pos_y')

class SquareManager(AbstractSquareManager):
    pass

class SquareOpenManager(AbstractSquareManager):
    def neighbors_standby(self, square, is_standby=False):
        neighbors = square.neighbors().keys()
        neighbors.append(tuple((square.pos_x, square.pos_y)))
        
        from django.db import connection, transaction
        cursor = connection.cursor()
        cursor.execute("UPDATE square_squareopen SET is_standby = %d WHERE coord IN %s"
                            % (int(is_standby), str(tuple(str(neighbor) for neighbor in neighbors))))
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
            self.square_neighbors = dict((tuple((self.pos_x + POS_X[i], self.pos_y + POS_Y[i])), i)\
                for i in range(LEN_POS))
        return self.square_neighbors

def get_filename(instance, filename):
    """docstring for get_filename"""
    return instance.template_name

class Square(AbstractSquare):
    background_image = models.ImageField(upload_to=get_filename, blank=True, null=True)
    date_booked = models.DateField(_('date_booked'), blank=True, null=True)
    date_finished = models.DateField(_('date_finished'), blank=True, null=True)
    # 1 : full | 0 : booked
    status = models.BooleanField(_('status'), default=False)

    user = models.ForeignKey(User, verbose_name=_('user'),\
                        related_name=_('participations'), blank=True, null=True)
    square_parent = models.ForeignKey('Square', verbose_name=_('square_parent'),\
                        related_name=_('squares_child'), blank=True, null=True)
    template_name = models.CharField(_('template_name'),\
                        max_length=150, blank=True, null=True)

    objects = SquareManager()
    
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
    
    @staticmethod
    def image(**kwargs):
        image = Image.new(DEFAULT_IMAGE_MODE, kwargs['size'], DEFAULT_IMAGE_BACKGROUND_COLOR)
        image.paste(kwargs['im_crop'], kwargs['paste_pos'])
        image.save(join(kwargs['directory_root'], kwargs['background_image']), format=FORMAT_IMAGE, quality=90)
        return image
    
    def __build_template(self):
        self.date_booked = datetime.now()
    
        now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
        self.template_name = '%s__x%s_y%s__%s__%s__template.tif' %\
                                (self.user.username, self.pos_x, self.pos_y, self.issue.slug, now)

        image = Image.new(DEFAULT_IMAGE_MODE, (self.issue.size_with_double_margin,\
                                    self.issue.size_with_double_margin), DEFAULT_IMAGE_BACKGROUND_COLOR)

        neighbors_keys = self.neighbors()
        logging.info(neighbors_keys)

        neighbors = Square.objects.neighbors(self)
        logging.info(neighbors)

        # square creation
        for neighbor in neighbors:
            coord_tuple = tuple((neighbor.x, neighbor.y))
            index = neighbors_keys[coord_tuple]
            im = Image.open(neighbor.get_background_image_path())

            logging.info('%s -> %s (%s)' %\
                    (self.issue.crop_pos[index],\
                        self.issue.paste_pos[index], LITERAL[index]))

            crop = im.crop(self.issue.crop_pos[index])
            image.paste(crop, self.issue.paste_pos[index])

        # if square is already created
        if self.background_image:
            image_tmp_path = self.get_background_image_tmp_path()
            if exists(image_tmp_path):
                image_tmp = Image.open(image_tmp_path)
                im.paste(image_tmp, self.issue.creation_position_crop)
            
        image.save(self.get_template_path(), format=FORMAT_IMAGE, quality=90)
        image.filename = self.template_name
        return image
    
    def __build_thumbs(self):
        """docstring for thumbs"""
        template_full_path = self.get_template_full_path()
        rename(join(settings.MEDIA_ROOT, self.background_image.name), template_full_path)
        template_full = Image.open(template_full_path)

        neighbors_keys = self.neighbors()

        # refresh neighbors background_image_name with overlap
        neighbors = Square.objects.neighbors(self)
        for neighbor in neighbors:
            index = neighbors_keys[tuple((neighbor.x, neighbor.y))]
            logging.info(index)

            image = Image.open(neighbor.get_background_image_path())
            logging.info(neighbor.get_background_image_path())

            image.paste(template_full.crop(self.issue.paste_pos[index]), self.issue.crop_pos[index])
            del neighbors_keys[index]
            logging.info('- %d' % index)

        now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
        size =  tuple((self.issue.size, self.issue.size))

        # create square side by side with overlap
        for x, y in neighbors_keys.keys():
            if (x >= 0 and x < self.issue.nb_case_y) and (y >= 0 and y < self.issue.nb_case_x):
                index = neighbors_keys[tuple((x, y))]

                background_image = 'x%s_y%s__%s__%s.tif' %\
                                        (x, y, self.issue.slug, now)

                image = Square.image(
                    size=size,
                    background_image=background_image,
                    im_crop=template_full.crop(self.issue.paste_pos[index]),
                    paste_pos=self.issue.crop_pos[index],
                    directory_root=settings.TMP_ROOT
                )

                logging.info('+ (%d, %d)' % (x, y))

        # create background_image_path with with template_full
        background_image = '%s__x%s_y%s__%s__%s.tif' %\
                                (self.user.username, self.pos_x, self.pos_y, self.issue.slug, now)
        image = Square.image(
            size=size,
            background_image=background_image,
            im_crop=template_full.crop(self.issue.creation_position_crop),
            paste_pos=self.issue.creation_position_paste,
            directory_root=settings.UPLOAD_HD_ROOT
        )
        logging.info('+ %s' % image)

    def save(self, force_insert=False, force_update=False):
        if self.user and not self.status:
            self.template = self.__build_template()
        
        if self.status and self.pk:
            self.date_finished = datetime.now()
        super(Square, self).save(force_insert, force_update)
        
        # now, square saved, template uploaded, we can build thumbs
        if self.status and self.pk:
            self.__build_thumbs()

    def __unicode__(self):
        return self.coord

    def get_template(self):
        return Square.retrieve_template(self.template_name)\
                    if not hasattr(self, 'template') else self.template

    def get_template_path(self):
        return join(settings.TEMPLATE_ROOT, self.template_name)

    def get_template_full_path(self):
        return join(settings.UPLOAD_TEMPLATE_ROOT, self.template_name)
    
    def get_background_image_path(self):
        """docstring for get_background_image_path"""
        return join(settings.UPLOAD_HD_ROOT, self.background_image.name)
    
    def get_background_image_tmp_path(self):
        """docstring for get_template_tmp_path"""
        return join(settings.TMP_ROOT, self.background_image.name)
    
    def get_upload_hd_url(self, size):
        """docstring for get_upload_hd_url"""
        return join(settings.MEDIA_URL, settings.UPLOAD_HD_DIR, '%s_%s'\
                % (str(size), self.background_image.name))

    def delete(self):
        template_path = self.get_template_path()
        if exists(template_path):
            unlink(template_path)
        template_full_path = self.get_template_full_path()
        if exists(template_full_path):
            unlink(template_full_path)
        super(Square, self).delete()

class SquareOpen(AbstractSquare):
    date_created = models.DateField(_('date_created'), auto_now_add=True)

    # 0 : can be booked ; 1 : a square has been booked next to
    is_standby = models.BooleanField(_('is_standby'), default=settings.DEFAULT_IS_STANDBY)
    objects = SquareOpenManager()
        