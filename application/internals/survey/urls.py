from django.conf.urls.defaults import *

urlpatterns = patterns('survey.views',
    (r'^$', 'index'),
    (r'^thanks/$', 'thanks'),
)