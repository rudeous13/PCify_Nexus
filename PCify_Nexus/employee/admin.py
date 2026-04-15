from django.contrib import admin
from .models import EmployeeTask, TaskAssignment


@admin.register(EmployeeTask)
class EmployeeTaskAdmin(admin.ModelAdmin):
    list_display = ['task_id', 'title', 'task_type', 'status',
                    'assigned_to', 'customer', 'priority', 'created_at']
    list_filter = ['task_type', 'status', 'priority', 'created_at']
    search_fields = ['task_id', 'title', 'customer__email',
                     'customer__first_name', 'customer__last_name']
    readonly_fields = ['task_id', 'created_at',
                       'assigned_at', 'started_at', 'completed_at']

    fieldsets = [
        ('Task Information', {
            'fields': ['task_id', 'title', 'description', 'task_type', 'status', 'priority']
        }),
        ('Assignment', {
            'fields': ['assigned_to', 'assigned_at', 'started_at', 'completed_at']
        }),
        ('Customer Information', {
            'fields': ['customer', 'customer_address', 'customer_phone', 'delivery_type']
        }),
        ('Related Items', {
            'fields': ['order', 'service_request', 'notes']
        }),
    ]


@admin.register(TaskAssignment)
class TaskAssignmentAdmin(admin.ModelAdmin):
    list_display = ['task', 'employee',
                    'assigned_by', 'assigned_at', 'completed_at']
    list_filter = ['assigned_at', 'completed_at']
    readonly_fields = ['assigned_at']
