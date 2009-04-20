from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from issue.models import Issue
from django.utils.translation import ugettext_lazy as _

class Square(models.Model):
    pos_x = models.IntegerField(_('pos_x'))
    pos_y = models.IntegerField(_('pos_y'))
    background_image_path = models.ImageField(upload_to=settings.UPLOAD_ROOT)
    date_booked = models.DateField(_('date_booked'), auto_now_add=True)
    date_finished = models.DateField(_('date_finished'))
    
class ParticipateSquare(models.Model):
    user = models.ForeignKey(User, verbose_name=_('user'))
    square = models.ForeignKey(Square, verbose_name=_('square'))
    
class Compose(models.Model):
    issue = models.ForeignKey(Issue, verbose_name=_('issue'))
    square = models.ForeignKey(Square, verbose_name=_('square'))