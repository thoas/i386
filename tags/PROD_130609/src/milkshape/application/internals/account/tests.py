import unittest

from issue.models import Issue
from pyamf.remoting.client import RemotingService

from django.core.urlresolvers import reverse

class IssueTestCase(unittest.TestCase):
    def setUp(self):
        self.gw = RemotingService('http://localhost:8000%s' % reverse('account_gateway'))
        self.service = self.gw.getService('account')

    def testGatewayLogin(self):
        values = self.service.login("thoas", "toto")
        print values