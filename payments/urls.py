from django.urls import path

from . import views

app_name = "payments"

urlpatterns = [
    path("checkout/", views.checkout, name="checkout"),
    path("create-order/", views.create_order, name="create_order"),
    path("return/", views.payment_return, name="payment_return"),
    path("webhook/", views.payment_webhook, name="payment_webhook"),
]
