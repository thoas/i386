import socket

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User, AnonymousUser
from django.db.models.signals import post_save
from django.utils.translation import get_language_from_request, ugettext_lazy as _
from django.contrib.sites.models import Site
from django.template.loader import render_to_string
from django.core.urlresolvers import reverse

from timezones.fields import TimeZoneField

class Account(models.Model):
    
    user = models.ForeignKey(User, unique=True, verbose_name=_('user'))
    
    timezone = TimeZoneField(_('timezone'))
    language = models.CharField(_('language'), max_length=10, choices=settings.LANGUAGES, default=settings.LANGUAGE_CODE)
    
    def __unicode__(self):
        return self.user.username

def create_account(sender, instance=None, **kwargs):
    if instance is None:
        return
    account, created = Account.objects.get_or_create(user=instance)

post_save.connect(create_account, sender=User)

class AnonymousAccount(object):
    def __init__(self, request=None):
        self.user = AnonymousUser()
        self.timezone = settings.TIME_ZONE
        if request is not None:
            self.language = get_language_from_request(request)
        else:
            self.language = settings.LANGUAGE_CODE

    def __unicode__(self):
        return "AnonymousAccount"

class InvitationManager(models.Manager):
    """manager for Invitation model"""
    def remain_invitation(self, user):
        """docstring for remain_invitation"""
        return user.get_profile().nb_invitation - self.filter(user=user).count()
    
    def unused_invitations(self, user):
        """docstring for unused_invitation"""
        return self.filter(user=user, email__isnull=True)
    
    def sent_invitations(self, user):
        """docstring for sent_invitations"""
        return self.filter(user=user, email__isnull=False, date_burned__isnull=True)
        
    def users_invited(self, user):
        """docstring for sent_invitations"""
        return self.filter(user=user, date_burned__isnull=False).select_related('user_created')
        
    def send_invitation(self, invitation_instance, user_instance=None, user_profile=None, current_site=None):
        from emailconfirmation.utils import get_send_mail
        send_mail = get_send_mail()
        
        confirmation_key = invitation_instance.confirmation_key
        if current_site is None:
            current_site = Site.objects.get_current()
        activate_url = u"http://%s%s" % (
            unicode(current_site.domain),
            reverse("acct_signup_key", args=(confirmation_key,))
        )
        if user_instance is None:
            user_instance = invitation.user
        
        if user_profile is None:
            user_profile = user_instance.get_profile()
        context = {
            "user": user_instance,
            "user_profile": user_profile,
            "invitation": invitation_instance,
            "activate_url": activate_url,
            "current_site": current_site,
            "confirmation_key": confirmation_key
        }
        
        subject = render_to_string("email_invitation_subject.txt", context)
        message = render_to_string("email_invitation_message.txt", context)
        try:
            send_mail(subject, message, settings.EMAIL_HOST_USER, [invitation_instance.email], priority="high")
        except socket.error, msg:
    		print 'error (%s) for %s' % (msg, invitation_instance.email)

class Invitation(models.Model):
    last_name = models.CharField(_('last_name'), max_length=150, blank=True, null=True)
    first_name = models.CharField(_('first_name'), max_length=150, blank=True, null=True)
    email = models.EmailField(_('email'), max_length=255, blank=True, null=True)
    subject = models.CharField(_('subject'), blank=True, null=True, max_length=255)
    confirmation_key = models.CharField(_('confirmation_key'), max_length=50)
    content = models.TextField(_('content'), blank=True, null=True)
    date_sent = models.DateField(_('date_sent'), auto_now_add=True, blank=True, null=True)
    date_burned = models.DateField(_('date_burned'), null=True, blank=True)
    user = models.ForeignKey(User, verbose_name=_('user'), related_name=_('user'))
    user_created = models.ForeignKey(User, verbose_name=_('user_created'), related_name=_('user_created'), blank=True, null=True)

    objects = InvitationManager()
    def save(self, force_insert=False, force_update=False):
        """override save"""
        super(Invitation, self).save(force_insert, force_update)