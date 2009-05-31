from django.contrib import admin
from account.models import Account, Invitation

admin.site.register(Account)
admin.site.register(Invitation)
