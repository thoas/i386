#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path
import re

from os.path import join, dirname, abspath
from os import unlink, walk

BASE_ROOT = abspath(dirname(__file__))
sys.path.insert(0, BASE_ROOT + '/..')

def restore(directory_root):
    """docstring for restore"""
    for root, dirs, files in walk(directory_root):
        for file in files:
            m = re.match(r"(?P<filename>[\w\-]+)\.(?P<extension>gif|jpg|png|tif)", file)
            if m:
                unlink(join(root, file))
                print '%s deleted' % file

def main():
    """docstring for main"""
    from settings import global_settings
    restore(global_settings.ISSUES_ROOT)

if __name__ == '__main__':
    main()