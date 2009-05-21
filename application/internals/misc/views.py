try:
    from functools import update_wrapper
except ImportError:
    from django.utils.functional import update_wrapper

import mimeparse

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
            
            content_type = mimeparse.best_match(self.template_mapping.keys(),
                                                request.META['HTTP_ACCEPT'])\
                                                if self.template_mapping else settings.DEFAULT_MIMETYPE
            
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