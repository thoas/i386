#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Image
import unittest

from os.path import abspath, dirname, join
from optparse import make_option
from math import ceil

from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User
from django.core.management.base import BaseCommand

from django.conf import settings
from issue.models import Issue
from square.models import Square, SquareOpen
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

ACCT_USERNAME = 'thoas'
ACCT_PASSWORD = 'toto'
BASE_ROOT = dirname(abspath(__file__))

class Command(BaseCommand):
    def handle(self, *args, **options):
        image_root = args[0]
        self.client = Client()
        result = self.client.login(username=ACCT_USERNAME, password=ACCT_PASSWORD)
        if result:
            self.image = Image.open(image_root)
            self.width, self.height = self.image.size
            
            
            """"
            print 'Issue\'s title?'
            title = sys.stdin.readline()
            
            print 'How much squares in x?'
            nb_case_x = sys.stdin.readline()
            
            print 'How much squares in y?'
            nb_case_y = sys.stdin.readline()
            
            print 'How much steps during the scroll?'
            nb_step = sys.stdin.readline()
            
            print 'Creation\'s size?'
            size = sys.stdin.readline()
            
            print 'Margin\'s size?'
            margin = sys.stdin.readline()
            
            print 'How much squares to fill?'
            self.until_fill = sys.stdin.readline()
            
            
            issue = Issue.objects.get_or_create(
                title=title, 
                nb_case_x=nb_case_x, 
                nb_case_y=nb_case_y, 
                nb_step=nb_step,
                size=size,
                margin=margin
            )
            
            
            
            square_open = SquareOpen.objects.get_or_create(
                pos_x=0,
                pos_y=0,
                issue=issue
            )
            
            cpt = 0
            process(c, cpt)
            """
            
            self.issue = Issue.objects.get(slug="5x5")
            self.template_size = self.issue.size + (self.issue.margin * 2)
            
            self.max_square_x = ceil(self.width / self.issue.size)
            self.max_square_y = ceil(self.height / self.issue.size)
            
    def process(self, cpt):  
        squares_open = self.__squares_open()  
        for square_open in squares_open:
            book(square_open.pos_x, square_open.pos_y)
            fill(square_open.pos_x, square_open.pos_y)
            cpt += 1
        if self.__squares_open().count() > 0 and cpt < self.until_fill:
            process()

    def book(self, pos_x, pos_y):
        response = c.get(reverse('square_book', kwargs={
            'pos_x': pos_x,
            'pos_y':pos_y,
            'issue_slug': self.issue.slug
        }))
    
    def __squares_open():
        return squares_open = SquareOpen.objects.filter(
            is_standby=False, 
            issue=self.issue, 
            pos_x__lte=self.max_square_x,
            pos_y__lte=self.max_square_y
        )
    
    def fill(self, pos_x, pos_y):
        left_x = pos_y * self.issue.size
        paste_left_x = 0
        paste_right_x = self.template_size
    
        top_y = pos_x * self.issue.size
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

    
        #response = c.post(reverse('square_fill', kwargs={
        #    'pos_x': pos_x,
        #    'pos_y': pos_y,
        #    'issue_slug': issue.slug
        #}), {'background_image': f})