#!/usr/bin/env python
# -*- coding: utf-8 -*-
from datetime import datetime
from site import addsitedir

import random
import sys
import shutil
import Image
from os.path import abspath, dirname, join
from os import walk
import re

from django.core.management import setup_environ
import settings.local_settings
setup_environ(settings.local_settings)

from django.conf import settings
from issue.models import Issue
from square.models import Square, SquareOpen
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User

def main():
    issue, created = Issue.objects.get_or_create(title='100',\
    text_presentation='100',\
        nb_case_x=10, nb_case_y=10, slug='100')

    BASE_ROOT = join(settings.CLI_ROOT, 'push')

    files_list = []
    for root, dirs, files in walk(BASE_ROOT):
        for file in files:
            m = re.match(r"(?P<file_name>[A-Za-z0-9\-]*)\."
                                + "(?P<extension>gif|jpg|png|tif)$", file) # ça rocks!-
            if m:
                files_list.append({
                    'file_name': m.group('file_name'),
                    'extension': m.group('extension')
                })


    if len(files_list) == 0:
        exit()

if __name__ == "__main__":
    main()