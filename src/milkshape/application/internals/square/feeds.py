from square.models import Square

from django.contrib.syndication.feeds import Feed
from django.utils.feedgenerator import Atom1Feed

class RssSiteNewsFeed(Feed):
    title = "Latest squares filled"
    link = "/square/feeds/"
    description = "Milkshape's squares"
    
    def items(self):
        return Square.objects.filter(status=True).order_by('-date_finished')[:5]

class AtomSiteNewsFeed(RssSiteNewsFeed):
    feed_type = Atom1Feed
    subtitle = RssSiteNewsFeed.description
