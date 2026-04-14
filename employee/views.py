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
                messages.success(request, f"Welcome back, {user.first_name or 'Tech'}!")

                next_url = request.GET.get('next', 'employee:tasks')
                return redirect(next_url)
            else:
                messages.error(request, "Access restricted to Nexus Tech employees only.")
        else:
            messages.error(request, "Invalid email or password.")
        
    return render(request, 'EmployeePage/login.html')

@login_required(login_url='employee:login')
def dashboard_redirect(request):
    return redirect('employee:tasks')

@login_required(login_url='employee:login')
def tasks_view(request):
    context = {
        'stats': {
            'total_assigned': 12,
            'in_progress': 3,
            'pending_queue': 5,
            'completed_today': 4
        },
        'active_task': {
            'task_id': 'TSK-8921',
            'title': 'Motherboard Replacement',
            'description': 'Replace faulty ASUS B550 with new unit.',
            'customer_name': 'John Doe',
            'customer_phone': '+1 555-0192',
            'customer_address': '123 Tech Lane, NY',
            'delivery_type': 'In-Shop',
            'task_type': 'Assembly',
            'parts_html': '<li class="py-2"><i class="bi bi-cpu text-brand-400 mr-2"></i> ASUS B550 Motherboard</li>'
        },
        'tasks': [
            {
                'task_id': 'TSK-8922',
                'title': 'Data Recovery',
                'customer_name': 'Alice Smith',
                'description': 'Recover files from corrupted HDD.',
                'task_type': 'Diagnostics',
            }
        ]
    }
    return render(request, 'EmployeePage/task.html', context)

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