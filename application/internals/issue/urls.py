from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('issue.gateway',
    url(r'^gateway/$', 'issueGateway')
)

urlpatterns += patterns('issue.views',
    url(r'issues.(?P<format>xml|json|html)$', 'issues', {'template_name': 'issues.html'}, name='issue_list'),
    url(r'^$', 'issues', {'format': 'html', 'template_name': 'issues.html'}, name='issue_list'),
    url(r'^(?P<slug>[\w]+)/$', 'issue', name='issue'),
)