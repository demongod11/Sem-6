from django.contrib import admin
from .models import SiteUser, Assignment, SubmittedAssignment

# Register your models here.
admin.site.register(SiteUser)
admin.site.register(Assignment)
admin.site.register(SubmittedAssignment)