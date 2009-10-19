# -*- coding: utf-8 -*-

from os.path import join, dirname, abspath

PROJECT_ROOT = dirname(abspath(__file__)) + '/..'
TEMPLATE_ROOT = join(PROJECT_ROOT, 'templates')
APPLICATION_ROOT = join(PROJECT_ROOT, 'application')

MEDIA_ROOT = join(PROJECT_ROOT, 'media')

ADMINS = (
     ('Florent Messa', 'florent.messa@gmail.com'),
)

MANAGERS = ADMINS

TIME_ZONE = 'Europe/Paris'

LANGUAGE_CODE = 'fr'

LANGUAGE_BIDI = True

LOCALE_PATHS = (
    join(PROJECT_ROOT, 'locale'),
    join(PROJECT_ROOT, 'settings', 'locale')
)

USE_I18N = True

ADMIN_MEDIA_PREFIX = '/admin_media/'

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'account.middleware.LocaleMiddleware',
    'django.middleware.doc.XViewMiddleware',
    'django.middleware.transaction.TransactionMiddleware',
)

ROOT_URLCONF = 'urls'

TEMPLATE_DIRS = (
    TEMPLATE_ROOT,
)

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.core.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.media',
    'django.core.context_processors.request',
    'misc.context_processors.site_name',
)

INSTALLED_APPS = (
    # included
    'django.contrib.sites',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.humanize',
    
    # external
    'emailconfirmation',
    'timezones',
    
    # internal
    'issue',
    'square',
    'profiles',
    'account',
    'misc',
    
    'about',
    'survey',
    'exchange',
    'django.contrib.admin',
)

ABSOLUTE_URL_OVERRIDES = {
    'auth.user': lambda o: '/profiles/%s/' % o.username,
}

AUTH_PROFILE_MODULE = 'profiles.Profile'
NOTIFICATION_LANGUAGE_MODULE = 'account.Account'

EMAIL_CONFIRMATION_DAYS = 2

SESSION_FILE_PATH = join(PROJECT_ROOT, 'sessions')

EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'hello@milkshape.cc'
EMAIL_HOST_PASSWORD = 'development'
EMAIL_PORT = 587
EMAIL_USE_TLS = True
EMAIL_SUBJECT_PREFIX = '[#mılkshape] '
CONTACT_EMAIL = EMAIL_HOST_USER
SITE_NAME = '#milkshape'

LOGIN_URL = '/account/login'
LOGOUT_URL = '/account/logout'
LOGIN_REDIRECT_URLNAME = 'what_next'

# File
FILE_UPLOAD_MAX_MEMORY_SIZE = 8621440 # 8.5 MB
FILE_UPLOAD_TEMP_DIR = join(PROJECT_ROOT, 'tmp')

SECRET_KEY = 'bk-e2zv3humar79nm=j*bwc=-ymeit(8a20whp3goq4dh71t)s'

CLI_ROOT = join(PROJECT_ROOT, 'cli')

UPLOAD_DIR = 'upload'
UPLOAD_HD_DIR = 'hd'
TEMPLATE_DIR = 'template'
UPLOAD_TEMPLATE_DIR = 'template'
UPLOAD_THUMB_DIR = 'thumb'
LAYER_DIR = 'layer'
ISSUES_DIR = 'issues'

TMP_ROOT = join(PROJECT_ROOT, 'tmp')
ISSUES_ROOT = join(MEDIA_ROOT, ISSUES_DIR)

# Default values
DEFAULT_NB_INVITATION = 1
DEFAULT_IS_STANDBY = False
DEFAULT_MAX_PARTICIPATION = 5
DEFAULT_SIZE = 800
DEFAULT_MARGIN = 200
DEFAULT_NB_STEP = 6
DEFAULT_INVITATION_FIRST_NAME = 'Anonymous'
DEFAULT_INVITATION_LAST_NAME = 'Anonymous'
DEFAULT_TIME = 3
DEFAULT_MIMETYPE = 'text/html'
DEFAULT_FORMAT = 'html'

ALLOWED_FORMAT = {
    'json': 'applicaiton/json',
    'xml': 'applicaiton/xml',
    DEFAULT_FORMAT: DEFAULT_MIMETYPE
}
FORMAT_STRING = 'format'
ALLOWED_EXTENSIONS = ('image/jpeg', 'image/tiff', 'image/tif', 'application/octet-stream')