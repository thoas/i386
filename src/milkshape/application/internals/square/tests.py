import unittest
import shutil

from os.path import join
from datetime import datetime

from square.models import Square, SquareOpen
from issue.models import Issue
from django.test.client import Client
from django.core.urlresolvers import reverse
from django.contrib.auth.models import User
from django.conf import settings
from pyamf.remoting.client import RemotingService

class SquareTestCase(unittest.TestCase):
    ACCT_USERNAME = 'toto'
    ACCT_PASSWORD = 'toto'
    ACCT_EMAIL = 'hello@milkshape.cc'
    
    def setUp(self):
        self.issue, self.created = Issue.objects.get_or_create(
            title='4x4', 
            text_presentation='10x10', 
            nb_case_x=4, 
            nb_case_y=4, 
            nb_step=5, 
            size=800, 
            margin=200, 
            slug='4x4'
        )
        try:
            self.user = User.objects.get(username=self.ACCT_USERNAME)
        except User.DoesNotExist:
            self.user = User.objects.create_user(self.ACCT_USERNAME, self.ACCT_EMAIL, self.ACCT_PASSWORD)
    
    def testBookProcess(self):
        print '|-- Book process'
        self.square_open, self.created = SquareOpen.objects.get_or_create(pos_x=0, pos_y=0, issue=self.issue)
        self.__testBookProcess()
    
    def __testBookProcess(self):
        squares_open = SquareOpen.objects.filter(is_standby=False, issue=self.issue)
        for square_open in squares_open:     
            print '|   |-- Processing (%d, %d)' % (square_open.pos_x, square_open.pos_y)       
            self.__testBookSquare(square_open.pos_x, square_open.pos_y)
            self.__testFillSquare(square_open.pos_x, square_open.pos_y)
        if SquareOpen.objects.filter(is_standby=False, issue=self.issue).count() > 0:
            self.__testBookProcess()
    
    def __testBookSquare(self, pos_x, pos_y):
        c = Client()
        result = c.login(username=self.ACCT_USERNAME, password=self.ACCT_PASSWORD)
        response = c.get(reverse('square_book', kwargs={
            'pos_x': pos_x, 
            'pos_y': pos_y, 
            'issue_slug': self.issue.slug
        }))
        square_open = SquareOpen.objects.get(pos_x=pos_x, pos_y=pos_y, issue=self.issue)
        self.assertEquals(square_open.is_standby, True)
        self.assertEquals(response.status_code, 200)
        print '|   |   |-- booked'
    
    def __testFillSquare(self, pos_x, pos_y):
        c = Client()
        result = c.login(username=self.ACCT_USERNAME, password=self.ACCT_PASSWORD)
        f = open(join(settings.CLI_ROOT, 'push', 'template.jpg'))
        response = c.post(reverse('square_fill', kwargs={
            'pos_x': pos_x,
            'pos_y': pos_y,
            'issue_slug': self.issue.slug
        }), {'background_image': f})
        f.close()
        self.assertEquals(response.status_code, 200)
        try:
            SquareOpen.objects.get(pos_x=pos_x, pos_y=pos_y, issue=self.issue)
        except SquareOpen.DoesNotExist:
            print '|   |   |-- filled'
        else:
            assert '|   |   |-- FAIL'
    
    def testKeepDatabase(self):
        shutil.copy(settings.TEST_DATABASE_NAME, join(settings.PROJECT_ROOT, 'test_%s.db' % datetime.now().strftime('%Y-%m-%d--%H-%M-%S')))