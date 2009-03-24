from django.conf.urls.defaults import *

urlpatterns = patterns('gobelins_project.application.questionnaire.views',
    (r'^$', 'index'),
    (r'^thanks/$', 'thanks'),
)