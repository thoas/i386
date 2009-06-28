from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.conf import settings
from django.db.models.signals import post_save

class Profile(models.Model):

    user = models.ForeignKey(User, unique=True, verbose_name=_('user'), related_name=_('profile'))
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
    last_updated = models.DateTimeField(_('last_updated'), auto_now_add=True)
    
    def __unicode__(self):
        return self.user.username

    @models.permalink
    def get_absolute_url(self):
        return ('profile_detail', None, {'username': self.user.username})

    def remain_invitation(self):
        if self.user.participations.filter(status=1).count() < 1:
            return 0
        return self.nb_invitation - self.user.invitations.count()

    def unused_invitations(self):
        return self.user.invitations.filter(email__isnull=True)

    def sent_invitations(self):
        return self.user.invitations.filter(email__isnull=False, date_burned__isnull=True)

    def users_invited(self):
        return self.user.invitations.filter(date_burned__isnull=False)\
                    .select_related('user_created')

    def participations_by_issues(self):
        participations = self.user.participations.select_related('issue').all()
        participations_by_issues = {}
        for participation in participations:
            issue = participation.issue
            if not participations_by_issues.has_key(issue):
                participations_by_issues[issue] = []
            participations_by_issues[issue].append(participation)
        return participations_by_issues
    
    def participations(self):
        return {
            'currents': self.user.participations.select_related('issue').filter(status=False),
            'archives': self.user.participations.select_related('issue').filter(status=True)
        }
    
    class Meta:
        verbose_name = _('profile')
        verbose_name_plural = _('profiles')

def create_profile(sender, instance=None, **kwargs):
    if instance is None:
        return
    profile, created = Profile.objects.get_or_create(user=instance)

post_save.connect(create_profile, sender=User)
