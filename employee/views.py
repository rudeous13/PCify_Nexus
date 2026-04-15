from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages


def login_view(request):
    if request.user.is_authenticated:
        if request.user.role in ['employee', 'admin']:
            return redirect('employee:tasks')
        else:
            # Prevent standard customers from hanging around the employee login page
            logout(request)
            messages.error(request, "Unauthorized. Employee access required.")

    if request.method == "POST":
        # 2. Extract credentials.
        # Note: Your HTML uses name="username", but it expects an email address.
        email = request.POST.get("username")
        password = request.POST.get("password")

        # 3. Authenticate against the custom User model
        user = authenticate(request, username=email, password=password)

        if user is not None:
            # 4. Verify Role - strictly block 'customer' accounts
            if user.role in ['employee', 'admin']:
                login(request, user)
                messages.success(
                    request, f"Welcome back, {user.first_name or 'Tech'}!")

                next_url = request.GET.get('next', 'employee:tasks')
                return redirect(next_url)
            else:
                messages.error(
                    request, "Access restricted to Nexus Tech employees only.")
        else:
            messages.error(request, "Invalid email or password.")

    return render(request, 'EmployeePage/login.html')


@login_required(login_url='employee:login')
def dashboard_redirect(request):
    return redirect('employee:tasks')


@login_required(login_url='employee:login')
def tasks_view(request):
    from .models import EmployeeTask
    from django.utils import timezone
    from django.db.models import Count, Q

    # Get today's date for filtering
    today = timezone.now().date()

    # Calculate statistics
    stats = {
        'total_assigned': EmployeeTask.objects.filter(assigned_to=request.user).count(),
        'in_progress': EmployeeTask.objects.filter(assigned_to=request.user, status='in_progress').count(),
        'pending_queue': EmployeeTask.objects.filter(assigned_to=request.user, status='pending').count(),
        'completed_today': EmployeeTask.objects.filter(
            assigned_to=request.user,
            status='completed',
            completed_at__date=today
        ).count()
    }

    # Get active task (in progress)
    active_task = EmployeeTask.objects.filter(
        assigned_to=request.user,
        status='in_progress'
    ).first()

    # Get pending tasks
    tasks = EmployeeTask.objects.filter(
        assigned_to=request.user,
        status='pending'
    ).order_by('priority', 'created_at')

    context = {
        'stats': stats,
        'active_task': active_task,
        'tasks': tasks
    }

    return render(request, 'EmployeePage/task.html', context)


@login_required(login_url='employee:login')
def start_task(request, task_id):
    from .models import EmployeeTask

    try:
        task = EmployeeTask.objects.get(
            task_id=task_id, assigned_to=request.user)

        # Check if there's already an active task
        active_task = EmployeeTask.objects.filter(
            assigned_to=request.user,
            status='in_progress'
        ).first()

        if active_task and active_task != task:
            messages.warning(
                request, f"You already have an active task: {active_task.task_id}")
        else:
            task.status = 'in_progress'
            task.save()
            messages.success(request, f"Started task: {task.task_id}")

    except EmployeeTask.DoesNotExist:
        messages.error(
            request, "Task not found or you don't have permission to access it.")

    return redirect('employee:tasks')


@login_required(login_url='employee:login')
def complete_task(request, task_id):
    from .models import EmployeeTask

    try:
        task = EmployeeTask.objects.get(
            task_id=task_id, assigned_to=request.user)
        task.status = 'completed'
        task.save()
        messages.success(request, f"Completed task: {task.task_id}")

    except EmployeeTask.DoesNotExist:
        messages.error(
            request, "Task not found or you don't have permission to access it.")

    return redirect('employee:tasks')


@login_required(login_url='employee:login')
def services_view(request):
    context = {
        'stats': {
            'total_active_services': 8,
            'needs_diagnostics': 2
        },
        'services': [
            {
                'ticket_id': 'SRV-104',
                'customer_name': 'Sarah Connor',
                'device_name': 'Dell XPS 15',
                'reported_issue': 'Overheating and unexpected shutdowns.',
                'status': 'Diagnostics',
                'icon_class': 'bi-laptop'
            }
        ]
    }
    return render(request, 'EmployeePage/service.html', context)


@login_required(login_url='employee:login')
def builds_view(request):
    context = {
        'stats': {
            'builds_in_queue': 6,
            'pending_testing': 1
        },
        'builds': [
            {
                'order_id': 'BLD-409',
                'configuration_name': 'Titan RTX Workstation',
                'customer_name': 'TechCorp Inc.',
                'customer_phone': '555-8821',
                'description': 'High-end 3D rendering machine.',
                'status': 'Assembling',
                'parts_html': '<li class="part-item py-1"><label class="flex items-center gap-2"><input type="checkbox" class="accent-brand-500"> RTX 4090</label></li>'
            }
        ]
    }
    # Note: Renaming 'buildes.html' to 'builds.html' on your file system is highly recommended.
    return render(request, 'EmployeePage/buildes.html', context)


@login_required(login_url='employee:login')
def delivery_view(request):
    context = {
        'stats': {
            'total_assigned': 15,
            'out_for_delivery': 4,
            'pending_dispatch': 3,
            'delivered': 8
        },
        'deliveries': [
            {
                'tracking_id': 'TRK-9923',
                'customer_name': 'Bob Vance',
                'customer_phone': '555-0011',
                'customer_address': 'Vance Refrigeration, Scranton PA',
                'order_type': 'Custom Build',
                'order_type_icon': 'bi-pc',
                'order_ref': 'BLD-408',
                'status': 'Out for Delivery'
            }
        ]
    }
    return render(request, 'EmployeePage/delivery.html', context)


@login_required(login_url='employee:login')
def completed_view(request):
    context = {
        'stats': {
            'total_completed': 142,
            'completed_month': 28,
            'avg_resolution_time': 2.4
        },
        'completed_tasks': [
            {
                'task_id': 'DON-771',
                'title': 'Thermal Paste Reapplication',
                'customer_name': 'Gamer123',
                'category': 'Service',
                'category_icon': 'bi-wrench',
                'completed_date': 'Oct 24, 2023',
                'notes': 'Cleaned old paste, applied Kryonaut. Temps dropped 15C.'
            }
        ]
    }
    # Note: Renaming 'completed_Work.html' to 'completed_work.html' is highly recommended.
    return render(request, 'EmployeePage/completed_Work.html', context)
