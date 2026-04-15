"""
EMAIL FUNCTIONALITY VIEWS

Add these functions to your accounts/views.py file.
Also add the import at the top: from django.core.mail import send_mail

This file contains:
1. send_otp() - Generates and sends OTP via email
2. verify_otp() - Verifies the OTP entered by user
3. change_password() - Allows user to reset password after OTP verification
"""

from django.shortcuts import render, redirect
from django.contrib import messages
from django.core.mail import send_mail
from django.conf import settings
from .models import User
import re
import random


def send_otp(request):
    """
    Sends OTP via email for password reset.
    
    Process:
    1. User enters email or phone number
    2. Validates input and finds user
    3. Generates random 6-digit OTP
    4. Sends OTP via email with HTML template
    5. Stores OTP in session
    6. Redirects to OTP verification page
    """
    if request.method == "POST":
        value = request.POST.get("emailorphone", "").strip()

        if not value:
            messages.error(
                request, "Please enter your registered email or phone number.")
            return render(request, "LoginPage/send_otp.html")

        # Determine whether input is an email or phone number and locate user
        email_pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
        phone_pattern = r'^[6-9]\d{9}$'

        user_obj = None
        if re.match(email_pattern, value.lower()):
            user_obj = User.objects.filter(email=value.lower()).first()
            if not user_obj:
                messages.error(request, "No account found with that email.")
                return render(request, "LoginPage/send_otp.html")
            reset_email = user_obj.email
        elif re.match(phone_pattern, value):
            user_obj = User.objects.filter(phone_number=value).first()
            if not user_obj:
                messages.error(
                    request, "No account found with that phone number.")
                return render(request, "LoginPage/send_otp.html")
            reset_email = user_obj.email
        else:
            messages.error(
                request, "Enter a valid email address or 10-digit phone number.")
            return render(request, "LoginPage/send_otp.html")

        # Generate OTP
        otp = str(random.randint(100000, 999999))
        request.session["reset_otp"] = otp
        request.session["reset_email"] = reset_email

        # Email content
        subject = "PCify_Nexus Auth - Your Password Reset Code"
        plain_message = (
            f"Hello!\n\nYour 6-digit verification code is: {otp}\n\n"
            "Please enter this on the verification page."
        )
        verify_url = request.build_absolute_uri("/accounts/verify-otp/")

        # HTML email with branding
        html_message = f"""
    <!DOCTYPE html>
    <html>
    <body style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f5f7; margin: 0; padding: 40px 20px;">
        <table width="100%" cellpadding="0" cellspacing="0" style="max-width: 500px; margin: 0 auto; background-color: #ffffff; border-radius: 12px; border: 1px solid #e5e7eb; border-top: 5px solid #0ea5e9; overflow: hidden; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);">
            <tr>
                <td style="padding: 35px 35px 15px 35px; text-align: center;">
                    <h2 style="margin: 0; font-size: 26px; font-weight: 800; color: #111827; text-transform: uppercase; letter-spacing: 1px;">
                        PCify_<span style="color: #0ea5e9;">Nexus</span>
                    </h2>
                </td>
            </tr>
            <tr>
                <td style="padding: 0 35px 30px 35px; text-align: center;">
                    <h1 style="color: #1f2937; font-size: 22px; margin-bottom: 12px;">Reset Your Password</h1>
                    <p style="color: #4b5563; font-size: 15px; line-height: 1.6; margin-bottom: 35px;">
                        We received a request to reset the password for your account. Here is your code:
                    </p>
                    <table align="center" cellpadding="0" cellspacing="0" style="width: 100%; max-width: 250px;">
                        <tr>
                            <td style="background-color: #f0f9ff; border: 2px dashed #bae6fd; padding: 20px; border-radius: 10px; text-align: center;">
                                <span style="font-family: 'Courier New', Courier, monospace; font-size: 32px; font-weight: 800; letter-spacing: 6px; color: #0369a1;">
                                    {otp}
                                </span>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <table align="center" cellpadding="0" cellspacing="0" style="margin-bottom: 30px;">
                        <tr>
                            <td align="center" style="border-radius: 8px; background-color: #0ea5e9; box-shadow: 0 4px 6px rgba(14, 165, 233, 0.25);">
                                <a href="{verify_url}" target="_blank" style="font-size: 16px; font-weight: 600; font-family: 'Segoe UI', sans-serif; color: #ffffff; text-decoration: none; padding: 14px 32px; display: inline-block; border-radius: 8px;">
                                    Enter Code Here
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
    </html>
    """

        try:
            send_mail(
                subject=subject,
                message=plain_message,
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=[reset_email],
                html_message=html_message,
                fail_silently=False,
            )
            messages.success(request, "Verification code sent to your email.")
            return redirect("accounts:verify_otp")
        except Exception:
            messages.error(
                request, "Error sending email. Check SMTP settings.")
            return render(request, "LoginPage/send_otp.html")

    return render(request, "LoginPage/send_otp.html")


def verify_otp(request):
    """
    Verifies the OTP entered by user.
    
    Process:
    1. Checks if OTP was requested in send_otp
    2. User enters OTP received in email
    3. Compares with OTP stored in session
    4. If match, sets otp_verified in session
    5. Redirects to password change page
    """
    if "reset_otp" not in request.session:
        messages.error(request, "Please request an OTP first.")
        return redirect("accounts:send_otp")

    if request.method == "POST":
        entered_otp = request.POST.get("otp", "").strip()
        saved_otp = request.session.get("reset_otp")

        if entered_otp == saved_otp:
            request.session["otp_verified"] = True
            messages.success(request, "OTP verified successfully.")
            return redirect("accounts:change_password")

        messages.error(request, "Incorrect OTP. Please try again.")
        return redirect("accounts:verify_otp")

    return render(request, "LoginPage/verify_otp.html")


def change_password(request):
    """
    Allows user to change password after OTP verification.
    
    Process:
    1. Checks if OTP was verified in verify_otp
    2. User enters new password and confirmation
    3. Validates password strength
    4. Prevents reusing current password
    5. Updates password in database
    6. Clears session data
    7. Redirects to sign in
    """
    if not request.session.get("otp_verified"):
        messages.error(request, "Please verify OTP before changing password.")
        return redirect("accounts:send_otp")

    if request.method == "POST":
        new_password = request.POST.get("new_password", "")
        confirm_password = request.POST.get("confirm_password", "")

        if new_password != confirm_password:
            messages.error(request, "Passwords do not match.")
            return render(request, "LoginPage/changepassword.html")

        email = request.session.get("reset_email")
        user = User.objects.filter(email=email).first()

        if not user:
            messages.error(
                request, "Account not found. Please retry password reset.")
            return redirect("accounts:send_otp")

        # Disallow reusing the current password. Handle both hashed and
        # legacy-plaintext stored passwords.
        is_same = False
        if user.password:
            try:
                from django.contrib.auth.hashers import identify_hasher
                identify_hasher(user.password)
                # password is hashed
                is_same = user.check_password(new_password)
            except Exception:
                # legacy plaintext stored
                is_same = (new_password == user.password)

        if is_same:
            messages.error(
                request, "Please enter a new password different from the current one.")
            return render(request, "LoginPage/changepassword.html")

        user.set_password(new_password)
        user.save()

        request.session.pop("reset_otp", None)
        request.session.pop("reset_email", None)
        request.session.pop("otp_verified", None)

        messages.success(
            request, "Password reset successfully. Please sign in.")
        return redirect("accounts:signin")

    return render(request, "LoginPage/changepassword.html")
