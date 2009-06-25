# -*- coding: utf-8 -*-

from os.path import dirname, abspath

SITE_ID = 1
DEBUG = True
TEMPLATE_DEBUG = DEBUG
EMAIL_DEBUG = DEBUG

MEDIA_URL = 'http://localhost:8000/media'

DATABASE_ENGINE = 'sqlite3'    # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = dirname(abspath(__file__)) + '/../dev.db'        # Or path to database file if using sqlite3.
#TEST_DATABASE_NAME = dirname(abspath(__file__)) + '/../test_dev.db' 
DATABASE_USER = ''             # Not used with sqlite3.
DATABASE_PASSWORD = ''         # Not used with sqlite3.
DATABASE_HOST = ''             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = ''             # Set to empty string for default. Not used with sqlite3.
if DATABASE_ENGINE == 'mysql':
    DATABASE_OPTIONS = {
       "init_command": "SET storage_engine=INNODB",
    }

# local_settings.py can be used to override environment-specific settings
# like database and email that differ between development and production.
try:
    from global_settings import *
    
    INTERNAL_IPS = ('127.0.0.1',)

    DEBUG_TOOLBAR_PANELS = (
        'debug_toolbar.panels.version.VersionDebugPanel',
        'debug_toolbar.panels.timer.TimerDebugPanel',
        'debug_toolbar.panels.settings_vars.SettingsVarsDebugPanel',
        'debug_toolbar.panels.headers.HeaderDebugPanel',
        'debug_toolbar.panels.request_vars.RequestVarsDebugPanel',
        'debug_toolbar.panels.template.TemplateDebugPanel',
        'debug_toolbar.panels.sql.SQLDebugPanel',
        'debug_toolbar.panels.logger.LoggingPanel',
    )
    
	
    DEBUG_TOOLBAR_CONFIG = {
        'INTERCEPT_REDIRECTS': False
    }
    
    MIDDLEWARE_CLASSES = ('debug_toolbar.middleware.DebugToolbarMiddleware',) + MIDDLEWARE_CLASSES
    INSTALLED_APPS += ('debug_toolbar', 'django_extensions',)
except ImportError:
    pass