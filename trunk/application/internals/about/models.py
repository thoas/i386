from django.db import models
from django.utils.translation import ugettext_lazy as _

class Contact(models.Model):
    email = models.EmailField(_('email'), max_length=255)
    first_name = models.CharField(_('first_name'), max_length=150)
    last_name = models.CharField(_('last_name'), max_length=150)
    subject = models.CharField(_('subject'), max_length=255, 
                                            null=True, blank=True)
    content = models.TextField(_('content'))
    date_sent = models.DateField(_('date_sent'), auto_now_add=True)
