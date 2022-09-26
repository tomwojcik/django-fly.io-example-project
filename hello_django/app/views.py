from django.views.generic import TemplateView

from app.models import ViewCount


class IndexView(TemplateView):
    template_name = "index.html"

    def get_context_data(self, **kwargs):
        obj = ViewCount.objects.first()
        if not obj:
            obj = ViewCount.objects.create(total_count=1)
        else:
            obj.total_count += 1
            obj.save()
        return super().get_context_data(counter=obj)
