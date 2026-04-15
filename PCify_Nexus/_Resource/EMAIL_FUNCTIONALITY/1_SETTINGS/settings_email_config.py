"""
EMAIL CONFIGURATION FOR DJANGO

Add these settings to your PCify_Nexus/settings.py file
(Around line 150-165 in the project settings)

This configuration enables SMTP email functionality for OTP and password reset features.
"""

import os
from pathlib import Path

# ============================================================================
# EMAIL CONFIGURATION
# ============================================================================

# SMTP Server Settings
EMAIL_HOST = os.getenv('EMAIL_HOST', 'smtp.gmail.com')
EMAIL_PORT = int(os.getenv('EMAIL_PORT', '587'))
EMAIL_USE_TLS = os.getenv('EMAIL_USE_TLS', 'True').lower() in {
    '1', 'true', 'yes'}

# SMTP Authentication
EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER', '')
EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD', '')

# Default sender email address
DEFAULT_FROM_EMAIL = os.getenv(
    'DEFAULT_FROM_EMAIL', EMAIL_HOST_USER)

# In development, allow OTP flow to work without SMTP credentials by printing
# emails in terminal instead of sending via SMTP.
if DEBUG and (not EMAIL_HOST_USER or not EMAIL_HOST_PASSWORD):
    EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
else:
    EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'


# ============================================================================
# ENVIRONMENT VARIABLE SETUP
# ============================================================================
"""
Required Environment Variables (.env file):

EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password
DEFAULT_FROM_EMAIL=your-email@gmail.com

For Gmail setup:
1. Enable 2-Factor Authentication: https://myaccount.google.com/security
2. Generate App Password: https://myaccount.google.com/apppasswords
3. Use the 16-character app password as EMAIL_HOST_PASSWORD
"""
