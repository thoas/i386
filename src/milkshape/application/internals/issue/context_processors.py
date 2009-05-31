from django.conf import settings

def upload_hd_dir(request):
    return {'upload_hd_dir': settings.UPLOAD_HD_URL }