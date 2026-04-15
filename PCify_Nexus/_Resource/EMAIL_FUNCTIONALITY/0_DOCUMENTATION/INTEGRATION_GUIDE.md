# Step-by-Step Integration Guide

## Quick Reference: Files to Integrate

| Component | Source File | Destination |
|-----------|------------|-------------|
| **Settings** | `1_SETTINGS/settings_email_config.py` | `PCify_Nexus/settings.py` (lines 151-165) |
| **Views** | `2_VIEWS_AND_URLS/views_email_functions.py` | `accounts/views.py` |
| **URLs** | `2_VIEWS_AND_URLS/urls_email_routes.py` | `accounts/urls.py` |
| **Templates** | `3_TEMPLATES/*.html` | `templates/LoginPage/` |
| **JavaScript** | `4_FRONTEND_VALIDATION/login.js` | `static/LoginPage/login.js` |
| **Models** | `5_MODELS/models_user_email.py` | `accounts/models.py` |

---

## Detailed Integration Steps

### Step 1: Configure Email Settings

**File**: `PCify_Nexus/settings.py`

Find the line that starts with `EMAIL_HOST =` (around line 151) and add/replace with:

```python
# ============================================================================
# EMAIL CONFIGURATION
# ============================================================================

EMAIL_HOST = os.getenv('EMAIL_HOST', 'smtp.gmail.com')
EMAIL_PORT = int(os.getenv('EMAIL_PORT', '587'))
EMAIL_USE_TLS = os.getenv('EMAIL_USE_TLS', 'True').lower() in {
    '1', 'true', 'yes'}
EMAIL_HOST_USER = os.getenv('EMAIL_HOST_USER', '')
EMAIL_HOST_PASSWORD = os.getenv('EMAIL_HOST_PASSWORD', '')
DEFAULT_FROM_EMAIL = os.getenv(
    'DEFAULT_FROM_EMAIL', EMAIL_HOST_USER)

if DEBUG and (not EMAIL_HOST_USER or not EMAIL_HOST_PASSWORD):
    EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
else:
    EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
```

### Step 2: Add View Functions

**File**: `accounts/views.py`

1. Add import at the top:
```python
from django.core.mail import send_mail
```

2. Add the three functions from `2_VIEWS_AND_URLS/views_email_functions.py`:
   - `send_otp()`
   - `verify_otp()`
   - `change_password()`

### Step 3: Add URL Routes

**File**: `accounts/urls.py`

Add these paths to your `urlpatterns`:

```python
path('send-otp/', send_otp, name='send_otp'),
path('verify-otp/', verify_otp, name='verify_otp'),
path('change-password/', change_password, name='change_password'),
```

### Step 4: Copy Template Files

**Files to copy** from `3_TEMPLATES/` to `templates/LoginPage/`:
- `send_otp.html`
- `verify_otp.html`
- `changepassword.html`

### Step 5: Update JavaScript Validation

**File**: `static/LoginPage/login.js`

Merge the validation functions from `4_FRONTEND_VALIDATION/login.js` with your existing file. Key functions to add/update:
- `isValidEmail()`
- `scorePassword()`
- `updateStrengthMeter()`
- `togglePass()`
- `markFormError()`
- `clearFormError()`

And add/update the form validators:
- Signup form validator
- Signin form validator
- Change password form validator

### Step 6: Verify User Model

**File**: `accounts/models.py`

Check that your User model has these fields:
- `email` - EmailField (unique)
- `phone_number` - CharField (for alternative login)
- Password handling via Django's AbstractBaseUser

---

## Environment Setup

### Create `.env` File

Create a `.env` file in your project root:

```env
# Email Configuration
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your-email@gmail.com
EMAIL_HOST_PASSWORD=your-app-password
DEFAULT_FROM_EMAIL=your-email@gmail.com
```

### For Gmail Setup

1. **Enable 2-Factor Authentication**:
   - Visit https://myaccount.google.com/security
   - Enable 2-Step Verification

2. **Generate App Password**:
   - Visit https://myaccount.google.com/apppasswords
   - Select "Mail" and "Windows Computer"
   - Generate and copy the 16-character password

3. **Update `.env`**:
   ```env
   EMAIL_HOST_USER=your-email@gmail.com
   EMAIL_HOST_PASSWORD=xxxx xxxx xxxx xxxx  # Replace with generated password
   ```

