from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from django.conf import settings

admin.autodiscover()

urlpatterns = patterns('',
    # Example:
    # (r'^gobelins_project/', include('gobelins_project.foo.urls')),

    # Uncomment the admin/doc line below and add 'django.contrib.admindocs' 
    # to INSTALLED_APPS to enable admin documentation:
    (r'^admin/doc/', include('django.contrib.admindocs.urls')),
    
    (r'^media/(?P<path>.*)$', 'django.views.static.serve', \
    {'document_root': settings.MEDIA_ROOT}),

    # Uncomment the next line to enable the admin:
    (r'^admin/(.*)', admin.site.root),
    (r'^survey/', include('gobelins_project.application.survey.urls')),
    (r'', 'gobelins_project.application.survey.views.index'),
)
