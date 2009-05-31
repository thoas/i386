from survey.models import Enquete
from django.contrib import admin

class EnqueteAdmin(admin.ModelAdmin):
    list_display = ('coordonnees', 'profession', 'email', 'date_created')

admin.site.register(Enquete, EnqueteAdmin)