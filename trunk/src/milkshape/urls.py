from django.conf.urls.defaults import *
from django.conf import settings

from django.views.generic.simple import direct_to_template

from django.contrib import admin
admin.autodiscover()

import os

from gateway import *

urlpatterns = patterns('',
    #url(r'^$', direct_to_template, {'template': 'homepage.html'}, name='home'),
    url(r'^gateway/$', gateway, name='gateway'),
    url(r'^home/$', direct_to_template, {'template': 'homepage.html'}, name='home'),
    url(r'^crossdomain.xml$', direct_to_template, {'template': 'crossdomain.xml'}, name='crossdomain'),
    (r'^about/', include('about.urls')),
    (r'^account/', include('account.urls')),
    (r'^issue/', include('issue.urls')),
    (r'^square/', include('square.urls')),
    (r'^profiles/', include('profiles.urls')),
    (r'^notices/', include('notification.urls')),
    (r'^survey/', include('survey.urls')),
    (r'^announcements/', include('announcements.urls')),
    (r'^admin/(.*)', admin.site.root),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve',
            {'document_root': settings.MEDIA_ROOT}),
    )
