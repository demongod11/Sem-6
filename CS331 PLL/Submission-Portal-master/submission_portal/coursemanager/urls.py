from django.urls import path
from . import views

app_name = 'coursemanager'

urlpatterns = [
    path('', views.index, name = 'home'),
    path('submissions/<int:pk>/', views.dummy, name = 'submissions-view'),
    path('assignment/add/', views.AddAssignment, name = 'add-assignment'),
    path('assignment/<int:pk>/', views.EditAssignment, name = 'edit-assignment'),
    path('media/<path:file>', views.MediaView, name='media'),
    path('submit/<int:pk>/', views.SubmitAssignment, name = 'submit-assignment'),
]   