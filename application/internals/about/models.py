from django.db import models
from django.utils.translation import ugettext_lazy as _

TITLE_CHOICES = (
    ('MR', 'Mr.'),
)

class Contact(models.Model):
    name = models.CharField(_('name'), max_length=150)
    email = models.EmailField(_('email'), max_length=255)
    subject = models.CharField(_('subject'), max_length=255, 
                                            null=True, blank=True)
    content = models.TextField(_('content'))
    date_sent = models.DateField(_('date_sent'), auto_now_add=True)