### Load Environment Variables

Make sure your project loads `.env` file. Add this to `settings.py`:

```python
from dotenv import load_dotenv
load_dotenv()
```

Install python-dotenv if needed:
```bash
pip install python-dotenv
```

---

## Testing the Integration

### Manual Testing Steps

1. **Test OTP Flow**:
   - Go to `/accounts/send-otp/`
   - Enter your email address
   - Check console output (development) or email inbox (production)

2. **Test Verification**:
   - Enter the OTP code from email
   - Should redirect to password change form

3. **Test Password Change**:
   - Enter new password (must be strong)
   - Confirm password
   - Should update successfully

### Debug Mode

For development, emails will print to console instead of being sent. To test actual email sending:

```python
# In settings.py
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
```

---

## Common Issues & Solutions

### Emails Not Sending

**Problem**: "Error sending email. Check SMTP settings."

**Solutions**:
- ✅ Check `EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD` are correct
- ✅ Verify Gmail 2FA and app password are set up
- ✅ Check SMTP port (usually 587)
- ✅ Ensure TLS is enabled
- ✅ Check firewall isn't blocking port 587

### OTP Not Received

**Problem**: Email sent but user doesn't see it

**Solutions**:
- ✅ Check spam/junk folder
- ✅ Verify `DEFAULT_FROM_EMAIL` matches `EMAIL_HOST_USER`
- ✅ Check that `fail_silently=False` in `send_mail()`
- ✅ Check Django logs for errors

### Session Issues

**Problem**: "Please request an OTP first"

**Solutions**:
- ✅ Ensure Django sessions middleware is enabled
- ✅ Check session backend is configured (default: database)
- ✅ Run `python manage.py migrate` if using database session backend
- ✅ Check cookie settings in settings.py

### Email Backend Still Using Console

**Problem**: Emails still printing to console in production

**Solutions**:
- ✅ Set `DEBUG = False` in settings.py for production
- ✅ Or explicitly set: `EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'`
- ✅ Verify environment variables are loaded correctly

---

## Security Checklist

- [ ] Never commit `.env` file with real credentials to git
- [ ] Use environment variables for all sensitive data
- [ ] Enable DEBUG=False in production
- [ ] Use app-specific passwords for Gmail (not your main password)
- [ ] Enable TLS for email transmission
- [ ] Test OTP expiration and session security
- [ ] Ensure CSRF tokens in all forms
- [ ] Hash passwords using Django's password hashers
- [ ] Use HTTPS in production

---

## Next Steps

After integration, consider:

1. **Email Queue**: Use Celery for async email sending (optional)
2. **Email Templates**: Create reusable email templates
3. **Rate Limiting**: Add rate limiting to prevent OTP abuse
4. **Logging**: Add logging for email operations
5. **Monitoring**: Set up email delivery monitoring

---

## Support Files Structure

```
EMAIL_FUNCTIONALITY/
├── 0_DOCUMENTATION/
│   ├── README.md (this file)
│   └── INTEGRATION_GUIDE.md (you are here)
├── 1_SETTINGS/
│   └── settings_email_config.py
├── 2_VIEWS_AND_URLS/
│   ├── views_email_functions.py
│   └── urls_email_routes.py
├── 3_TEMPLATES/
│   ├── send_otp.html
│   ├── verify_otp.html
│   └── changepassword.html
├── 4_FRONTEND_VALIDATION/
│   └── login.js
└── 5_MODELS/
    └── models_user_email.py
```

---

## Quick Commands

```bash
# Create superuser
python manage.py createsuperuser

# Run migrations
python manage.py migrate

# Test email setup
python manage.py shell
>>> from django.core.mail import send_mail
>>> send_mail('Test', 'Test body', 'your-email@gmail.com', ['recipient@gmail.com'])

# Check environment
python manage.py shell
>>> from django.conf import settings
>>> print(f"EMAIL_HOST: {settings.EMAIL_HOST}")
>>> print(f"EMAIL_PORT: {settings.EMAIL_PORT}")
```

---

## Questions?

Refer to:
- [Django Email Documentation](https://docs.djangoproject.com/en/stable/topics/email/)
- [Gmail App Passwords](https://support.google.com/accounts/answer/185833)
- Project README.md in 0_DOCUMENTATION/
