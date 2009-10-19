from django.conf.urls.defaults import *

urlpatterns = patterns('account.views',
    # url(r'^email/$', 'email', {'template_name': 'email.html'}, name='acct_email'),
    # 
    # url(r'^signup/(?P<confirmation_key>[a-zA-Z0-9]{10,20})/$', 'signup', {'template_name': 'signup.html'}, name='acct_signup_key'),
    # url(r'^signup/$', 'signup', {'confirmation_key': '', 'template_name': 'signup.html'}, name='acct_signup'),
    # 
    # url(r'^login/$', 'login', {'template_name': 'login.html'}, name='acct_login'),
    # 
    # url(r'^password_change/$', 'password_change', {'template_name': 'password_change.html'}, name='acct_passwd'),
    # 
    # url(r'^invitations/$', 'invitations', {'template_name': 'invitations.html', 'confirmation_key': ''}, name='acct_invitations'),
    # url(r'^invitations/(?P<confirmation_key>[a-zA-Z0-9]{10,20})/$', 'invitations',\
    #     {'template_name': 'invitations.html'}, name='acct_invitations_key'),
    # 
    # url(r'^password_reset/$', 'password_reset', name='acct_passwd_reset'),
    # 
    # url(r'^timezone/$', 'timezone_change', {'template_name': 'timezone_change.html'}, name='acct_timezone_change'),
    # 
    # url(r'^language/$', 'language_change', {'template_name': 'language_change.html'}, name='acct_language_change'),
)

urlpatterns += patterns('',
    # url(r'^logout/$', 'django.contrib.auth.views.logout', {'template_name': 'logout.html'}, name='acct_logout'),
    # 
    # url(r'^confirm_email/(\w+)/$', 'emailconfirmation.views.confirm_email', name='acct_confirm_email'),
)