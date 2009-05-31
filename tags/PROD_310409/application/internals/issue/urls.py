from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template
from django.conf import settings


urlpatterns = patterns('issue.views',
    url(r'^issues.(?P<format>[\w]{3,4})$', 'issues', {'template_name': 'issues.html'}, name='issue_list'),
    url(r'^$', 'issues', {'format': settings.DEFAULT_FORMAT, 'template_name': 'issues.html'}, name='issue_list'),
    
    url(r'^(?P<slug>[\w]+).(?P<format>[\w]{3,4})$', 'issue', {'template_name': 'issue.html'}, name='issue'),
    url(r'^(?P<slug>[\w]+)$', 'issue', {'format': settings.DEFAULT_FORMAT, 'template_name': 'issue.html'}, name='issue'),
    url(r'^gateway/$', 'issueGateway', name='issue_gateway'),
)