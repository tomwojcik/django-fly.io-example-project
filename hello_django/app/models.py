from django.db import models


class ViewCount(models.Model):
    """
    Dummy model just to prove that the connection with the DB works
    and the state is persistent.
    """
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    total_count = models.BigIntegerField(default=0)
