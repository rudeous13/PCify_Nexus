# Email Functionality - Quick Setup Checklist

Use this checklist to ensure all email functionality is properly integrated into your project.

## Pre-Integration Checklist

- [ ] **Backup your project** before making changes
- [ ] **Review README.md** in `0_DOCUMENTATION/` folder
- [ ] **Read INTEGRATION_GUIDE.md** for detailed steps
- [ ] **Install required packages**: `pip install python-dotenv` (if not already installed)

---

## Step-by-Step Integration

### 1. Settings Configuration _(5 minutes)_

- [ ] Open `PCify_Nexus/settings.py`
- [ ] Find and replace email configuration (around line 151)
- [ ] Copy entire EMAIL configuration from `1_SETTINGS/settings_email_config.py`
- [ ] Save and verify no syntax errors

**Verify**: Run `python manage.py check` to ensure no errors

---

### 2. Add Email Views _(10 minutes)_

- [ ] Open `accounts/views.py`
- [ ] Add import: `from django.core.mail import send_mail` (at top with other imports)
- [ ] Copy and paste all three functions from `2_VIEWS_AND_URLS/views_email_functions.py`:
  - [ ] `send_otp()`
  - [ ] `verify_otp()`
  - [ ] `change_password()`

**Verify**: `python manage.py check` completes successfully

---

### 3. Add URL Routes _(5 minutes)_

- [ ] Open `accounts/urls.py`
- [ ] Ensure imports include the new functions: `from .views import send_otp, verify_otp, change_password`
- [ ] Add 3 URL patterns from `2_VIEWS_AND_URLS/urls_email_routes.py` to `urlpatterns` list

**Verify**: Check URL patterns are unique and don't conflict with existing routes

---

### 4. Copy Email Templates _(5 minutes)_

- [ ] Copy `send_otp.html` from `3_TEMPLATES/` → `templates/LoginPage/`
- [ ] Copy `verify_otp.html` from `3_TEMPLATES/` → `templates/LoginPage/`
- [ ] Copy `changepassword.html` from `3_TEMPLATES/` → `templates/LoginPage/`

**Verify**: All three files exist in `templates/LoginPage/`

---

### 5. Update Frontend Validation _(5-10 minutes)_

- [ ] Open `static/LoginPage/login.js`
- [ ] Merge the validation functions from `4_FRONTEND_VALIDATION/login.js`
- [ ] Key functions to add/update:
  - [ ] `isValidEmail()`
  - [ ] `scorePassword()`
  - [ ] `updateStrengthMeter()`
  - [ ] `togglePass()`
  - [ ] Signup form validator
  - [ ] Signin form validator
  - [ ] Change password form validator

**Note**: Be careful when merging - don't duplicate functions

**Verify**: Open browser console - no JavaScript errors

---

### 6. Verify User Model _(5 minutes)_

- [ ] Open `accounts/models.py`
- [ ] Check User model has:
  - [ ] `email` field (EmailField, unique=True)
  - [ ] `phone_number` field (CharField)
  - [ ] Uses `AbstractBaseUser` (not `AbstractUser`)
- [ ] If model changed, create migration: `python manage.py makemigrations`
- [ ] Apply migrations: `python manage.py migrate`

**Verify**: No migration errors

---

### 7. Environment Setup _(5 minutes)_

- [ ] Create `.env` file in project root (same level as `manage.py`)
- [ ] Add email configuration:
  ```env
  EMAIL_HOST=smtp.gmail.com
  EMAIL_PORT=587
  EMAIL_USE_TLS=True
  EMAIL_HOST_USER=your-email@gmail.com
  EMAIL_HOST_PASSWORD=your-app-password
  DEFAULT_FROM_EMAIL=your-email@gmail.com
  ```
- [ ] **IMPORTANT**: Add `.env` to `.gitignore`

