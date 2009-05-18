from issue.models import Issue
from pyamf.remoting.gateway.django import DjangoGateway

def issues(request):
    return Issue.objects.all().values()

def issue(request, issue_slug):
    return Issue.objects.get(slug=issue_slug).__dict__

services = {
    'issue.issues': issues,
    'issue.issue': issue
}

issueGateway = DjangoGateway(services)