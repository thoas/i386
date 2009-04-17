#!/usr/bin/env python
# -*- coding: UTF8 -*-

import sys
import os.path
import Image # PIL
import re
from optparse import OptionParser

__DIR__ = os.path.dirname(os.path.abspath(__file__))
BASE_ROOT = os.path.join(__DIR__, 'base')
DEFAULT_TEST = 'thumbnail'

def thumbnail(files):
    for file in files:
        im = Image.open(os.path.join(BASE_ROOT, file))
        new_location = os.path.join(__DIR__, file)
        if os.path.exists(new_location):
            try:
                os.remove(new_location)
            except WindowsError:
                print '%s est utilisé par un autre programme' % file
        im.save(new_location, quality=95)

def resize(files):
    pass
    
def crop(files):
    for file in files:
        im = Image.open(os.path.join(BASE_ROOT, file))
        # tuple : (100, 100, 800, 800) = 100px à gauche, 100px à partir du haut, jusqu'à 800px en bas et à droite.
        crop = im.crop((100, 100, 800, 800))
        crop.save(os.path.join(__DIR__, file), quality=95)

if __name__ == '__main__':
    usage = "usage: %prog [options]"
    parser = OptionParser(usage)
    parser.add_option("-t", "--type",
            action="store", type="string", dest="type", 
                        default=DEFAULT_TEST, help="Type du test")
    (options, args) = parser.parse_args(sys.argv)

    files_list = []
    for root, dirs, files in os.walk(BASE_ROOT):
        for file in files:
            m = re.match(r"(?P<file_name>[A-Za-z0-9\-]*)\."
                                + "(?P<extension>gif|jpg|png|tif)$", file) # ça rocks!
            if m:
                files_list.append(file)
    
    if options.type == 'thumbnail':
        thumbnail(files_list)
    elif options.type == 'resize':
        resize(files_list)
    elif options.type == 'crop':
        crop(files_list)