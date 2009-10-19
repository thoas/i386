import sha
import socket

from datetime import datetime, timedelta
from random import random

from django.conf import settings
from django.db import models, IntegrityError
from django.template.loader import render_to_string
from django.core.urlresolvers import reverse
from django.contrib.sites.models import Site
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.core.mail import send_mail

class EmailAddressManager(models.Manager):
    
    def add_email(self, user, email):
        try:
            email_address = self.create(user=user, email=email)
            EmailConfirmation.objects.send_confirmation(email_address)
            return email_address
        except IntegrityError:
            return None
    
    def get_primary(self, user):
        try:
            return self.get(user=user, primary=True)
        except EmailAddress.DoesNotExist:
            return None
    
    def get_users_for(self, email):
        """
        returns a list of users with the given email.
        """
        # this is a list rather than a generator because we probably want to do a len() on it right away
        return [address.user for address in EmailAddress.objects.filter(verified=True, email=email)]
    

class EmailAddress(models.Model):
    
    user = models.ForeignKey(User)
    email = models.EmailField()
    verified = models.BooleanField(default=False)
    primary = models.BooleanField(default=False)
    
    objects = EmailAddressManager()
    
    def set_as_primary(self, conditional=False):
        old_primary = EmailAddress.objects.get_primary(self.user)
        if old_primary:
            if conditional:
                return False
            old_primary.primary = False
            old_primary.save()
        self.primary = True
        self.save()
        self.user.email = self.email
        self.user.save()
        return True
    
    def __unicode__(self):
        return u"%s (%s - %d)" % (self.email, self.user, self.verified)
    
    class Meta:
        unique_together = (
            ("user", "email"),
        )

def create_email_address(sender, instance=None, **kwargs):
    if instance is None:
        return
    email_address, created = EmailAddress.objects.get_or_create(user=instance, email=instance.email, primary=True)
    if created:
        EmailConfirmation.objects.send_confirmation(email_address)

post_save.connect(create_email_address, sender=User)

class EmailConfirmationManager(models.Manager):
    
    def confirm_email(self, confirmation_key):
        try:
            confirmation = self.get(confirmation_key=confirmation_key)
        except self.model.DoesNotExist:
            return None
        if not confirmation.key_expired():
            email_address = confirmation.email_address
            email_address.verified = True
            email_address.set_as_primary(conditional=True)
            email_address.save()
            return email_address
    
    def send_confirmation(self, email_address):
        salt = sha.new(str(random())).hexdigest()[:5]
        confirmation_key = sha.new(salt + email_address.email).hexdigest()
        current_site = Site.objects.get_current()
        activate_url = u"http://%s" % (
            unicode(current_site.domain),
            #reverse("emailconfirmation.views.confirm_email", args=(confirmation_key,))
        )
        context = {
            "user": email_address.user,
            "activate_url": activate_url,
            "current_site": current_site,
            "confirmation_key": confirmation_key,
        }
        subject = render_to_string("emailconfirmation/email_confirmation_subject.txt", context)
        message = render_to_string("emailconfirmation/email_confirmation_message.txt", context)
        try:
            send_mail(subject, message, settings.EMAIL_HOST_USER, [email_address.email])
        except socket.error, msg:
            print 'error (%s) for %s' % (msg, email_address.email)
        return self.create(email_address=email_address, sent=datetime.now(), confirmation_key=confirmation_key)
    
    def delete_expired_confirmations(self):
        for confirmation in self.all():
            if confirmation.key_expired():
                confirmation.delete()

class EmailConfirmation(models.Model):
    
    email_address = models.ForeignKey(EmailAddress)
    sent = models.DateTimeField()
    confirmation_key = models.CharField(max_length=40)
    
    objects = EmailConfirmationManager()
    
    def key_expired(self):
        expiration_date = self.sent + timedelta(days=settings.EMAIL_CONFIRMATION_DAYS)
        return expiration_date <= datetime.now()
    key_expired.boolean = True
    
    def __unicode__(self):
        return u"confirmation for %s" % self.email_address
