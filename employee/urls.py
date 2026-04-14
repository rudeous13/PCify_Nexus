# Import file or packages
from django.urls import path
from .views import *

# App name
app_name = "employee"

urlpatterns = [
# Auth
    path('login/', login_view, name='login'),
    
    # Dashboard redirect (Your logo links here, but you have no dashboard template)
    path('', dashboard_redirect, name='dashboard'),
    
    # Core Application Views
    path('tasks/', tasks_view, name='tasks'),
    path('services/', services_view, name='services_task'),
    path('builds/', builds_view, name='builds'),
    path('delivery/', delivery_view, name='delivery'),
    path('completed/', completed_view, name='completed'),  
]