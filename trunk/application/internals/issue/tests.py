import unittest
from issue.models import Issue
from pyamf.remoting.client import RemotingService

class IssueTestCase(unittest.TestCase):
    def setUp(self):
        self.gw = RemotingService('http://localhost:8000%s' % reverse('issue_gateway'))
        self.service = self.gw.getService('issue')

    def testGatewayIssues(self):
        print self.service.issues()
    
    def testGatewayIssue(self):
        print self.service.issue('5x5')