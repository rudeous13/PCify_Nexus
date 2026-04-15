import hashlib
import hmac
import datetime
from decimal import Decimal

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


def _get_cashfree_client():
    if Cashfree is None:
        raise RuntimeError(
            "cashfree-pg is not installed in the active environment.")

    env = (settings.CASHFREE_ENV or "sandbox").lower()
    x_environment = Cashfree.PRODUCTION if env == "production" else Cashfree.SANDBOX
    return Cashfree(
        XEnvironment=x_environment,
        XClientId=settings.CASHFREE_CLIENT_ID,
        XClientSecret=settings.CASHFREE_CLIENT_SECRET,
    )


def _normalize_cashfree_payload(payload):
    if payload is None:
        return None
    if hasattr(payload, "model_dump"):
        return payload.model_dump(by_alias=True)
    if hasattr(payload, "dict"):
        return payload.dict()
    if hasattr(payload, "to_dict"):
        return payload.to_dict()
    return payload


def _make_json_serializable(obj):
    if obj is None:
        return None
    if isinstance(obj, (str, bool, int, float)):
        return obj
    if isinstance(obj, (datetime.datetime, datetime.date, datetime.time)):
        try:
            return obj.isoformat()
        except Exception:
            return str(obj)
    if isinstance(obj, Decimal):
        return str(obj)
    if isinstance(obj, dict):
        return {k: _make_json_serializable(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple, set)):
        return [_make_json_serializable(v) for v in obj]
    return str(obj)


def create_cashfree_order(amount, currency, customer_details, order_meta):
    # Check if Cashfree is available
    if CustomerDetails is None or CreateOrderRequest is None:
        raise ImportError("cashfree_pg package is not installed. Please install it to use payment functionality.")
    
    x_api_version = settings.CASHFREE_API_VERSION
    customer = CustomerDetails(**customer_details)
    meta = OrderMeta(**order_meta) if order_meta else None
    order_request = CreateOrderRequest(
        order_amount=amount,
        order_currency=currency,
        customer_details=customer,
        order_meta=meta,
    )
    client = _get_cashfree_client()
    response = client.PGCreateOrder(x_api_version, order_request, None, None)
    return _make_json_serializable(_normalize_cashfree_payload(response.data))


def fetch_cashfree_order(order_id):
    x_api_version = settings.CASHFREE_API_VERSION
    client = _get_cashfree_client()
    response = client.PGFetchOrder(x_api_version, order_id, None)
    return _make_json_serializable(_normalize_cashfree_payload(response.data))


def fetch_cashfree_payments_for_order(order_id):
    """
    Fetch all payment attempts for a Cashfree order.
    Returns a list of payment dicts, each containing payment_group
    (e.g. 'wallet', 'upi', 'credit_card', 'debit_card', 'net_banking').
    """
    try:
        x_api_version = settings.CASHFREE_API_VERSION
        client = _get_cashfree_client()
        response = client.PGOrderFetchPayments(x_api_version, order_id, None)
        data = response.data
        if data is None:
            return []
        if isinstance(data, list):
            return [_make_json_serializable(_normalize_cashfree_payload(p)) for p in data]
        return [_make_json_serializable(_normalize_cashfree_payload(data))]
    except Exception:
        return []


def verify_cashfree_signature(payload_body, signature, secret):
    if not signature or not secret:
        return False
    expected = hmac.new(
        secret.encode("utf-8"), payload_body, hashlib.sha256
    ).hexdigest()
    return hmac.compare_digest(expected, signature)
