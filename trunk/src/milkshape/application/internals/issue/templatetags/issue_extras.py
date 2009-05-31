from django import template
register = template.Library()

from issue.models import Issue

@register.inclusion_tag('_issues.html')
def show_issues():
    """docstring for show_issues"""
    return {'issues': Issue.objects.all()}