from django.db.models import signals

def post_sync(app, created_models, verbosity, **kwargs):
    from django.contrib.sites.models import Site
    if app.__name__ == "django.contrib.sites.models":
        default = Site.objects.get(pk=1)
        default.domain = default.name = "localhost:8000"
        default.save()
        Site.objects.create(domain="milkshape.cc", name="milkshape.cc")

signals.post_syncdb.connect(post_sync)