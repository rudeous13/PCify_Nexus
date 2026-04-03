import hashlib
import hmac

from django.conf import settings

try:
    from cashfree_pg.api_client import Cashfree
    from cashfree_pg.models.create_order_request import CreateOrderRequest
    from cashfree_pg.models.customer_details import CustomerDetails
    from cashfree_pg.models.order_meta import OrderMeta
except ImportError:
    Cashfree = None
    CreateOrderRequest = None
    CustomerDetails = None
    OrderMeta = None


def _init_cashfree():
    if Cashfree is None:
        raise RuntimeError(
            "cashfree-pg is not installed in the active environment.")

    Cashfree.XClientId = settings.CASHFREE_CLIENT_ID
    Cashfree.XClientSecret = settings.CASHFREE_CLIENT_SECRET
    env = (settings.CASHFREE_ENV or "sandbox").lower()
    Cashfree.XEnvironment = (
        Cashfree.XProduction if env == "production" else Cashfree.XSandbox
    )


def create_cashfree_order(amount, currency, customer_details, order_meta):
    _init_cashfree()
    x_api_version = settings.CASHFREE_API_VERSION
    customer = CustomerDetails(**customer_details)
    meta = OrderMeta(**order_meta) if order_meta else None
    order_request = CreateOrderRequest(
        order_amount=amount,
        order_currency=currency,
        customer_details=customer,
        order_meta=meta,
    )
    response = Cashfree().PGCreateOrder(x_api_version, order_request, None, None)
    return response.data


def fetch_cashfree_order(order_id):
    _init_cashfree()
    x_api_version = settings.CASHFREE_API_VERSION
    response = Cashfree().PGFetchOrder(x_api_version, order_id, None)
    return response.data


def verify_cashfree_signature(payload_body, signature, secret):
    if not signature or not secret:
        return False
    expected = hmac.new(
        secret.encode("utf-8"), payload_body, hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(expected, signature)
