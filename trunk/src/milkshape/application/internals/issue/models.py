from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.utils.translation import ugettext_lazy as _
from django.db.models.signals import post_save
from django.db import connection, transaction

from os.path import join, exists
from os import makedirs


class IssueManager(models.Manager):
    """docstring for IssueManager"""
    def get_nb_squares(self, issue):
        cursor = connection.cursor()
        cursor.execute("""
            SELECT count(*) AS nb_squares 
            FROM square_square
            WHERE coord 
                NOT IN (
                    SELECT coord 
                    FROM square_squareopen 
                    WHERE issue_id = %d
                )
            AND issue_id = %d
        """ % (issue.id, issue.id))
        row = cursor.fetchone()
        return row[0]
    
    def get_current_issues(self):
        cursor = connection.cursor()
        cursor.execute("""
            SELECT id
            FROM issue_issue
            WHERE 
                (issue_issue.nb_case_x * issue_issue.nb_case_y) > (
                    SELECT count(*) 
                    FROM square_square
                    WHERE coord 
                        NOT IN (
                            SELECT coord 
                            FROM square_squareopen 
                            WHERE issue_id = issue_issue.id
                        )
                    AND issue_id = issue_issue.id
                )
        """)
        rows = cursor.fetchall()
        found = self.in_bulk([r[0] for r in rows])
        return found.values()
    
    def get_complete_issues(self):
        cursor = connection.cursor()
        cursor.execute("""
            SELECT id
            FROM issue_issue
            WHERE 
                (issue_issue.nb_case_x * issue_issue.nb_case_y) <= (
                    SELECT count(*) 
                    FROM square_square
                    WHERE coord 
                        NOT IN (
                            SELECT coord 
                            FROM square_squareopen 
                            WHERE issue_id = issue_issue.id
                        )
                    AND issue_id = issue_issue.id
                )
        """)
        rows = cursor.fetchall()
        found = self.in_bulk([r[0] for r in rows])
        return found.values()
    
    def get_creators(self, issue):
        cursor = connection.cursor()
        cursor.execute("""
            SELECT id
            FROM auth_user
            GROUP BY id
            HAVING (
                (
                    SELECT count(id) 
                    FROM square_square 
                    WHERE issue_id = %d 
                    AND user_id = auth_user.id
                ) > 0
            )
        """ % (issue.id))
        rows = cursor.fetchall()
        found = User.objects.select_related('profile').in_bulk([r[0] for r in rows])
        return found.values()

