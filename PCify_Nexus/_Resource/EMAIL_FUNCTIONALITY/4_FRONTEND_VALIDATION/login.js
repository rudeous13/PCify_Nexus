"""
FRONTEND VALIDATION FOR EMAIL AND FORM HANDLING

Add this to your static / LoginPage / login.js file.

This JavaScript file handles:
1. Email validation(format and domain checking)
2. Password strength meter
3. Form submission validation
4. Password toggle visibility
5. Theme toggle functionality
"""

// Email validation patterns and allowed domains
const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const allowedDomains = ["gmail.com", "yahoo.com", "outlook.com", "hotmail.com"];

/**
 * Validates email format and domain
 * @param {string} email - The email address to validate
 * @returns {boolean} - True if email is valid
 */
function isValidEmail(email) {
    const emailValue = email.trim();
    if (!emailValue) return false;

    if (!emailPattern.test(emailValue)) return false;

    const emailDomain = emailValue.split("@")[1]?.toLowerCase();
    return allowedDomains.includes(emailDomain);
}

/**
 * Scores password strength (1-4)
 * @param {string} pw - The password to score
 * @returns {number} - Strength score (0-4)
 */
function scorePassword(pw) {
    if (!pw || pw.length === 0) return 0;
    let score = 0;
    if (pw.length >= 8) score++;
    if (pw.length >= 12) score++;
    if (/[a-z]/.test(pw) && /[A-Z]/.test(pw)) score++;
    if (/\d/.test(pw)) score++;
    if (/[^A-Za-z0-9]/.test(pw)) score++;

    if (score <= 1) return 1; // Weak
    if (score === 2) return 2; // Medium
    if (score === 3) return 3; // Good
    return 4; // Strong
}

/**
 * Updates the password strength meter display
 * @param {string} val - The password value
 * @param {string} barId - The ID of the progress bar element
 */
function updateStrengthMeter(val, barId = 'strength-bar') {
    const bar = document.getElementById(barId);
    if (!bar) return;

    if (!val) {
        bar.style.width = '0%';
        return;
    }

    const score = scorePassword(val);
    const width = (score / 4) * 100;
    let color = '#ff4d4d'; // Red - Weak
    if (score > 2) color = '#ffb86b'; // Orange - Good
    if (score === 4) color = '#10b981'; // Green - Strong

    bar.style.width = width + '%';
    bar.style.backgroundColor = color;
}

/**
 * Toggles password visibility
 * @param {string} id - The ID of the password input
 * @param {HTMLElement} btn - The toggle button element
 */
function togglePass(id, btn) {
    const input = document.getElementById(id);
    const isHidden = input.type === "password";

    input.type = isHidden ? "text" : "password";

    if (isHidden) {
        // Eye Slash (visible)
        btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.94 10.94 0 0 1 12 20c-7 0-10-6.5-10-8a10.3 10.3 0 0 1 3.05-4.22"></path><path d="M1 1l22 22"></path></svg>';
        btn.classList.add('active-eye');
    } else {
        // Eye (hidden)
        btn.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z"></path><circle cx="12" cy="12" r="3"></circle></svg>';
        btn.classList.remove('active-eye');
    }
}

/**
 * Marks an input field as having an error
 * @param {HTMLElement} input - The input element
 * @param {string} message - The error message to display
 */
function markFormError(input, message) {
    input.classList.add('input-error');
    const span = input.closest('.space-y-2')?.querySelector('.error-msg');
    if (span) span.innerText = message;
}

/**
 * Clears error state from an input field
 * @param {HTMLElement} input - The input element
 */
function clearFormError(input) {
    input.classList.remove('input-error');
    const span = input.closest('.space-y-2')?.querySelector('.error-msg');
    if (span) span.innerText = '';
}

// ============================================================================
// SIGNUP FORM VALIDATION
// ============================================================================

const signupForm = document.querySelector('#signup-container form');

