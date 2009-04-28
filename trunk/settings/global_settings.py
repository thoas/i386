import os
import os.path

PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__)) + '/..'
TEMPLATE_ROOT = os.path.join(PROJECT_ROOT, 'templates')
APPLICATION_ROOT = os.path.join(PROJECT_ROOT, 'application')
MEDIA_ROOT = os.path.join(PROJECT_ROOT, 'media')

ADMINS = (
     ('Florent Messa', 'florent.messa@gmail.com'),
     #('Thomas Poblete', 'thomas.pob@gmail.com'),
     #('Arnaud Guiheneuf', 'arnaud.guiheneuf@gmail.com'),
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
    os.path.join(PROJECT_ROOT, 'locale')
)

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# URL that handles the media served from MEDIA_ROOT.
# Example: 'http://media.lawrence.com'
MEDIA_URL = '/media/'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: 'http://foo.com/media/', '/media/'.
ADMIN_MEDIA_PREFIX = '/media/admin/'

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'bk-e2zv3humar79nm=j*bwc=-ymeit(8a20whp3goq4dh71t)s'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',
    'django.middleware.common.CommonMiddleware',    
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'account.middleware.LocaleMiddleware',
    'django.middleware.doc.XViewMiddleware',
    'pagination.middleware.PaginationMiddleware'
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
    
    'notification.context_processors.notification',
    'announcements.context_processors.site_wide_announcements',
    'account.context_processors.account',
    'misc.context_processors.contact_email',
    'misc.context_processors.site_name',
)

INSTALLED_APPS = (
    # included
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.humanize',
    'django_extensions',
    
    # external
    'notification', # must be first
    'emailconfirmation',
    'announcements',
    'pagination',
    'timezones',
    'ajax_validation',
    
    # internal (for now)
    'profiles',
    'account',
    'misc',
    
    'about',
    'survey',
    'django.contrib.admin',
    'square',
    'issue',
    'exchange'

)

ABSOLUTE_URL_OVERRIDES = {
    'auth.user': lambda o: '/profiles/%s/' % o.username,
}

AUTH_PROFILE_MODULE = 'profiles.Profile'
NOTIFICATION_LANGUAGE_MODULE = 'account.Account'

EMAIL_CONFIRMATION_DAYS = 2

SESSION_FILE_PATH = os.path.join(PROJECT_ROOT, 'sessions')

CONTACT_EMAIL = 'sybilline.am@wanadoo.fr'
SITE_NAME = 'u__u'

LOGIN_URL = '/account/login'
LOGOUT_URL = '/account/logout'
LOGIN_REDIRECT_URLNAME = 'what_next'

# File
FILE_UPLOAD_MAX_MEMORY_SIZE = 8621440 # 8.5 MB
FILE_UPLOAD_TEMP_DIR = os.path.join(PROJECT_ROOT, 'tmp')
UPLOAD_ROOT = os.path.join(MEDIA_ROOT, 'upload')

# Default values
DEFAULT_NB_INVITATION = 0
DEFAULT_MAX_PARTICIPATION = 5