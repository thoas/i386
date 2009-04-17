from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.db.models.signals import post_save

class Profile(models.Model):

    user = models.ForeignKey(User, unique=True, verbose_name=_('user'))
    name = models.CharField(_('name'), max_length=50, null=True, blank=True)
    about = models.TextField(_('about'), null=True, blank=True)
    location = models.CharField(_('location'), max_length=40, 
                                    null=True, blank=True)
    website = models.URLField(_('website'), null=True, blank=True, 
                                    verify_exists=False)
    nb_invitation = models.IntegerField(_('nb_invitation'), 
                                        default=settings.DEFAULT_NB_INVITATION)
    max_participation = models.IntegerField(_('max_participation'), 
                                            default=settings.DEFAULT_MAX_PARTICIPATION)
    last_updated = models.DateField(_('last_updated'), auto_now_add=True)
    
    def __unicode__(self):
        return self.user.username
    
    def get_absolute_url(self):
        return ('profile_detail', None, {'username': self.user.username})
    get_absolute_url = models.permalink(get_absolute_url)
    
    class Meta:
        verbose_name = _('profile')
        verbose_name_plural = _('profiles')

def create_profile(sender, instance=None, **kwargs):
    if instance is None:
        return
    profile, created = Profile.objects.get_or_create(user=instance)
    
class Invitation(models.Model):
    email = models.EmailField(_('email'), max_length=255)
    first_name = models.CharField(_('first_name'), max_length=150)
    last_name = models.CharField(_('last_name'), max_length=150)
    subject = models.CharField(_('subject'), max_length=255)
    content = models.TextField(_('content'))
    date_sent = models.DateField(_('date_sent'), auto_now_add=True)
    date_burned = models.DateField(_('date_burned'))
    user = models.ForeignKey(User, verbose_name=_('user'))

post_save.connect(create_profile, sender=User)