if (signupForm) {
    const inputs = signupForm.querySelectorAll('input');

    // Remove error on typing
    inputs.forEach(input => {
        input.addEventListener('input', () => {
            clearFormError(input);
        });
    });

    signupForm.addEventListener('submit', function (e) {
        e.preventDefault();

        let valid = true;
        let firstErrorInput = null;

        const firstName = signupForm.querySelector('[name="firstname"]');
        const lastName = signupForm.querySelector('[name="lastname"]');
        const emailInput = signupForm.querySelector('[name="email"]');
        const phoneInput = signupForm.querySelector('[name="phone"]');
        const passwordInput = signupForm.querySelector('#signup-pass');
        const confirmPassInput = signupForm.querySelector('#signup-confirm-pass');

        // First name validation
        if (!firstName.value.trim()) {
            markFormError(firstName, "First name is required.");
            if (valid) firstErrorInput = firstName;
            valid = false;
        } else if (!/^[A-Za-z]+$/.test(firstName.value)) {
            markFormError(firstName, "Only letters allowed.");
            if (valid) firstErrorInput = firstName;
            valid = false;
        }

        // Last name validation
        if (!lastName.value.trim()) {
            markFormError(lastName, "Last name is required.");
            if (valid) firstErrorInput = lastName;
            valid = false;
        } else if (!/^[A-Za-z]+$/.test(lastName.value)) {
            markFormError(lastName, "Only letters allowed.");
            if (valid) firstErrorInput = lastName;
            valid = false;
        }

        // Email validation
        if (!isValidEmail(emailInput.value)) {
            if (!emailInput.value.trim()) {
                markFormError(emailInput, "Email is required.");
            } else if (!emailPattern.test(emailInput.value.trim())) {
                markFormError(emailInput, "Invalid email format.");
            } else {
                markFormError(emailInput, "Use Gmail, Yahoo, Outlook or Hotmail.");
            }
            if (valid) firstErrorInput = emailInput;
            valid = false;
        }

        // Phone validation
        if (!phoneInput.value.trim()) {
            markFormError(phoneInput, "Phone number is required.");
            if (valid) firstErrorInput = phoneInput;
            valid = false;
        } else if (!/^[6-9]\d{9}$/.test(phoneInput.value.trim())) {
            markFormError(phoneInput, "Enter valid 10-digit number starting 6–9.");
            if (valid) firstErrorInput = phoneInput;
            valid = false;
        }

        // Password validation
        if (!passwordInput.value) {
            markFormError(passwordInput, "Password is required.");
            if (valid) firstErrorInput = passwordInput;
            valid = false;
        } else if (scorePassword(passwordInput.value) < 3) {
            markFormError(passwordInput, "Password is too weak.");
            if (valid) firstErrorInput = passwordInput;
            valid = false;
        }

        // Confirm password validation
        if (!confirmPassInput.value) {
            markFormError(confirmPassInput, "Please confirm password.");
            if (valid) firstErrorInput = confirmPassInput;
            valid = false;
        } else if (passwordInput.value !== confirmPassInput.value) {
            markFormError(confirmPassInput, "Passwords do not match.");
            if (valid) firstErrorInput = confirmPassInput;
            valid = false;
        }

        if (!valid) {
            firstErrorInput?.focus();
            return false;
        }

        signupForm.submit();
    });
}

// ============================================================================
// SIGNIN FORM VALIDATION
// ============================================================================

const signinForm = document.querySelector('#signin-container form');

if (signinForm) {
    const inputs = signinForm.querySelectorAll("input");

    inputs.forEach(input => {
        input.addEventListener("input", () => {
            clearFormError(input);
        });
    });

    signinForm.addEventListener("submit", (e) => {
        let valid = true;

        const email = signinForm.querySelector('[name="emailorphone"]');
        const pass = signinForm.querySelector('[name="password"]');

        if (!email.value.trim()) {
            markFormError(email, "Email or phone is required.");
            valid = false;
        }

        if (!pass.value.trim()) {
            markFormError(pass, "Password is required.");
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
        }
    });
}

// ============================================================================
// PASSWORD STRENGTH METER
// ============================================================================

const passInput = document.getElementById('signup-pass');
if (passInput) {
    passInput.addEventListener('input', function (e) {
        updateStrengthMeter(e.target.value, 'strength-bar');
    });
}

const changePassInput = document.getElementById('new-pass');
if (changePassInput) {
    changePassInput.addEventListener('input', function (e) {
        updateStrengthMeter(e.target.value, 'change-strength-bar');
    });
}

// ============================================================================
// CHANGE PASSWORD FORM VALIDATION
// ============================================================================

const changePasswordForm = document.querySelector('form[action*="change-password"]');

if (changePasswordForm) {
    const newPass = changePasswordForm.querySelector('[name="new_password"]');
    const confirmPass = changePasswordForm.querySelector('[name="confirm_password"]');
    const inputs = changePasswordForm.querySelectorAll('input');

    inputs.forEach(input => {
        input.addEventListener('input', () => {
            clearFormError(input);
        });
    });

    changePasswordForm.addEventListener('submit', (e) => {
        let valid = true;

        if (!newPass.value.trim()) {
            markFormError(newPass, 'Password is required.');
            valid = false;
        } else if (scorePassword(newPass.value) < 3) {
            markFormError(newPass, 'Password is too weak.');
            valid = false;
        }

        if (!confirmPass.value.trim()) {
            markFormError(confirmPass, 'Please confirm password.');
            valid = false;
        } else if (newPass.value !== confirmPass.value) {
            markFormError(confirmPass, 'Passwords do not match.');
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
        }
    });
}

// ============================================================================
// THEME TOGGLE
// ============================================================================

const themeBtn = document.getElementById('themeToggle');
if (themeBtn) {
    const themeIcon = document.getElementById('themeIcon');

    themeBtn.addEventListener('click', () => {
        const html = document.documentElement;
        const current = html.getAttribute('data-theme');
        const next = current === 'dark' ? 'light' : 'dark';

        html.setAttribute('data-theme', next);

        if (next === 'dark') {
            // Sun Icon
            themeIcon.innerHTML = '<circle cx="12" cy="12" r="5"/><path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/>';
        } else {
            // Moon Icon
            themeIcon.innerHTML = '<path d="M12 3a9 9 0 1 0 9 9c0-.46-.04-.92-.1-1.36a5.389 5.389 0 0 1-4.4 2.26 5.403 5.403 0 0 1-3.14-9.8c-.44-.06-.9-.1-1.36-.1z"/>';
        }
    });
}