class Issue(models.Model):
    title = models.CharField(_('title'), max_length=255, help_text=_('Issue\'s title?'))
    text_presentation = models.TextField(_('text_presentation'), help_text=_('Issue\'s text presentation?'),
                                         blank=True, null=True)
    nb_case_x = models.IntegerField(_('nb_case_x'), help_text=_('How much squares in x?'))
    nb_case_y = models.IntegerField(_('nb_case_y'), help_text=_('How much squares in y?'))
    show_disable_square = models.BooleanField(_('show_disable_square'), default=0)
    nb_step = models.IntegerField(_('nb_step'), help_text=_('How much steps during the scroll?'),
                                  default=settings.DEFAULT_NB_STEP)
    size = models.IntegerField(_('size'), help_text=_('Creation\'s size?'),
                               default=settings.DEFAULT_SIZE)
    margin = models.IntegerField(_('margin'), help_text=('Margin\'s size?'),
                                 default=settings.DEFAULT_MARGIN)
    
    # DateField makes an error on pyamf
    date_created = models.DateTimeField(_('date_creation'), auto_now_add=True)
    date_finished = models.DateTimeField(_('date_finished'), blank=True, null=True)
    max_participation = models.IntegerField(_('max_participation'),
                                            default=settings.DEFAULT_MAX_PARTICIPATION)
    slug = models.SlugField(unique=True)
    
    constraint_text = models.TextField(_('constraint_text'), blank=True, null=True)
    constraint_time = models.IntegerField(_('constraint_time'), default=settings.DEFAULT_TIME)
    thumb = models.CharField(_('thumb'), max_length=255, blank=True, null=True)
    
    objects = IssueManager()
    
    def __init__(self, *args, **kwargs):
        """docstring for __init__"""
        super(Issue, self).__init__(*args, **kwargs)
        self.size_without_margin = self.size - self.margin
        self.size_with_margin = self.size + self.margin
        self.size_with_double_margin = self.size + self.margin * 2

        self.crop_pos = (
            (0, self.size_without_margin, self.size, self.size), # h_c
            (0, self.size_without_margin, self.margin, self.size), # h_r
            (0, 0, self.margin, self.size), # c_r
            (0, 0, self.margin, self.margin), # l_r
            (0, 0, self.size, self.margin), # l_c
            (self.size_without_margin, 0, self.size, self.margin), # l_l
            (self.size_without_margin, 0, self.size, self.size), # c_l
            (self.size_without_margin, self.size_without_margin, self.size, self.size), # h_l
        )

        self.paste_pos = (
            (self.margin, 0, self.size_with_margin, self.margin), # h_c
            (self.size_with_margin, 0, self.size_with_double_margin, self.margin), # h_r
            (self.size_with_margin, self.margin, self.size_with_double_margin, self.size_with_margin), # c_r
            (self.size_with_margin, self.size_with_margin, self.size_with_double_margin, self.size_with_double_margin), # l_r
            (self.margin, self.size_with_margin, self.size_with_margin, self.size_with_double_margin), # l_c
            (0, self.size_with_margin, self.margin, self.size_with_double_margin), # l_l
            (0, self.margin, self.margin, self.size_with_margin), # c_l
            (0, 0, self.margin, self.margin), # h_l
        )
        
        self.creation_position_crop = (self.margin, self.margin,\
            self.size + self.margin, self.size + self.margin)
        self.creation_position_paste = (0, 0, self.size, self.size)
    
    @property
    def steps(self):
        if not hasattr(self, '_steps'):
            """docstring for steps"""
            size = self.size
            self._steps = []
            for i in range(self.nb_step):
                self._steps.append(size)
                size /= 2
            self._steps.reverse()
        return self._steps
    
    def __unicode__(self):
        """docstring for __unicode__"""
        return self.title
    
    def save(self, force_insert=False, force_update=False):
        super(Issue, self).save(force_insert, force_update)
        
    @models.permalink
    def get_absolute_url(self):
        """docstring for get_absolute_url"""
        return ('issue.views.issue', [str(self.slug)])
    
    @property
    def url(self):
        return '%s/%s' % (settings.ISSUES_DIR, self.slug)
    
    @property
    def thumb_url(self):
        if self.thumb:
            return '%s/%s' % (self.media_url, self.thumb)
        return None
    
    @property
    def media_url(self):
        return '%s/%s' % (settings.MEDIA_URL, self.url)
    
    @property
    def nb_squares(self):
        return Issue.objects.get_nb_squares(self)
    
    @property
    def nb_squares_open(self):
        return self.squares_open.count()

    @property
    def nb_squares_booked(self):
        return self.squares_booked().count()
    
    @property
    def nb_creators(self):
        return len(Issue.objects.get_creators(self))
    
    def squares_booked(self):
        return self.squares.filter(status=True, user__isnull=False)
    
    def thumb_path(self):
        return '%s/%s' % (self.path(), self.thumb)
    
    def path(self):
        return join(settings.ISSUES_ROOT, self.slug)
    
    def layer_path(self):
        return join(self.path(), settings.LAYER_DIR)
    
    def layer_url(self):
        return '%s/%s' % (self.media_url, settings.LAYER_DIR)
    
    def template_path(self):
        return join(self.path(), settings.TEMPLATE_DIR)

    def template_url(self):
        return '%s/%s' % (self.media_url, settings.TEMPLATE_DIR)
    
    def upload_path(self):
        return join(self.path(), settings.UPLOAD_DIR)

    def upload_url(self):
        return '%s/%s' % (self.media_url, settings.UPLOAD_DIR)
    
    def upload_hd_path(self):
        return join(self.upload_path(), settings.UPLOAD_HD_DIR)

    def upload_hd_url(self):
        return '%s/%s' % (self.upload_url(), settings.UPLOAD_HD_DIR)

    def upload_template_path(self):
        return join(self.upload_path(), settings.UPLOAD_TEMPLATE_DIR)
    
    def upload_template_url(self):
        return '%s/%s' % (self.upload_url(), settings.UPLOAD_TEMPLATE_DIR)
    
    def upload_thumb_path(self):
        return join(self.upload_path(), settings.UPLOAD_THUMB_DIR)

    def upload_thumb_url(self):
        return '%s/%s' % (self.upload_url(), settings.UPLOAD_THUMB_DIR)

def create_tree(sender, instance=None, **kwargs):
    if kwargs['created']:
        try:
            makedirs(instance.layer_path())
            makedirs(instance.template_path())
            makedirs(instance.upload_hd_path())
            makedirs(instance.upload_template_path())
            makedirs(instance.upload_thumb_path())
        except OSError, error:
            print error

post_save.connect(create_tree, sender=Issue)