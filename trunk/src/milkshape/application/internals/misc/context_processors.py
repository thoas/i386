from django.conf import settings

def contact_email(request):
    return {'contact_email': getattr(settings, 'CONTACT_EMAIL', '')}

def site_name(request):
    return {'site_name': getattr(settings, 'SITE_NAME', '')}
    
def upload_hd_url(request):
    return {'upload_hd_url': settings.UPLOAD_HD_URL }

def upload_thumb_url(request):
    return {'upload_thumb_url': settings.UPLOAD_THUMB_URL }
