from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('square.views',
    url(r'^(?P<action>book|release|fill)/(?P<pos_x>[\d]+)/(?P<pos_y>[\d]+)/(?P<issue_slug>[\w]+)/$', 'square', name='square'),
    url(r'^template/(?P<template>[A-Za-z-\._0-9]+)/$', 'template', name='square_template'),
    url(r'^my_templates/$', 'templates', name='square_templates'),
)