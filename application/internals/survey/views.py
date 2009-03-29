from survey.models import *
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response, get_object_or_404

def index(request):
    if request.method == 'POST':
        form = EnqueteForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect('/survey/thanks/')
    else:
        form = EnqueteForm()

    return render_to_response('survey/enquete.html', {
        'form': form,
    })

def thanks(request):
    return render_to_response('survey/thanks.html')