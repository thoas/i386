from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('',
    url(r'^$', direct_to_template, {"template": "about.html"}, name="about"),
    
    url(r'^terms/$', direct_to_template, {"template": "terms.html"}, name="terms"),
    url(r'^privacy/$', direct_to_template, {"template": "privacy.html"}, name="privacy"),
    url(r'^dmca/$', direct_to_template, {"template": "dmca.html"}, name="dmca"),
    
    url(r'^what_next/$', direct_to_template, {"template": "what_next.html"}, name="what_next"),
)
