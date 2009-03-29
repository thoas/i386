#!/usr/bin/env python

import sys
from os.path import abspath, dirname, join
from site import addsitedir

PROJECT_ROOT = abspath(dirname(__file__))
LIB_EXTERNAL_ROOT = join(PROJECT_ROOT, "libs", "externals")
APPLICATION_ROOT = join(PROJECT_ROOT, 'application')


path = addsitedir(LIB_EXTERNAL_ROOT, set())
if path:
    sys.path = list(path) + sys.path
sys.path.insert(0, APPLICATION_ROOT)
sys.path.insert(0, LIB_EXTERNAL_ROOT)
sys.path.insert(0, join(APPLICATION_ROOT, 'internals'))
sys.path.insert(0, join(APPLICATION_ROOT, 'externals'))

from django.core.management import execute_manager

try:
    import settings # Assumed to be in the same directory.
except ImportError:
    import sys
    sys.stderr.write("Error: Can't find the file 'settings.py' in the directory containing %r. It appears you've customized things.\nYou'll have to run django-admin.py, passing it your settings module.\n(If the file settings.py does indeed exist, it's causing an ImportError somehow.)\n" % __file__)
    sys.exit(1)

if __name__ == "__main__":
    execute_manager(settings)
