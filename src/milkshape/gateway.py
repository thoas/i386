from pyamf.remoting.gateway.django import DjangoGateway

from account.views import _login, _logout, _is_authenticated, _password_change,\
    _create_invitation, _invitations, _send_invitation, _signup
from profiles.views import _profile, _profile_change, _last_profiles, _creations
from square.views import _book, _release, _template, _fill, _squares_full_by_issues
from about.views import _contact
from issue.views import _issues, _issue, _last_issues

gateway = DjangoGateway({
    'account.login': _login,
    'account.logout': _logout,
    'account.signup': _signup,
    'account.is_authenticated': _is_authenticated,
    'account.password_change': _password_change,
    'account.create_invitation': _create_invitation,
    'account.send_invitation': _send_invitation,
    'account.invitations': _invitations,
    
    'profile.profile': _profile,
    'profile.profile_change': _profile_change,
    'profile.last_profiles': _last_profiles,
    'profile.creations': _creations,
    
    'square.book': _book,
    'square.release': _release,
    'square.template': _template,
    'square.fill': _fill,
    'square.squares_full_by_issues': _squares_full_by_issues,
    
    'issue.issues': _issues,
    'issue.issue': _issue,
    'issue.last_issues': _last_issues,
    
    'about.contact': _contact,
})
