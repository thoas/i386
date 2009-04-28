from django.conf.urls.defaults import *
from django.views.generic.simple import direct_to_template

urlpatterns = patterns('',
    url(r'^$', direct_to_template, {"template": "about.html"}, name="about"),
    
    url(r'^terms/$', direct_to_template, {"template": "terms.html"}, name="terms"),
    url(r'^privacy/$', direct_to_template, {"template": "privacy.html"}, name="privacy"),
    
    url(r'^what_next/$', direct_to_template, {"template": "what_next.html"}, name="what_next"),
    url(r'^thanks/$', direct_to_template, {"template": "contact_thanks.html"}, name="contact_thanks"),
    url(r'^contact/$', 'about.views.contact', name='contact'),
)
