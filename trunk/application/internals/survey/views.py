from django.http import HttpResponseRedirect
from django.template import RequestContext
from django.shortcuts import render_to_response
from django.core.urlresolvers import reverse

from survey.forms import EnqueteForm

def index(request, template_name='enquete.html'):
    if request.method == 'POST':
        form = EnqueteForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('survey_thanks'))
    else:
        form = EnqueteForm()

    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))