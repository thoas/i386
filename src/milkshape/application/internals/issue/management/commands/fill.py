#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Image
import sys
import random

from os.path import abspath, dirname, join
from optparse import make_option
from math import ceil

from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User
from django.core.management.base import BaseCommand
from django.template import defaultfilters
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

from issue.models import Issue
from square.models import Square, SquareOpen

RESERVED_USERNAMES = (
    'matthieu benoit lisa camille pierre-alexandre maxime gauthier philippe '
    'florent arnaud keyvan rudy emeline juan emilie claire yohan nadege '
    'barbero john terry julie zoe '
).split()

DEFAULT_PASSWORD = 'toto'

class Command(BaseCommand):
    option_list = BaseCommand.option_list + (
        make_option('--default_password', action='store', dest='default_password', default=DEFAULT_PASSWORD,
            help='Set a default password when users are created'),
    )
    help = "Create an issue with an Image, this script crops it and build layers and thumbs"
    def handle(self, *args, **options):
        image_root = args[0]
        self.accounts = []
        self.client = Client()
        self.image = Image.open(image_root)
        self.width, self.height = self.image.size
        
        
        kwargs = dict((field.verbose_name, sys.stdin.readline())\
                    for field in Issue._meta.fields if field.help_text)
        """
        for field in Issue._meta.fields:
            if field.help_text:
                kwargs[field.verbose_name] = sys.stdin.readline()
        """
        
        print 'How much squares to fill?'
        self.until_fill = sys.stdin.readline()
        
        kwargs['slug'] = defaultfilters.slugify(kwargs['title'])
                    
        self.issue, created = Issue.objects.get_or_create(**kwargs)
        
        square_open, created = SquareOpen.objects.get_or_create(
            pos_x=0,
            pos_y=0,
            issue=self.issue
        )
        
        self.template_size = self.issue.size + (self.issue.margin * 2)
        
        self.max_square_x = ceil(self.width / self.issue.size)
        self.max_square_y = ceil(self.height / self.issue.size)
        
        self.cpt = 0
        for i in range(int(self.until_fill)):
            choice = random.choice(RESERVED_USERNAMES)
            #username = '%s-%s' % (choice, User.objects.make_random_password())
            username = choice
            try:
                user = User.objects.get(username=username)
            except User.DoesNotExist:
                user = User.objects.create_user(username, settings.EMAIL_HOST_USER, options.get('default_password'))
            user.is_staff = True
            user.save()
            self.accounts.append(user)
            
        self.process()
    
    def process(self):
        squares_open = self._squares_open()
        for square_open in squares_open:
            user = random.choice(self.accounts)
            result = self.client.login(username=user.username, password=DEFAULT_PASSWORD)
            if result:
                self.book(square_open.pos_x, square_open.pos_y)
                self.fill(square_open.pos_x, square_open.pos_y)
                self.client.logout()
        if self._squares_open().count() > 0:
            self.process()

    def book(self, pos_x, pos_y):
        response = self.client.get(reverse('square_book', kwargs={
            'pos_x': pos_x,
            'pos_y':pos_y,
            'issue_slug': self.issue.slug
        }))
    
    def _squares_open(self):
        return SquareOpen.objects.filter(
            is_standby=False, 
            issue=self.issue, 
            pos_x__lte=self.max_square_x,
            pos_y__lte=self.max_square_y
        )
    
    def fill(self, pos_x, pos_y):
        left_x = pos_x * self.issue.size
        paste_left_x = 0
        paste_right_x = self.template_size
    
        top_y = pos_y * self.issue.size
        paste_top_y = 0
        paste_bottom_y = self.template_size
    
        if left_x == 0:
            paste_left_x += self.issue.margin
            right_x = left_x + self.issue.size + self.issue.margin
        else:
            left_x -= self.issue.margin
            right_x = left_x + self.template_size
    
        if top_y == 0:
            paste_top_y += self.issue.margin
            bottom_y = top_y + self.issue.size + self.issue.margin
        else:
            top_y -= self.issue.margin
            bottom_y = top_y + self.template_size
    
        if right_x >= self.width:
            right_x -= self.issue.margin
            paste_right_x -= self.issue.margin
    
        if bottom_y >= self.height:
            bottom_y -= self.issue.margin
            paste_bottom_y -= self.issue.margin
    
        crop = self.image.crop((left_x, top_y, right_x, bottom_y))
        print (left_x, top_y, right_x, bottom_y)
        
        paste_image = Image.new('RGB', (self.template_size, self.template_size), 'white')
        print (paste_left_x, paste_top_y, paste_right_x, paste_bottom_y)
        paste_image.paste(crop, (paste_left_x, paste_top_y, paste_right_x, paste_bottom_y))
    
        paste_image_path = join(settings.TMP_ROOT, '%d_%d.tif' % (pos_x, pos_y))
        paste_image.save(paste_image_path, format='TIFF', quality=90)
        
        f = open(paste_image_path)
        response = self.client.post(reverse('square_fill', kwargs={
            'pos_x': pos_x,
            'pos_y': pos_y,
            'issue_slug': self.issue.slug
        }), {'background_image': f})
        
        self.cpt += 1
        if self.cpt >= self.until_fill:
            exit()