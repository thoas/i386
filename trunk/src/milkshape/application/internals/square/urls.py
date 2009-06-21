from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('square.views',
    url(r'^fill/(?P<pos_x>[\d]+)/(?P<pos_y>[\d]+)/(?P<issue_slug>[\w]+)/$', 'fill', name='square_fill'),
    url(r'^release/(?P<pos_x>[\d]+)/(?P<pos_y>[\d]+)/(?P<issue_slug>[\w]+)/$', 'release', name='square_release'),
    url(r'^book/(?P<pos_x>[\d]+)/(?P<pos_y>[\d]+)/(?P<issue_slug>[\w]+)/$', 'book', name='square_book'),
    url(r'^template/(?P<pos_x>[\d]+)/(?P<pos_y>[\d]+)/(?P<issue_slug>[\w]+)/$', 'template', name='square_template'),
    url(r'^my_templates/$', 'templates', {'template_name': 'templates.html'}, name='square_templates'),
)