#!/usr/bin/env python
# -*- coding: utf-8 -*-
from datetime import datetime
from site import addsitedir
from random import randint

import sys
import Image
import os.path
import re

BASE_ROOT = os.path.abspath(os.path.dirname(__file__))
IMG_ROOT = os.path.join(BASE_ROOT, 'img')

sys.path.insert(0, BASE_ROOT + '/../..')
from settings.include_path import *
from django.core.management import setup_environ
import settings.local_settings
setup_environ(settings.local_settings)

from issue.models import Issue
from square.models import Square

issue, created = Issue.objects.get_or_create(title='300',\
    text_presentation='300',\
        nb_case_x=10, nb_case_y=10, slug='300')

steps = [800, 400, 200, 100, 50, 25]

files_list = []
for root, dirs, files in os.walk(BASE_ROOT):
    for file in files:
        m = re.match(r"(?P<file_name>[A-Za-z0-9\-]*)\."
                            + "(?P<extension>gif|jpg|png|tif)$", file) # ça rocks!-
        if m:
            files_list.append({'file_name': m.group('file_name'), \
                'extension': m.group('extension')})

if len(files_list) == 0:
    exit()

for file in files_list:
    old_name = os.path.join(IMG_ROOT, file['file_name'] + '.' + file['extension'])
    image = Image.open(old_name)
    for step in steps:
        thumb_name = os.path.join(IMG_ROOT, 'thumb',\
            file['file_name'] + '_' + str(step) + '.' + file['extension'])
        if not os.path.exists(thumb_name):
            image.thumbnail((step, step))
            print '%s created' % thumb_name
            image.save(thumb_name, quality=90)

for i in range(issue.nb_case_x):
    for j in range(issue.nb_case_y):
        file = files_list[randint(0, len(files_list) - 1)]
        Square.objects.create(pos_x=i, pos_y=j,\
            background_image_path=file['file_name'] + '.' + file['extension'],\
                issue=issue, date_finished=datetime.now(), status=1)