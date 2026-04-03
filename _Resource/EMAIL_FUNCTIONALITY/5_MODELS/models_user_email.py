"""
USER MODEL WITH EMAIL FUNCTIONALITY

Add this User model to your accounts/models.py file.

Key features:
1. Email as unique identifier (using AbstractBaseUser)
2. Phone number for alternative login
3. Profile image support
4. Role-based access control (Admin, Customer, Employee)
5. Timestamp tracking (created_at, updated_at)
6. Password hashing with Django's auth system
"""

from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.contrib.auth.hashers import identify_hasher, make_password
from django.db import models


class UserManager(BaseUserManager):
    """
    Custom manager for the User model.
    Used to create regular users and superusers.
    """
    use_in_migrations = True

    def create_user(self, email, password=None, **extra_fields):
        """
        Creates a regular user with email and password.
        """
        if not email:
            raise ValueError("The Email must be set")

        email = self.normalize_email(email)
        extra_fields.setdefault("role", User.Roles.CUSTOMER)
        user = self.model(email=email, **extra_fields)

        if password:
            user.set_password(password)
        else:
            user.set_unusable_password()

        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        """
        Creates a superuser (admin) with email and password.
        """
        extra_fields["role"] = User.Roles.ADMIN
        return self.create_user(email, password, **extra_fields)

    def get_by_natural_key(self, username):
        """
        Allows authentication using email as the natural key.
        """
        return self.get(email__iexact=username)


class User(AbstractBaseUser):
    """
    Custom user model using email instead of username.
    
    Fields:
    - user_id: Auto-incrementing primary key
    - email: Unique email address (required)
    - phone_number: Alternative contact method
    - first_name & last_name: User's full name
    - password: Hashed password
    - profile_image: Optional profile picture
    - role: User's role (Admin, Customer, Employee)
    - is_active: Account status
    - created_at & updated_at: Timestamps
    """
    
    class Roles(models.TextChoices):
        """Available user roles"""
        ADMIN = "admin", "Admin"
        CUSTOMER = "customer", "Customer"
        EMPLOYEE = "employee", "Employee"

    # Primary key
    user_id = models.AutoField(primary_key=True)
    
    # Personal information
    first_name = models.CharField(max_length=100, blank=True, null=True)
    last_name = models.CharField(max_length=100, blank=True, null=True)
    
    # Authentication (email-based login)
    email = models.EmailField(max_length=150, unique=True)
    
    # Alternative contact
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    
    # Security
    password = models.CharField(max_length=255, db_column="password_hash")
    
    # Profile
    profile_image = models.ImageField(
        upload_to="profile_images/", blank=True, null=True)
    
    # Authorization
    role = models.CharField(
        max_length=20, choices=Roles.choices, default=Roles.CUSTOMER)
    is_active = models.BooleanField(default=True)

    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    # Django authentication settings
    USERNAME_FIELD = "email"  # Use email as login identifier
    REQUIRED_FIELDS = ["first_name", "last_name"]  # Required for creation

    objects = UserManager()

    class Meta:
        verbose_name = "User"
        verbose_name_plural = "Users"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["email"]),
            models.Index(fields=["phone_number"]),
        ]

    def __str__(self):
        return f"{self.email} - {self.get_role_display()}"

    @property
    def full_name(self):
        """Returns the user's full name"""
        return f"{self.first_name} {self.last_name}".strip()

    @property
    def is_admin(self):
        """Check if user is an admin"""
        return self.role == self.Roles.ADMIN

    @property
    def is_employee(self):
        """Check if user is an employee"""
        return self.role == self.Roles.EMPLOYEE

    @property
    def is_customer(self):
        """Check if user is a customer"""
        return self.role == self.Roles.CUSTOMER

    @property
    def is_staff(self):
        """Required for Django admin - true if admin or employee"""
        return self.role in [self.Roles.ADMIN, self.Roles.EMPLOYEE]

    @property
    def is_superuser(self):
        """Required for Django admin - true if admin"""
        return self.role == self.Roles.ADMIN
