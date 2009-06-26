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
from datetime import datetime
from site import addsitedir

from django.core.management import setup_environ
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

import settings.local_settings
setup_environ(settings.local_settings)

from django.conf import settings
from issue.models import Issue
from square.models import Square, SquareOpen
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

ACCT_USERNAME = 'thoas'
ACCT_PASSWORD = 'toto'

def main(args):
    image_root = args[1]
    c = Client()
    result = c.login(username=ACCT_USERNAME, password=ACCT_PASSWORD)
    if result:
        image = Image.open(image_root)
        print '<- title'
        title = sys.stdin.readline()
        print '<- nb_case_x'
        nb_case_x = sys.stdin.readline()
        print '<- nb_case_y'
        nb_case_y = sys.stdin.readline()
        print '<- nb_step'
        nb_step = sys.stdin.readline()
        print '<- size'
        size = sys.stdin.readline()
        print '<- margin'
        margin = sys.stdin.readline()
        
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
        
        book(c, square_open.pos_x, square_open.pos_y, square_open.issue.slug)
        fill(c, square_open.pos_x, square_open.pos_y, square_open.issue.slug, image)
        
        """

def book(c, pos_x, pos_y, issue_slug):
    response = c.get(reverse('square_book', kwargs={
        'pos_x': pos_x, 
        'pos_y':pos_y, 
        'issue_slug': issue_slug
    }))

def fill(c, pos_x, pos_y, issue_slug, image):
    pass
    
if __name__ == "__main__":
    main(sys.argv)