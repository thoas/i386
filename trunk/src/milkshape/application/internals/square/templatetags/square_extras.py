from django import template
register = template.Library()

from square.models import Square

def background_image_thumb_url(square, size):
    return square.background_image_thumb_url(size)

register.filter('background_image_thumb_url', background_image_thumb_url)