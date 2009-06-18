# Create your views here.
from pyamf.remoting.gateway.django import DjangoGateway

from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.conf import *
from django.core.urlresolvers import reverse

from about.models import Contact
from about.forms import ContactForm
from misc.utils import get_send_mail as send_mail

def __contact(form):
    form.save()
    subject = form.cleaned_data['subject']
    content = form.cleaned_data['content']
    sender = form.cleaned_data['name']
    email = form.cleaned_data['email']
    
    recipients = [admin[1] for admin in settings.ADMINS]
    
    send_mail(subject, content, sender, recipients)

def _contact(request, name, email, subject, content):
    if request.method == 'POST':
        datas = request.POST.copy()
        
        datas['subject'] = subject
        datas['content'] = content
        datas['name'] = name
        datas['email'] = email
        form = ContactForm(datas)
        if form.is_valid():
            __contact(form)
            return True
        return form.errors['__all__']
    return None

def contact(request, template_name='contact.html'):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            _contact_save(form)
            return HttpResponseRedirect(reverse('contact_thanks'))
    else:
        form = ContactForm()

    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))

services = {
    'about.contact': _contact,
}

aboutGateway = DjangoGateway(services)