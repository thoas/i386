from django.conf.urls.defaults import *

urlpatterns = patterns('gobelins_project.application.survey.views',
    (r'^$', 'index'),
    (r'^thanks/$', 'thanks'),
)