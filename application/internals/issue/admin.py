from django.contrib import admin
from issue.models import Issue, ParticipateIssue

class IssueAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title', 'date_finished',)}
    list_display = ('title', 'text_presentation', 'nb_case_x', 'nb_case_y')

admin.site.register(Issue, IssueAdmin)
admin.site.register(ParticipateIssue)