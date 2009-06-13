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
        self.neighbors_dict = {}

    def neighbors(self, square, force_insert=False):
        # do not hit database
        if not self.neighbors_dict.has_key(square.pk) or force_insert:
            self.neighbors_dict[square.pk] = self.filter(coord__in=list(str(key)\
                for key in square.neighbors.keys()))\
                    .order_by('pos_x', 'pos_y')
        return self.neighbors_dict[square.pk]

class SquareManager(AbstractSquareManager):
    def bulk_create(square_list):
        pass

class SquareOpenManager(AbstractSquareManager):
    def neighbors_standby(self, square, is_standby=False):
        neighbors = square.neighbors.keys()
        neighbors.append(tuple((square.pos_x, square.pos_y)))
        
        logging.info('standby set to %d for %s' % (is_standby, neighbors))
        self.filter(coord__in=list(str(key)\
            for key in neighbors)).update(is_standby=is_standby)
        #from django.db import connection, transaction
        #cursor = connection.cursor()
        #cursor.execute("UPDATE square_squareopen SET is_standby = %d WHERE coord IN %s"
        #                    % (int(is_standby), str(tuple(str(neighbor) for neighbor in neighbors))))
        #transaction.commit_unless_managed()

class AbstractSquare(models.Model):
    pos_x = models.IntegerField(_('pos_x'))
    pos_y = models.IntegerField(_('pos_y'))
    coord = models.CharField(_('coord'), max_length=20, blank=True)
    issue = models.ForeignKey(Issue, verbose_name=_('issue'))

    class Meta:
        abstract = True

    def save(self, force_insert=False, force_update=False):
        self.coord = str((self.pos_x, self.pos_y))
        logging.info('++ %s - %d' % (self.coord, force_insert))
        super(AbstractSquare, self).save(force_insert, force_update)

    @property
    def neighbors(self):
        if not hasattr(self, '_neighbors'):
            self._neighbors = dict((tuple((self.pos_x + POS_X[i], self.pos_y + POS_Y[i])), i)\
                for i in range(LEN_POS))
        return self._neighbors

#def get_filename(instance, filename):
#    """docstring for get_filename"""
#    return instance.template_name

