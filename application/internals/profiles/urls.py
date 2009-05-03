from django.conf.urls.defaults import *

urlpatterns = patterns('profiles.views',
    url(r'^$', 'profiles', name='profile_list'),
    url(r'^(?P<username>[\w]+)/$', 'profile', name='profile_detail'),
)
