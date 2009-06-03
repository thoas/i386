#!/usr/bin/env python
# -*- coding: utf-8 -*-
from datetime import datetime
from site import addsitedir

import random
import sys
import Image
import os.path
import re

BASE_ROOT = os.path.abspath(os.path.dirname(__file__))

steps = [800, 400, 200, 100, 50, 25]

files_list = []
for root, dirs, files in os.walk(BASE_ROOT):
    for file in files:
        m = re.match(r"(?P<file_name>[A-Za-z0-9\-_]*)\."
                            + "(?P<extension>gif|jpg|png|tif)$", file) # ça rocks!-
        if m:
            files_list.append({'file_name': m.group('file_name'), \
                'extension': m.group('extension')})

if len(files_list) == 0:
    exit()

for file in files_list:
    im = Image.open(os.path.join(BASE_ROOT, file['file_name'] + '.' + file['extension']))
    for step in steps:
        im.thumbnail((step, step))
        im.save(os.path.join(BASE_ROOT, file['file_name'] + '_' + str(step) + '.' + file['extension']))