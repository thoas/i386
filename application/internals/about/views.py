# Create your views here.
from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.conf import *
from django.core.urlresolvers import reverse

from about.models import Contact
from about.forms import ContactForm

def contact(request, template_name='contact.html'):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            form.save()
            subject = form.cleaned_data['subject']
            content = form.cleaned_data['content']
            sender = form.cleaned_data['name']
            
            recipients = [admin[1] for admin in settings.ADMINS]
            
            from django.core.mail import send_mail
            send_mail(subject, content, sender, recipients)
            
            return HttpResponseRedirect(reverse('contact_thanks'))
    else:
        form = ContactForm()

    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))
