#!/usr/bin/env python
# -*- coding: UTF8 -*-

import sys
import os.path
import Image # PIL
import re

__DIR__ = os.path.dirname(os.path.abspath(__file__))
BASE_ROOT = os.path.join(__DIR__, 'base')

if __name__ == '__main__':
    for root, dirs, files in os.walk(BASE_ROOT):
        for file in files:
            im = Image.open(os.path.join(BASE_ROOT, file))
            
            m = re.match("([A-Za-z0-9\-]*)\.([a-z]{2,3})", file) # ça rocks!
            
            new_location = os.path.join(__DIR__, file)
            if os.path.exists(new_location):
                try:
                    os.remove(new_location)
                except WindowsError:
                    print '%s est utilisé par un autre programme' % file
            im.save(new_location, quality=95)