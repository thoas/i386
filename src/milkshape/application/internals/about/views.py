# Create your views here.
from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.conf import settings
from django.core.mail import send_mail
from django.core.urlresolvers import reverse

from about.models import Contact
from about.forms import ContactForm
from misc.views import pyamf_format, pyamf_errors, pyamf_success

@pyamf_format
def _contact(request, name, email, subject, content):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            recipients = [admin[1] for admin in settings.ADMINS]
            send_mail(subject, content, email, recipients)
            return pyamf_success()
        return pyamf_errors(form.errors.values()[0])
    return None