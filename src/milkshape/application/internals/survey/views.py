from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.template import RequestContext
from django.shortcuts import render_to_response

from survey.forms import EnqueteForm

def index(request, template_name, form_class=EnqueteForm):
    if request.method == 'POST':
        form = form_class(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect(reverse('survey_thanks'))
    else:
        form = form_class()

    return render_to_response(template_name, {
        'form': form,
    }, context_instance=RequestContext(request))