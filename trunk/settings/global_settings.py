import sys
from os.path import abspath, dirname, join
from site import addsitedir

PROJECT_ROOT = abspath(dirname(__file__)) + '/..'
LIB_EXTERNAL_ROOT = join(PROJECT_ROOT, "libs", "externals")
APPLICATION_ROOT = join(PROJECT_ROOT, 'application')


path = addsitedir(LIB_EXTERNAL_ROOT, set())
if path:
    sys.path = list(path) + sys.path
sys.path.insert(0, APPLICATION_ROOT)
sys.path.insert(0, LIB_EXTERNAL_ROOT)
sys.path.insert(0, join(APPLICATION_ROOT, 'internals'))
sys.path.insert(0, join(APPLICATION_ROOT, 'externals'))