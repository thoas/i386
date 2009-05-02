from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('issue.views',
    url(r'^$', 'issues', name='issue_list'),
    url(r'^(?P<title>[\w]+)/$', 'details'),
)