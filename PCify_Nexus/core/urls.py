# Import file or packages
from django.urls import path
from . import views
from orders import views as orders_views

# App name
app_name = "core"

# All urls of core app
urlpatterns = [
    path('', views.homepage, name="homepage"),
    path('prebuilt', views.prebuilt, name="prebuilt"),
    path('built', views.built, name="built"),
    path('accessories', views.accessories, name="accessories"),
    path('cart', views.cart, name="cart"),
    path('profile', views.profile, name="profile"),

    # Build management endpoints
    path('save-pc-build/', views.save_pc_build, name="save_pc_build"),
    path('delete-build/<int:build_id>/',
         views.delete_pc_build, name="delete_build"),
    path('load-build/<int:build_id>/', views.load_pc_build, name="load_build"),
    path('load-prebuilt/<int:build_id>/',
         views.load_prebuilt_config, name="load_prebuilt"),

    path('profile/builds/', views.pro_builds, name="pro_builds"),
    path('profile/order', views.pro_order, name="pro_order"),
    path('profile/order/<int:order_id>/receipt/',
         orders_views.invoice_view, name='order_receipt'),
    path('profile/security', views.pro_security, name="pro_security"),
    path('profile/setting', views.pro_setting, name="pro_setting")
]
