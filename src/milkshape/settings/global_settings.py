from os.path import join, dirname, abspath

PROJECT_ROOT = dirname(abspath(__file__)) + '/..'
TEMPLATE_ROOT = join(PROJECT_ROOT, 'templates')
APPLICATION_ROOT = join(PROJECT_ROOT, 'application')

MEDIA_ROOT = join(PROJECT_ROOT, 'media')

ADMINS = (
     ('Florent Messa', 'florent.messa@gmail.com'),
)

MANAGERS = ADMINS

# Local time zone for this installation. Choices can be found here:
# http://www.postgresql.org/docs/8.1/static/datetime-keywords.html#DATETIME-TIMEZONE-SET-TABLE
# although not all variations may be possible on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'Europe/Paris'

# Language code for this installation. All choices can be found here:
# http://www.w3.org/TR/REC-html40/struct/dirlang.html#langcodes
# http://blogs.law.harvard.edu/tech/stories/storyReader$15
LANGUAGE_CODE = 'fr'

LANGUAGE_BIDI = True

LOCALE_PATHS = (
    join(PROJECT_ROOT, 'locale'),
    join(PROJECT_ROOT, 'settings', 'locale')
)

USE_I18N = True

MEDIA_URL = 'http://localhost:8000/media'

ADMIN_MEDIA_PREFIX = '/media/admin/'

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
)

MIDDLEWARE_CLASSES = (
#    'django.middleware.cache.UpdateCacheMiddleware',
    'django.middleware.common.CommonMiddleware',
#    'django.middleware.cache.FetchFromCacheMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'account.middleware.LocaleMiddleware',
    'django.middleware.doc.XViewMiddleware',
    'pagination.middleware.PaginationMiddleware',
    'django.middleware.transaction.TransactionMiddleware',
)

#CACHE_ROOT = join(PROJECT_ROOT, 'cache')
#CACHE_BACKEND = 'file://%s' % CACHE_ROOT

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
    'misc.context_processors.contact_email',
    'misc.context_processors.site_name',
    'misc.context_processors.upload_hd_url',
    'misc.context_processors.upload_thumb_url',
    
    #'notification.context_processors.notification',
    #'announcements.context_processors.site_wide_announcements',
)

INSTALLED_APPS = (
    # included
    'django.contrib.sites',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.humanize',
    
    # external
    'notification', # must be first
    'emailconfirmation',
    'announcements',
    'pagination',
    'timezones',
    'ajax_validation',
    
    # internal (for now)
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
CONTACT_EMAIL = EMAIL_HOST_USER
SITE_NAME = 'milkshape'

LOGIN_URL = '/account/login'
LOGOUT_URL = '/account/logout'
LOGIN_REDIRECT_URLNAME = 'what_next'

# File
FILE_UPLOAD_MAX_MEMORY_SIZE = 8621440 # 8.5 MB
FILE_UPLOAD_TEMP_DIR = join(PROJECT_ROOT, 'tmp')

SECRET_KEY = 'bk-e2zv3humar79nm=j*bwc=-ymeit(8a20whp3goq4dh71t)s'

CLI_ROOT = join(PROJECT_ROOT, 'cli')

UPLOAD_DIR = 'upload'
UPLOAD_ROOT = join(MEDIA_ROOT, UPLOAD_DIR)

UPLOAD_HD_DIR = join(UPLOAD_DIR, 'hd')
UPLOAD_HD_URL = MEDIA_URL + '/' + UPLOAD_DIR
UPLOAD_HD_ROOT = join(MEDIA_ROOT, UPLOAD_HD_DIR)

TEMPLATE_DIR = 'template'
TEMPLATE_ROOT = join(MEDIA_ROOT, TEMPLATE_DIR)

UPLOAD_TEMPLATE_DIR = join(UPLOAD_DIR, TEMPLATE_DIR)
UPLOAD_TEMPLATE_ROOT = join(MEDIA_ROOT, UPLOAD_TEMPLATE_DIR)

UPLOAD_THUMB_DIR = 'thumb'
UPLOAD_THUMB_ROOT = join(UPLOAD_ROOT, UPLOAD_THUMB_DIR)
UPLOAD_THUMB_URL = UPLOAD_HD_URL + '/' + UPLOAD_THUMB_DIR

LAYER_DIR = 'layer'
LAYER_URL = MEDIA_URL + '/' + LAYER_DIR
LAYER_ROOT = join(MEDIA_ROOT, LAYER_DIR)

# Default values
DEFAULT_NB_INVITATION = 1
DEFAULT_IS_STANDBY = False
DEFAULT_MAX_PARTICIPATION = 5
DEFAULT_SIZE = 800
DEFAULT_MARGIN = 200
DEFAULT_NB_STEP = 6
DEFAULT_INVITATION_FIRST_NAME = 'Anonymous'
DEFAULT_INVITATION_LAST_NAME = 'Anonymous'

DEFAULT_MIMETYPE = 'text/html'
FORMAT_STRING = 'format'
DEFAULT_FORMAT = 'html'
ALLOWED_EXTENSIONS = ('image/jpeg', 'image/tiff', 'application/octet-stream')
ALLOWED_FORMAT = {
    'json': 'applicaiton/json',
    'xml': 'applicaiton/xml',
    DEFAULT_FORMAT: DEFAULT_MIMETYPE
}