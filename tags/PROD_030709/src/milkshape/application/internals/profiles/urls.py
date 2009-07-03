from django.conf.urls.defaults import *

urlpatterns = patterns('profiles.views',
    url(r'^$', 'profiles', {'template_name': 'profiles.html'}, name='profile_list'),
    url(r'^(?P<username>[\w\-]+)/$', 'profile', {'template_name': 'profile.html'}, name='profile_detail'),
)
