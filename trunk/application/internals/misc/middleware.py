from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.http import HttpResponse
from misc.utils import json_response, xml_response, amf_response
from django.conf import settings


class SortOrderMiddleware(object):
    def process_request(self, request):
        request.sort_order = request.GET.get('sort_order')

class FormatMiddleware(object):
    FORMAT = {
        #'application/x-amf': 'amf',
        'application/x-json': 'json',
        'application/xml': 'xml',
        'text/plain': 'html'
    }
    def process_request(self, request):
        format_string = getattr(settings, 'FORMAT_STRING', 'format')
        format = request.GET.get(format_string, self.FORMAT.get(request.META.get('CONTENT_TYPE')))
        if format:
            self.format = format.lower()
        else:
            self.format = getattr(settings, 'DEFAULT_FORMAT', 'html')
        if self.format == 'xmlrpc':
            import xmlrpclib
            p, u = xmlrpclib.getparser()
            p.feed(request.raw_post_data)
            p.close()

            args = u.close()
            if len(args) > 0:
                args = args[0]
                if not isinstance(args, dict):
                    xml = xmlrpclib.dumps(xmlrpclib.Fault(-32400, 'system error: %s' % 'Arguments should be a dict'), methodresponse=1)
                    return HttpResponse(xml, mimetype='text/xml; charset=utf-8')

                old = request.POST._mutable
                request.POST._mutable = True
                for k, v in args.items():
                    request.POST[k] = v
                request.POST._mutable = old
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        self.format = view_kwargs.get('format', self.format)
        self.template_name = view_kwargs.get('template_name', '')
    
    def process_response(self, request, response):
        print response
        if isinstance(response, HttpResponse):
            return response
        elif self.format == 'json':
            return json_response(response)
        elif self.format == 'xml':
            return xml_response(response)
        elif self.format == 'xmlrpc':
            import xmlrpclib
            try:
                xml = xmlrpclib.dumps((response,), methodresponse=1)
            except Exception, e:
                xml = xmlrpclib.dumps(xmlrpclib.Fault(-32400, 'system error: %s' % e), methodresponse=1)
            return HttpResponse(xml, mimetype='text/xml; charset=utf-8')
        elif self.format == 'html':
            if hasattr(request, 'format_processor'):
                return request.format_processor(response)
            else:
                return render_to_response(self.template_name, response,\
                    context_instance=RequestContext(request))
        raise Exception, 'Not support this format [%s]' % self.format