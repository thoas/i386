try:
    from functools import update_wrapper
except ImportError:
    from django.utils.functional import update_wrapper

import mimeparse

from inspect import getargspec
from django.conf import settings
from django.shortcuts import render_to_response
from django.http import Http404
from django.template import Context
from django.template import RequestContext


class MultiResponse(object):
    def __init__(self, template_mapping={}, allowed_format=settings.ALLOWED_FORMAT,\
                 auto_render=True, request_context=True):
        self.template_mapping = template_mapping
        self.request_context = request_context
        self.allowed_format = allowed_format
        self.auto_render = auto_render

    def __call__(self, view_func):
        def wrapper(request, *args, **kwargs):
            context_dictionary = view_func(request, *args, **kwargs)
            context_instance = self.request_context and RequestContext(request) or Context()
            
            if self.template_mapping:
                content_type = mimeparse.best_match(self.template_mapping.keys(),\
                                    request.META['HTTP_ACCEPT'])
            else:
                content_type = settings.DEFAULT_MIMETYPE
            
            if self.template_mapping.has_key(content_type):
                template_name = self.template_mapping.get(content_type)
            elif kwargs.has_key(settings.FORMAT_STRING) and \
                 kwargs.get(settings.FORMAT_STRING) in self.allowed_format:
                format = kwargs.get(settings.FORMAT_STRING)
                template_name = '%s.%s' % (view_func.__name__, format)
                content_type = settings.ALLOWED_FORMAT.get(format)
            else:
                raise Http404
            
            response = render_to_response(template_name,
                                          context_dictionary,
                                          context_instance=context_instance)
            response['Content-Type'] = "%s; charset=%s" % (content_type, settings.DEFAULT_CHARSET)
            return response
        update_wrapper(wrapper, view_func)
        return wrapper

def pyamf_format(func):
    def wrapped(request, *func_args, **func_kwargs):
        args, varargs, varkw, defaults = getargspec(func)
        datas = request.POST.copy()
        for i in range(len(func_args)):
            datas[args[i + 1]] = func_args[i]
        request.POST = datas
        result = func(request, *func_args, **func_kwargs)
        return result
    return wrapped

def pyamf_errors(errors=[]):
    return {
        'success': False,
        'errors': list(error for error in errors)
    }

def pyamf_success(data=[]):
    return {
        'success': True,
        'data': data
    }