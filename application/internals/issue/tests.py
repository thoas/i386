import unittest
from issue.models import Issue
from pyamf.remoting.client import RemotingService

class IssueTestCase(unittest.TestCase):
    def setUp(self):
        self.gw = RemotingService('http://127.0.0.1:8000/issue/gateway/')
        self.service = self.gw.getService('issue')

    def testGatewayIssues(self):
        print self.service.issues()
    
    def testGatewayIssue(self):
        print self.service.issue('5x5')