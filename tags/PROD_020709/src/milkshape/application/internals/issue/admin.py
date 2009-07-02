from django.contrib import admin
from django.conf import settings

from django import forms
from StringIO import StringIO
from issue.models import Issue

class IssueAdminForm(forms.ModelForm):
    thumb = forms.ImageField(required=False)
    
    class Meta:
        model = Issue
    
    def save(self, commit=True):
        """docstring for save"""
        # set name of thumb first, we cannot use ImageField because of PyAMF bug
        if self.files.has_key('thumb'):
            file_data = self.files['thumb']
            self.cleaned_data['thumb'] = self.cleaned_data['thumb'].name
        
        issue = super(IssueAdminForm, self).save(commit)
        
        # then we write the file in issue private directory <3
        if self.files.has_key('thumb'):
            dest = open(issue.thumb_path(), 'wb+')
            for chunk in self.files['thumb'].chunks():
                dest.write(chunk)
            dest.close()
        return issue

class IssueAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title', 'date_finished',)}
    list_display = ('title', 'text_presentation', 'nb_case_x', 'nb_case_y')
    
    form = IssueAdminForm

    class Media:
        js = ['%s/tiny_mce/tiny_mce.js' % settings.MEDIA_URL, '%s/tiny_mce/init.js' % settings.MEDIA_URL]

admin.site.register(Issue, IssueAdmin)
