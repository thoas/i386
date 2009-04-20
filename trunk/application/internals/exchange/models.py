from issue.models import Issue
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.db import models

class ExchangeTopic(models.Model):
    issue = models.ForeignKey(Issue, verbose_name=_('issue'))
    title = models.CharField(_('title'), max_length=255)
    date_creation = models.DateField(_('date_creation'),  auto_now_add=True)

class ExchangePost(models.Model):
    exchange_topic = models.ForeignKey(ExchangeTopic, 
                                       verbose_name=_('exchange_topic'))
    exchange_post_parent = models.ForeignKey('ExchangePost', 
                                       verbose_name=_('exchange_post_parent'),
                                            blank=True, null=True)
    content = models.TextField(_('content'))
    user = models.ForeignKey(User, verbose_name=_('user'))
    date_creation = models.DateField(_('date_creation'),  auto_now_add=True)
    date_updated = models.DateField(_('date_updated'),  auto_now_add=True) 