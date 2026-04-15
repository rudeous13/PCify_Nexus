# Email & OTP Functionality Documentation

This folder contains all files and configurations responsible for email and OTP (One-Time Password) functionality in the PCify_Nexus project.

## Overview
The project implements a **password reset flow** using:
1. OTP email verification
2. Email-based authentication
3. Password change functionality

## Folder Structure

### 1. SETTINGS (`1_SETTINGS/`)
Contains the Django email configuration that must be added to your Django settings file.
- **File**: `settings_email_config.py`
- **Location in project**: `PCify_Nexus/settings.py` (lines 151-165)
- **Key configurations**: 
  - EMAIL_HOST (SMTP server)
  - EMAIL_PORT (SMTP port)
  - EMAIL_USE_TLS (TLS encryption)
  - EMAIL_HOST_USER (sender email)
  - EMAIL_HOST_PASSWORD (sender password)
  - EMAIL_BACKEND (console vs SMTP)

### 2. VIEWS & URLS (`2_VIEWS_AND_URLS/`)
Contains the backend logic for email sending and OTP verification.

**Files**:
- `views_email_functions.py` - Contains 3 key functions:
  - `send_otp()` - Sends OTP via email
  - `verify_otp()` - Verifies the OTP entered by user
  - `change_password()` - Updates password after OTP verification
  
- `urls_email_routes.py` - URL patterns for email flows:
  - `/send-otp/`
  - `/verify-otp/`
  - `/change-password/`

### 3. TEMPLATES (`3_TEMPLATES/`)
Frontend HTML pages for the email/OTP flow.

**Files**:
- `send_otp.html` - Page where users enter email/phone to request OTP
- `verify_otp.html` - Page where users enter the OTP they received
- `changepassword.html` - Page where users reset their password

### 4. FRONTEND VALIDATION (`4_FRONTEND_VALIDATION/`)
Client-side JavaScript validation for email and form inputs.

**File**:
- `login.js` - Contains:
  - Email format validation
  - Email domain validation (only Gmail, Yahoo, Outlook, Hotmail)
  - Password strength checker
  - Form validation handlers

### 5. MODELS (`5_MODELS/`)
Database models that support email functionality.

**File**:
- `models_user_email.py` - User model with:
  - `email` field (unique)
  - `phone_number` field (alternative login method)

## How Email Functionality Works

### Flow Diagram:
```
1. User clicks "Forgot Password"
   ↓
2. User enters email/phone on send_otp.html
   ↓
3. Server generates random 6-digit OTP
   ↓
4. Server sends OTP via email (send_otp function)
   ↓
5. User enters OTP on verify_otp.html
   ↓
6. Server verifies OTP matches
   ↓
7. User sets new password on changepassword.html
   ↓
8. Password updated successfully
```

## Required Environment Variables

Add these to your `.env` file or system environment:

```env
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password
DEFAULT_FROM_EMAIL=your-email@gmail.com
```

### For Gmail:
1. Enable 2-Factor Authentication on your Gmail account
2. Generate an "App Password" for Django
3. Use the app password as `EMAIL_HOST_PASSWORD`

## Integration Steps (for your friend's project)

1. **Copy settings configuration**:
   - Add the email configuration from `1_SETTINGS/settings_email_config.py` to `PCify_Nexus/settings.py`

2. **Copy view functions**:
   - Add the three functions from `2_VIEWS_AND_URLS/views_email_functions.py` to `accounts/views.py`
   - Make sure `from django.core.mail import send_mail` is imported

3. **Copy URL routes**:
   - Add the three paths from `2_VIEWS_AND_URLS/urls_email_routes.py` to `accounts/urls.py`

4. **Copy templates**:
   - Copy all three HTML files from `3_TEMPLATES/` to `templates/LoginPage/`

5. **Copy frontend JavaScript**:
   - Merge `4_FRONTEND_VALIDATION/login.js` with your existing `static/LoginPage/login.js`
   - Focus on: email validation, password strength, and form handlers

6. **Verify model**:
   - Ensure your User model has `email` and `phone_number` fields as shown in `5_MODELS/models_user_email.py`

7. **Set environment variables**:
   - Configure your SMTP credentials in `.env`

8. **Update imports**:
   - Make sure `from django.core.mail import send_mail` is imported in views.py

## Key Features

✅ **OTP Generation**: Random 6-digit codes  
✅ **Email Sending**: HTML-formatted emails with branding  
✅ **Email Validation**: Domain and format checking  
✅ **Session Management**: OTP stored in session (secure)  
✅ **Password Security**: Strength checking, no reuse allowed  
✅ **Error Handling**: User-friendly error messages  
✅ **Console Email Backend**: For development without SMTP  

## Security Notes

⚠️ OTP is stored in `request.session` - ensure session security  
⚠️ OTP expires when session ends (configurable)  
⚠️ Never commit `.env` file with real credentials  
⚠️ Use app-specific passwords for email accounts  
⚠️ Enable TLS for email transmission  

## Troubleshooting

**Emails not sending?**
- Check `EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD` are correct
- Verify SMTP port (typically 587 for TLS)
- Check email provider allows less secure apps (or use app passwords)

**OTP not received?**
- Check that EMAIL_BACKEND is set to 'django.core.mail.backends.smtp.EmailBackend' (not console)
- Verify recipient email address is correct
- Check spam folder

**Session issues?**
- Ensure Django sessions are enabled in middleware
- Check session backend is configured