class Square(AbstractSquare):
    # ImageField raises an error in PyAMF
    background_image = models.CharField(max_length=255, blank=True, null=True)
    date_booked = models.DateTimeField(_('date_booked'), blank=True, null=True)
    date_finished = models.DateTimeField(_('date_finished'), blank=True, null=True)
    # 1 : full | 0 : booked
    status = models.BooleanField(_('status'), default=0)

    user = models.ForeignKey(User, verbose_name=_('user'),\
                        related_name=_('participations'), blank=True, null=True)
    # PyAMF ERROR
    # square_parent = models.ForeignKey('Square', verbose_name=_('square_parent'),\
    #                    related_name=_('squares_child'), blank=True, null=True)
    template_name = models.CharField(_('template_name'),\
                        max_length=150, blank=True, null=True)

    objects = SquareManager()
    
    def __init__(self, *args, **kwargs):
        self._layer_dict = {}
        super(Square, self).__init__(*args, **kwargs)

    @staticmethod
    def buffer(template_image):
        buffer = StringIO.StringIO()
        template_image.save(buffer, format=FORMAT_IMAGE, quality=QUALITY_IMAGE)
        return buffer

    def generate_thumbs(self, image):
        thumbs = {}
        steps = self.issue.steps
        
        for step in steps:
            image_clone = image.copy()
            width = height = step
            image_clone.thumbnail((width, height))
            thumb_path = join(self.issue.upload_thumb_path(), '%s_%s.%s'\
                            % (str(step), self.background_image, THUMB_EXTENSION_IMAGE))
            logging.info(thumb_path)

            try:
                image_clone.save(thumb_path, format=THUMB_FORMAT_IMAGE, quality=QUALITY_IMAGE)
            except IOError, error:
                logging.error('%s', error)
            self.build_layer(image_clone, step)
            
        return thumbs
    
    def size(self, step):
        max_width = max_height = self.issue.size

        size_x = self.issue.nb_case_x * step
        size_y = self.issue.nb_case_y * step

        if size_x > self.issue.size:
            size_x = max_width
        
        if size_y > self.issue.size:
            size_y = max_height
        return size_x, size_y
    
    def build_layer(self, image, step):        
        width = height = step

        size_x, size_y = self.size(step)
        
        # layerable image
        layer_path = self.layer_path(step)
        
        # juanito
        if not exists(layer_path):
            layer = Image.new(DEFAULT_IMAGE_MODE, (size_x, size_y),\
                        DEFAULT_IMAGE_BACKGROUND_COLOR)
        else:
            layer = Image.open(layer_path)
            logging.debug('layer exists %s' % layer_path)
        
        indent_x = (self.pos_x * step) / size_x
        indent_y = (self.pos_y * step) / size_y
        
        x = (self.pos_y * step) - (indent_y * size_y)
        y = (self.pos_x * step) - (indent_x * size_x)
        
        layer.paste(image, (x, y, x + height, y + width))
        
        logging.info('(%d, %d) -> layer position (%d, %d)' % (self.pos_x, self.pos_y, x, y))
        
        try:
            logging.debug(layer_path)
            layer.save(layer_path, format=THUMB_FORMAT_IMAGE, quality=QUALITY_IMAGE)
        except IOError, error:
            logging.error('%s', error)
    
    def build_template(self):
        self.date_booked = datetime.now()
    
        self.template_name = self.formatted_background_image

        image = Image.new(DEFAULT_IMAGE_MODE, (self.issue.size_with_double_margin,\
                    self.issue.size_with_double_margin), DEFAULT_IMAGE_BACKGROUND_COLOR)

        neighbors_keys = self.neighbors
        logging.info(neighbors_keys)

        neighbors = Square.objects.neighbors(self)
        logging.info(neighbors)

        # square creation
        for neighbor in neighbors:
            coord_tuple = tuple((neighbor.pos_x, neighbor.pos_y))
            index = neighbors_keys[coord_tuple]
            im = Image.open(neighbor.background_image_path())

            logging.debug('%s -> %s (%s)' %\
                    (self.issue.crop_pos[index],\
                        self.issue.paste_pos[index], LITERAL[index]))

            crop = im.crop(self.issue.crop_pos[index])
            image.paste(crop, self.issue.paste_pos[index])

        # if square is already created, append the background to the template
        if self.background_image:
            image_tmp_path = self.background_image_path()
            if exists(image_tmp_path):
                image_tmp = Image.open(image_tmp_path)
                logging.debug('background already exists, paste image %s' % image_tmp_path)
                image.paste(image_tmp, self.issue.creation_position_crop)
        
        image.save(self.template_path(), format=FORMAT_IMAGE, quality=QUALITY_IMAGE)
        image.filename = self.template_name
        return image
    
    def populate_neighbors(self, template_full):
        """docstring for thumbs"""
        
        # refresh neighbors background_image_name with overlap
        neighbors_keys = self.neighbors
        neighbors = Square.objects.neighbors(self)
        
        logging.debug('neighbors : %s' % neighbors)
        for neighbor in neighbors:
            neighbor_current_key = tuple((neighbor.pos_x, neighbor.pos_y))
            index = neighbors_keys[neighbor_current_key]
            neighbor_path = neighbor.background_image_path()
            
            logging.info('rebuilding %s' % neighbor_path)
            image = Image.open(neighbor_path)
            image.paste(template_full.crop(self.issue.paste_pos[index]), self.issue.crop_pos[index])
            
            image.save(neighbor_path, format=image.format, quality=QUALITY_IMAGE)
            
            # delete all thumbs to recreate them
            neighbor.generate_thumbs(image)
            
            del neighbors_keys[neighbor_current_key]
            
            logging.info('- %d' % index)
        
        logging.info('populate %s' % neighbors_keys.keys())
        
        # create square side by side with overlap
        for x, y in neighbors_keys.keys():
            if (x >= 0 and x < self.issue.nb_case_y) and (y >= 0 and y < self.issue.nb_case_x):
                index = neighbors_keys[tuple((x, y))]
                
                # create square in database with no user set
                # thought INSERT ... INTO VALUES ((...), (...))
                new_square = Square.objects.create(
                    pos_x=x,
                    pos_y=y,
                    issue=self.issue
                )
                
                new_square_open = SquareOpen.objects.create(
                    pos_x=x,
                    pos_y=y,
                    issue=self.issue
                )
                
                image, thumbs = new_square.build_background_image(template_full.crop(self.issue.paste_pos[index]),\
                                    self.issue.crop_pos[index])
                
    def save(self, force_insert=False, force_update=False):
        if self.user:
            if not self.status:
                self._template = self.build_template()
        else:
            self.background_image = self.formatted_background_image
        
        if self.pk and self.status:
            self.date_finished = datetime.now()
            self.background_image = self.formatted_background_image
        
        super(Square, self).save(force_insert, force_update)
        
        # now, square saved, template uploaded, we can build thumbs and update neighbors
        # square is mark as filled and has a pk
        if self.status and self.pk:
            template_full_path = self.template_full_path()
            
            template_full = Image.open(template_full_path)

            # create background_image_path with with template_full 
            image, thumbs = self.build_background_image(template_full.crop(self.issue.creation_position_crop),\
                                self.issue.creation_position_paste)
            
            # update neighbors with overlap
            self.populate_neighbors(template_full)

    def build_background_image(self, im_crop, paste_pos):
        image = Image.new(DEFAULT_IMAGE_MODE, (self.issue.size, self.issue.size), DEFAULT_IMAGE_BACKGROUND_COLOR)
        image.paste(im_crop, paste_pos)
        image.save(self.background_image_path(),\
                        format=FORMAT_IMAGE, quality=QUALITY_IMAGE)
        image.name = self.formatted_background_image

        logging.info(self.background_image_path())
        return image, self.generate_thumbs(image)
    
    def __unicode__(self):
        return self.coord

    def delete(self):
        super(Square, self).delete()
    
    def template(self):
        if not hasattr(self, '_template'):
            self._template = Image.open(self.template_path())
            self._template.filename = self.template_name
        return self._template

    def template_path(self):
        return join(self.issue.template_path(), self.template_name)

    def template_full_path(self):
        return join(self.issue.upload_template_path(), self.template_name)
    
    def background_image_path(self):
        """docstring for get_background_image_path"""
        return join(self.issue.upload_hd_path(), self.background_image)
    
    def layer_name(self, step):
        if not self._layer_dict.has_key(step):
            x, y = self.pos(step)
            self._layer_dict[step] = '%d_%d__%d__%s.%s' % (x, y, step, self.issue.slug, THUMB_EXTENSION_IMAGE)
        return self._layer_dict[step]
    
    def pos(self, step):
        size_x, size_y = self.size(step)
        x = self.pos_x * step / size_x
        y = self.pos_y * step / size_y
        return x, y
    
    def layer_path(self, step):
        return join(self.issue.layer_path(), self.layer_name(step))
    
    def get_background_image_thumb_path(self, size):
        return join(self.issue.upload_thumb_path(), '%s_%s' % (size, self.background_image))
    
    def background_image_thumb_url_step(self, size):
        return '%s/%d_%s.%s' % (self.issue.upload_thumb_url(), size, self.background_image, THUMB_EXTENSION_IMAGE)
    
    def layer_url(self, step):
        return '%s/%s' % (self.issue.layer_url(), self.layer_name(step))

    @property 
    def background_image_thumb_url(self):
        return self.issue.upload_thumb_url() + '/' + self.background_image
    
    @property
    def formatted_background_image(self):
        if not hasattr(self, '_formatted_background_image'):
            now = datetime.now().strftime('%Y-%m-%d--%H-%M-%S')
            self._formatted_background_image = 'x%s_y%s__%s__%s.%s' %\
                                    (self.pos_x, self.pos_y, self.issue.slug, now, EXTENSION_IMAGE)
            if self.user:
                self._formatted_background_image = '%s__%s'\
                    % (self.user.username, self.formatted_background_image)
        return self._formatted_background_image
    
    @property
    def layers(self):
        if not hasattr(self, '_layers'):
            self._urls = {}
            for step in self.issue.steps:
                pos_x, pos_y = self.pos(step)
                self._urls[step] = {
                    'url': self.layer_url(step), 
                    'pos_x': pos_x, 
                    'pos_y': pos_y
                }
        return self._urls
    
    @property
    def neighbors_keys(self):
        return list(({'pos_x': pos_x, 'pos_y': pos_y}) for pos_x, pos_y in self.neighbors)

class SquareOpen(AbstractSquare):
    date_created = models.DateTimeField(_('date_created'), auto_now_add=True)

    # 0 : can be booked ; 1 : a square has been booked next to
    is_standby = models.BooleanField(_('is_standby'), default=settings.DEFAULT_IS_STANDBY)
    objects = SquareOpenManager()
        