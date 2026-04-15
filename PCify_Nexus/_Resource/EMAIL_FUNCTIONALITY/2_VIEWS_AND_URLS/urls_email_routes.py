"""
EMAIL FUNCTIONALITY URL ROUTES

Add these URL patterns to your accounts/urls.py file.

These routes handle:
1. Password reset request (send OTP)
2. OTP verification
3. Password change
"""

from django.urls import path
from .views import send_otp, verify_otp, change_password

# URL patterns for email/OTP functionality
urlpatterns = [
    # Send OTP to email for password reset
    path('send-otp/', send_otp, name='send_otp'),
    
    # Verify OTP entered by user
    path('verify-otp/', verify_otp, name='verify_otp'),
    
    # Change password after OTP verification
    path('change-password/', change_password, name='change_password'),
]

"""
Usage in templates:
- {% url 'accounts:send_otp' %} -> /accounts/send-otp/
- {% url 'accounts:verify_otp' %} -> /accounts/verify-otp/
- {% url 'accounts:change_password' %} -> /accounts/change-password/
"""
