#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os.path
import re
import os

BASE_ROOT = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, BASE_ROOT + '/..')

def restore(directory_root):
    """docstring for restore"""
    for root, dirs, files in os.walk(directory_root):
        for file in files:
            m = re.match(r"(?P<filename>[\w\-]+)\.(?P<extension>gif|jpg|png|tif)", file)
            if m:
                os.unlink(os.path.join(directory_root, file))
                print '%s deleted' % file

def main():
    """docstring for main"""
    from settings import global_settings
    restore(global_settings.TEMPLATE_ROOT)
    restore(global_settings.UPLOAD_TEMPLATE_ROOT)
    restore(global_settings.UPLOAD_HD_ROOT)
    restore(global_settings.UPLOAD_THUMB_ROOT)
    restore(global_settings.LAYER_ROOT)

if __name__ == '__main__':
    main()