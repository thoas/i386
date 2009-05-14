from django.contrib import admin
from square.models import Square, SquareOpen

class SquareAdmin(admin.ModelAdmin):
    list_display = ('pos_x', 'pos_y', 'issue', 'background_image_name')
    
class SquareOpenAdmin(admin.ModelAdmin):
    list_display = ('pos_x', 'pos_y', 'issue')

admin.site.register(Square, SquareAdmin)
admin.site.register(SquareOpen, SquareOpenAdmin)
