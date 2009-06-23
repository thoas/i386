from pyamf.remoting.gateway.django import DjangoGateway

from account.views import _login, _logout, _is_authenticated, _password_change
from square.views import _book, _release, _template, _fill
from about.views import _contact
from issue.views import _issues, _issue

gateway = DjangoGateway({
    'account.login': _login,
    'account.logout': _logout,
    'account.is_authenticated': _is_authenticated,
    'account.password_change': _password_change,
    
    'square.book': _book,
    'square.release': _release,
    'square.template': _template,
    'square.fill': _fill,
    
    'issue.issues': _issues,
    'issue.issue': _issue,
    
    'about.contact': _contact,
})
