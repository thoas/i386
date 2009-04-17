# -*- coding: utf-8 -*-
# Django settings for basic pinax project.

import os

DEBUG = False
TEMPLATE_DEBUG = DEBUG

CONTACT_EMAIL = "feedback@milshape.cc"

DATABASE_ENGINE = 'mysql'    # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = 'gobelins_project'       # Or path to database file if using sqlite3.
DATABASE_USER = 'gobelins_project'             # Not used with sqlite3.
DATABASE_PASSWORD = 'gobelinsrocks'         # Not used with sqlite3.
DATABASE_HOST = ''             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.
DATABASE_OPTIONS = {
   "init_command": "SET storage_engine=INNODB",
}


# local_settings.py can be used to override environment-specific settings
# like database and email that differ between development and production.
try:
    from global_settings import *
except ImportError:
    pass