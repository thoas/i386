from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('square.views',
    url(r'^book-(?P<pos_x>[\d]+)-(?P<pos_y>[\d]+)/$', 'book', name='square_book'),
)