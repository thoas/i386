from django.http import HttpResponse
from django.utils import simplejson
from django.conf import settings
from django.core.exceptions import ImproperlyConfigured

_inbox_count_sources = None

def inbox_count_sources():
    global _inbox_count_sources
    if _inbox_count_sources is None:
        sources = []
        for path in settings.COMBINED_INBOX_COUNT_SOURCES:
            i = path.rfind('.')
            module, attr = path[:i], path[i+1:]
            try:
                mod = __import__(module, {}, {}, [attr])
            except ImportError, e:
                raise ImproperlyConfigured('Error importing request processor module %s: "%s"' % (module, e))
            try:
                func = getattr(mod, attr)
            except AttributeError:
                raise ImproperlyConfigured('Module "%s" does not define a "%s" callable request processor' % (module, attr))
            sources.append(func)
        _inbox_count_sources = tuple(sources)
    return _inbox_count_sources


def get_send_mail():
    """
    A function to return a send_mail function suitable for use in the app. It
    deals with incompatibilities between signatures.
    """
    # favour django-mailer but fall back to django.core.mail    
    if "mailer" in settings.INSTALLED_APPS:
        from mailer import send_mail
    else:
        from django.core.mail import send_mail as _send_mail
        def send_mail(*args, **kwargs):
            del kwargs["priority"]
            return _send_mail(*args, **kwargs)
    return send_mail

def transform(source, from_type, to_type):
    if not isinstance(source, from_type):
        return source
    else:
        return to_type(transform(x, from_type, to_type)
            for x in source)

def list2tuple(source):
    return transform(source, list, tuple)

def tuple2list(source):
    return transform(source, tuple, list)

class SimpleAjaxException(Exception):pass

def ajax_ok_data(data='', next=None, message=None):
    return ajax_data('ok', data=data, next=next, message=message)

def ajax_fail_data(error='', next=None, message=None):
    return ajax_data('fail', error=error, next=next, message=message)

def ajax_ok(data='', next=None, message=None):
    """
    return a success response
    """

    return json_response(ajax_ok_data(data, next, message))

def ajax_fail(error='', next=None, message=None):
    """
    return an error response
    """

    return json_response(ajax_fail_data(error, next, message))

def json(data, check=False):
    encode = settings.DEFAULT_CHARSET
    if check:
        if not is_ajax_data(data):
            raise SimpleAjaxException, 'Return data should be follow the Simple Ajax Data Format'
    return simplejson.dumps(uni_str(data, encode))

def json_response(data, check=False):
    encode = settings.DEFAULT_CHARSET
    if check:
        if not is_ajax_data(data):
            raise SimpleAjaxException, 'Return data should be follow the Simple Ajax Data Format'
    return HttpResponse(simplejson.dumps(uni_str(data, encode)))

def xml_response(data, check=False):
    encode = settings.DEFAULT_CHARSET
    if check:
        if not is_ajax_data(data):
            raise SimpleAjaxException, 'Return data should be follow the Simple Ajax Data Format'
    return HttpResponse(simplejson.dumps(uni_str(data, encode)))

def ajax_data(response_code, data=None, error=None, next=None, message=None):
    """if the response_code is true, then the data is set in 'data',
    if the response_code is false, then the data is set in 'error'
    """

    r = dict(response='ok', data='', error='', next='', message='')
    if response_code is True or response_code.lower() in ('ok', 'yes', 'true'):
        r['response'] = 'ok'
    else:
        r['response'] = 'fail'
    if data:
        r['data'] = data
    if error:
        r['error'] = error
    if next:
        r['next'] = next
    if message:
        r['message'] = message
    return r

def is_ajax_data(data):
    """Judge if a data is an Ajax data"""

    if not isinstance(data, dict): return False
    for k in data.keys():
        if not k in ('response', 'data', 'error', 'next', 'message'): return False
    if not data.has_key('response'): return False
    if not data['response'] in ('ok', 'fail'): return False
    return True

def uni_str(a, encoding=None):
    if not encoding:
        encoding = settings.DEFAULT_CHARSET
    if isinstance(a, (list, tuple)):
        s = []
        for i, k in enumerate(a):
            s.append(uni_str(k, encoding))
        return s
    elif isinstance(a, dict):
        s = {}
        for i, k in enumerate(a.items()):
            key, value = k
            s[uni_str(key, encoding)] = uni_str(value, encoding)
        return s
    elif isinstance(a, unicode):
        return a
    elif isinstance(a, (int, float)):
        return a
    elif isinstance(a, str) or (hasattr(a, '__str__') and callable(getattr(a, '__str__'))):
        if getattr(a, '__str__'):
            a = str(a)
        return unicode(a, encoding)
    else:
        return a
