#!/usr/bin/env python
# -*- coding: utf-8 -*-

import random
import sys
import shutil
import Image
import os
import re
import unittest

os.environ['DJANGO_SETTINGS_MODULE'] = 'local_settings'

from os.path import abspath, dirname, join
from optparse import make_option

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
        c = Client()
        result = c.login(username=ACCT_USERNAME, password=ACCT_PASSWORD)
        if result:
            image = Image.open(image_root)
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
            until_fill = sys.stdin.readline()
            
            
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
            
            process(c, image, issue)
            """
            
            fill(c, 0, 0, Issue.objects.get(slug="5x5"), image)

def process(c, image, issue):    
    for square_open in squares_open:
        book(c, square_open.pos_x, square_open.pos_y, issue)
        fill(c, square_open.pos_x, square_open.pos_y, issue, image)
    
    if SquareOpen.objects.filter(is_standby=False, issue=self.issue).count() > 0:
        process(c, image, issue)

def book(c, pos_x, pos_y, issue):
    response = c.get(reverse('square_book', kwargs={
        'pos_x': pos_x,
        'pos_y':pos_y,
        'issue_slug': issue.slug
    }))

def fill(c, pos_x, pos_y, issue, image):
    template_size = issue.size + issue.margin * 2
    width, height = image.size
    
    left_x = pos_y * issue.size
    paste_left_x = 0
    paste_right_x = template_size
    
    top_y = pos_x * issue.size
    paste_top_y = 0
    paste_bottom_y = template_size
    
    if left_x == 0:
        paste_left_x += issue.margin
        right_x = left_x + issue.size + issue.margin
    else:
        left_x -= issue.margin
        right_x = left_x + template_size
    
    if top_y == 0:
        paste_top_y += issue.margin
        bottom_y = top_y + issue.size + issue.margin
    else:
        top_y -= issue.margin
        bottom_y = top_y + template_size
    
    crop = image.crop((left_x, top_y, right_x, bottom_y))
    print (left_x, top_y, right_x, bottom_y)
    paste_image = Image.new('RGB', (template_size, template_size), 'white')
    print (paste_left_x, paste_top_y, paste_right_x, paste_bottom_y)
    paste_image.paste(crop, (paste_left_x, paste_top_y, paste_right_x, paste_bottom_y))
    
    paste_image_path = join(settings.TMP_ROOT, '%d_%d.jpg' % (pos_x, pos_y))
    paste_image.save(paste_image_path, format='JPEG', quality=90)

    
    #response = c.post(reverse('square_fill', kwargs={
    #    'pos_x': pos_x,
    #    'pos_y': pos_y,
    #    'issue_slug': issue.slug
    #}), {'background_image': f})