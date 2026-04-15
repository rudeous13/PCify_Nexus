from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from employee.models import EmployeeTask
from orders.models import Order
from services.models import ServiceRequest
from django.utils import timezone

User = get_user_model()


class Command(BaseCommand):
    help = 'Populate the database with sample employee tasks'

    def handle(self, *args, **options):
        # Get or create test users
        employee, created = User.objects.get_or_create(
            email='employee@nexustech.com',
            defaults={
                'first_name': 'Alex',
                'last_name': 'Tech',
                'role': 'employee',
                'password': 'testpassword123'
            }
        )

        customer, created = User.objects.get_or_create(
            email='customer@example.com',
            defaults={
                'first_name': 'John',
                'last_name': 'Doe',
                'role': 'customer',
                'password': 'testpassword123'
            }
        )

        # Create sample tasks
        tasks_data = [
            {
                'title': 'Motherboard Replacement',
                'description': 'Replace faulty ASUS B550 with new unit.',
                'task_type': 'assembly',
                'status': 'in_progress',
                'customer': customer,
                'assigned_to': employee,
                'customer_phone': '+1 555-0192',
                'customer_address': '123 Tech Lane, New York, NY',
                'delivery_type': 'in_shop',
                'priority': 1
            },
            {
                'title': 'Data Recovery',
                'description': 'Recover files from corrupted HDD.',
                'task_type': 'diagnostics',
                'status': 'pending',
                'customer': customer,
                'assigned_to': employee,
                'customer_phone': '+1 555-0193',
                'customer_address': '456 Computer Ave, Boston, MA',
                'delivery_type': 'pickup',
                'priority': 2
            },
            {
                'title': 'GPU Upgrade',
                'description': 'Install new RTX 4070 graphics card.',
                'task_type': 'assembly',
                'status': 'pending',
                'customer': customer,
                'assigned_to': employee,
                'customer_phone': '+1 555-0194',
                'customer_address': '789 Gaming St, Los Angeles, CA',
                'delivery_type': 'delivery',
                'priority': 3
            },
            {
                'title': 'Virus Removal',
                'description': 'Remove malware and optimize system.',
                'task_type': 'repair',
                'status': 'pending',
                'customer': customer,
                'assigned_to': employee,
                'customer_phone': '+1 555-0195',
                'customer_address': '321 Security Blvd, Chicago, IL',
                'delivery_type': 'in_shop',
                'priority': 1
            }
        ]

        created_count = 0
        for task_data in tasks_data:
            task, created = EmployeeTask.objects.get_or_create(
                title=task_data['title'],
                customer=task_data['customer'],
                defaults=task_data
            )
            if created:
                created_count += 1

        self.stdout.write(
            self.style.SUCCESS(
                f'Successfully created {created_count} sample tasks')
        )
        self.stdout.write(
            self.style.SUCCESS(
                f'Employee login: employee@nexustech.com / testpassword123')
        )
