#!/usr/bin/env python
# -*- coding: utf-8 -*-

import Image
import os.path
import shutil

BASE_ROOT = os.path.abspath(os.path.dirname(__file__))
FILE_NAME = 'file.jpg'
FILE_NAME_ROOT = os.path.join(BASE_ROOT, FILE_NAME)
PUSH_ROOT = os.path.join(BASE_ROOT, 'push')

if os.path.exists(PUSH_ROOT):
    shutil.rmtree(PUSH_ROOT)

os.mkdir(PUSH_ROOT)

NB_FILES = 100

def main():
    """docstring for main"""
    for i in range(NB_FILES):
        shutil.copyfile(FILE_NAME_ROOT, os.path.join(PUSH_ROOT, '%d_%s' % (i, FILE_NAME)))

if __name__ == '__main__':
    main()