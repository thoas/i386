import socket

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.utils.translation import get_language_from_request, ugettext_lazy as _
from django.contrib.sites.models import Site
from django.template.loader import render_to_string
from django.core.urlresolvers import reverse

from timezones.fields import TimeZoneField

class Account(models.Model):
    
    user = models.ForeignKey(User, unique=True, verbose_name=_('user'), related_name=_('account'))
    timezone = TimeZoneField(_('timezone'))
    language = models.CharField(_('language'), max_length=10, choices=settings.LANGUAGES, default=settings.LANGUAGE_CODE)
    
    def __unicode__(self):
        return self.user.username

def create_account(sender, instance=None, **kwargs):
    if instance is None:
        return
    account, created = Account.objects.get_or_create(user=instance)

post_save.connect(create_account, sender=User)

class InvitationManager(models.Manager):
    '''manager for Invitation model'''

    def send_invitation(self, invitation_instance):
        from emailconfirmation.utils import get_send_mail
        send_mail = get_send_mail()
        
        confirmation_key = invitation_instance.confirmation_key
        
        current_site = Site.objects.get_current()
        activate_url = u'http://%s%s' % (
            unicode(current_site.domain),
            reverse('acct_signup_key', args=(confirmation_key,))
        )
        
        context = {
            'user': invitation_instance.user,
            'invitation': invitation_instance,
            'activate_url': activate_url,
            'current_site': current_site,
            'confirmation_key': confirmation_key
        }
        
        subject = render_to_string('email_invitation_subject.txt', context)
        message = render_to_string('email_invitation_message.txt', context)
        try:
            send_mail(subject, message, settings.EMAIL_HOST_USER, [invitation_instance.email], priority='high')
        except socket.error, msg:
            print 'error (%s) for %s' % (msg, invitation_instance.email)

class Invitation(models.Model):
    email = models.EmailField(_('email'), max_length=255, blank=True, null=True)
    confirmation_key = models.CharField(_('confirmation_key'), max_length=50)
    content = models.TextField(_('content'), blank=True, null=True)
    date_sent = models.DateTimeField(_('date_sent'), auto_now_add=True, blank=True, null=True)
    date_burned = models.DateTimeField(_('date_burned'), null=True, blank=True)
    user = models.ForeignKey(User, verbose_name=_('user'), related_name=_('invitations'))
    user_created = models.ForeignKey(User, verbose_name=_('user_created'), related_name=_('invitations_created'), blank=True, null=True)

    objects = InvitationManager()
    def save(self, force_insert=False, force_update=False):
        '''override save'''
        if self.email and not date_burned:
            Invitation.objects.send_invitation(self)
        super(Invitation, self).save(force_insert, force_update)