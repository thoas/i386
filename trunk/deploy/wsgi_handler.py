import sys
import os

sys.path.append(os.path.dirname(os.path.abspath(__file__)) + "/..")

from settings.global_settings import *
os.environ['DJANGO_SETTINGS_MODULE'] = 'settings.production_settings'

import django.core.handlers.wsgi

application = django.core.handlers.wsgi.WSGIHandler()