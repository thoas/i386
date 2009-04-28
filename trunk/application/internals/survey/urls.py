from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('survey.views',
    (r'^$', 'index'),
    url(r'^thanks/$', direct_to_template, {"template": "survey_thanks.html"}, name="survey_thanks"),
)