import unittest

from about.models import Contact
from django.core.urlresolvers import reverse
from pyamf.remoting.client import RemotingService

class AboutTestCase(unittest.TestCase):
    def setUp(self):
        self.gw = RemotingService('http://localhost:8000%s' % reverse('gateway'))
        self.service = self.gw.getService('about')

    def testGatewayContact(self):
        self.service.contact('hello', 'hello@milkshape.cc', 'test contact', 'test contact')