**For Gmail**:
- [ ] Go to https://myaccount.google.com/security
- [ ] Enable 2-Factor Authentication
- [ ] Generate App Password
- [ ] Use the 16-character password in `EMAIL_HOST_PASSWORD`

---

### 8. Update Settings for Environment Variables _(5 minutes)_

- [ ] Open `PCify_Nexus/settings.py`
- [ ] Add at the very top (after imports):
  ```python
  from dotenv import load_dotenv
  import os
  
  load_dotenv()
  ```
- [ ] Verify `os` is imported

---

## Testing the Integration

### Test 1: Check OTP Sending _(2 minutes)_

- [ ] Go to `/accounts/send-otp/` in browser
- [ ] Enter your email address
- [ ] Check:
  - [ ] **Development**: Email prints to console
  - [ ] **Production**: Email received in inbox
- [ ] Error message? Check SMTP settings

### Test 2: Check OTP Verification _(2 minutes)_

- [ ] Enter the OTP displayed/received
- [ ] Should redirect to password change page
- [ ] Should show "OTP verified successfully" message

### Test 3: Check Password Change _(2 minutes)_

- [ ] Enter new password (must be strong - colored bar should be green)
- [ ] Confirm password
- [ ] Click "Reset Password"
- [ ] Should redirect to sign-in page with success message

### Test 4: Sign In with New Password _(2 minutes)_

- [ ] Go to sign-in page
- [ ] Use your email/phone and new password
- [ ] Should successfully log in

---

## Troubleshooting

### Issue: "Module not found: dotenv"

**Solution**: 
```bash
pip install python-dotenv
```

---

### Issue: "send_mail() missing required argument"

**Solution**: 
- Check that `from django.core.mail import send_mail` is imported
- Ensure all send_mail() calls have correct parameters

---

### Issue: Emails printing to console instead of sending

**Solution**:
- This is normal in **DEBUG=True** mode
- For production testing, set `EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'` in settings

---

### Issue: "No module named 'accounts.views'"

**Solution**:
- Ensure new functions are added to correct file
- Restart Django development server

---

### Issue: "Reverse URL error - send_otp not found"

**Solution**:
- Check URL routes are added in `accounts/urls.py`
- Check function names match URL names
- Restart Django server

---

## Common Mistakes to Avoid

❌ **Don't**:
- Commit `.env` file to git with real credentials
- Use your personal Gmail password (generate app password instead)
- Copy only part of a function (copy entire function)
- Forget to run migrations after model changes
- Mix old and new password verification logic

✅ **Do**:
- Test all three steps (send → verify → change password)
- Use environment variables for all SMTP settings
- Create backup before making changes
- Check console for JavaScript errors
- Verify migrations run successfully

---

## Final Checklist

After completing all steps, verify:

- [ ] No Python syntax errors: `python manage.py check`
- [ ] No JavaScript console errors
- [ ] All 3 URL routes working
- [ ] OTP email sending (console or actual email)
- [ ] Password change working
- [ ] New password works for sign-in
- [ ] `.env` file in `.gitignore`
- [ ] No hardcoded passwords in code

---

## Success Indicators

You'll know everything is working when:

✅ Email validation rejects invalid formats  
✅ OTP is generated and sent successfully  
✅ Password strength meter shows (weak → medium → strong)  
✅ Password change completes without errors  
✅ New password allows sign-in  
✅ Security is maintained

---

## Time Estimate

- **Initial Setup**: ~45-60 minutes
- **Testing**: ~15-20 minutes
- **Troubleshooting**: ~10-15 minutes (if needed)

**Total**: **1-2 hours** depending on project setup

---

## Need Help?

1. **Check INTEGRATION_GUIDE.md** for detailed steps
2. **Review README.md** for architecture overview
3. **Check console errors** (both browser and terminal)
4. **Verify `.env` file** has correct credentials
5. **Test with development email** first (set DEBUG=True)

---

**Good luck! 🚀**

Once integrated, your friend's project will have full email/OTP password reset functionality!
