from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.db.models.signals import post_save

from square.models import ParticipateSquare

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
    
    @models.permalink
    def get_absolute_url(self):
        return ('profile_detail', None, {'username': self.user.username})
        
    def participations_by_issues(self):
        """docstring for participations"""
        return ParticipateSquare.objects.participations_by_issues(self.user)
    
    class Meta:
        verbose_name = _('profile')
        verbose_name_plural = _('profiles')

def create_profile(sender, instance=None, **kwargs):
    if instance is None:
        return
    profile, created = Profile.objects.get_or_create(user=instance)

post_save.connect(create_profile, sender=User)
