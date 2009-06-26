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
            print image.__dict__
            exit()
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
            
            
            """
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


def process(c, image, issue):    
    for square_open in squares_open:
        book(c, square_open.pos_x, square_open.pos_y, issue.slug)
        fill(c, square_open.pos_x, square_open.pos_y, issue.slug, image)
    
    if SquareOpen.objects.filter(is_standby=False, issue=self.issue).count() > 0:
        process(c, image, issue)
    
    
def book(c, pos_x, pos_y, issue_slug):
    response = c.get(reverse('square_book', kwargs={
        'pos_x': pos_x, 
        'pos_y':pos_y, 
        'issue_slug': issue_slug
    }))

def fill(c, pos_x, pos_y, issue_slug, image):
    
    response = c.post(reverse('square_fill', kwargs={
        'pos_x': pos_x,
        'pos_y': pos_y,
        'issue_slug': issue_slug
    }), {'background_image': f})