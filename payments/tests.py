from django.test import TestCase
from django.urls import reverse
from payments.views import _infer_payment_method


class CashfreeOrderTests(TestCase):
    def test_checkout_requires_login(self):
        url = reverse("payments:checkout")
        response = self.client.get(url)
        self.assertEqual(response.status_code, 302)

    def test_create_order_requires_login(self):
        url = reverse("payments:create_order")
        response = self.client.post(url)
        self.assertEqual(response.status_code, 401)


class PaymentMethodDetectionTest(TestCase):
    """Test _infer_payment_method against real Cashfree payment_group values."""

    # --- payment_group based detection (primary path) ---
    def test_wallet_via_payment_group(self):
        payload = {"payment": [
            {"payment_group": "wallet", "cf_payment_id": "1"}]}
        self.assertEqual(_infer_payment_method(payload), "wallet")

    def test_upi_via_payment_group(self):
        payload = {"payment": [{"payment_group": "upi", "cf_payment_id": "2"}]}
        self.assertEqual(_infer_payment_method(payload), "upi")

    def test_credit_card_via_payment_group(self):
        payload = {"payment": [{"payment_group": "credit_card"}]}
        self.assertEqual(_infer_payment_method(payload), "card")

    def test_debit_card_via_payment_group(self):
        payload = {"payment": [{"payment_group": "debit_card"}]}
        self.assertEqual(_infer_payment_method(payload), "card")

    def test_net_banking_via_payment_group(self):
        payload = {"payment": [{"payment_group": "net_banking"}]}
        self.assertEqual(_infer_payment_method(payload), "netbanking")

    def test_emi_via_payment_group(self):
        payload = {"payment": [{"payment_group": "emi"}]}
        self.assertEqual(_infer_payment_method(payload), "cardless_emi")

    # --- payment_method string detection (secondary path) ---
    def test_wallet_via_method_field(self):
        self.assertEqual(_infer_payment_method(
            {"payment_method": "wallet"}), "wallet")

    def test_upi_via_method_field(self):
        self.assertEqual(_infer_payment_method(
            {"payment_method": "upi"}), "upi")

    def test_card_via_method_field(self):
        self.assertEqual(_infer_payment_method(
            {"payment_method": "card"}), "card")

    def test_netbanking_via_method_field(self):
        self.assertEqual(_infer_payment_method(
            {"payment_method": "netbanking"}), "netbanking")

    # --- False positive: "customer_bank_code" must NOT trigger COD ---
    def test_cashfree_order_response_no_false_cod(self):
        """Real Cashfree order response — must NOT return 'cod'."""
        payload = {
            "entity": "order",
            "order_id": "order_abc",
            "order_status": "PAID",
            "customer_details": {
                "customer_id": "user_1",
                "customer_bank_code": None,
                "customer_bank_account_number": None,
            },
        }
        result = _infer_payment_method(payload)
        self.assertNotEqual(result, "cod",
                            "customer_bank_code must not trigger false COD detection")

    # --- Unknown / empty payloads return None ---
    def test_empty_dict_returns_none(self):
        self.assertIsNone(_infer_payment_method({}))

    def test_none_returns_none(self):
        self.assertIsNone(_infer_payment_method(None))

    def test_unknown_method_returns_none(self):
        self.assertIsNone(_infer_payment_method(
            {"payment_method": "unknown_xyz"}))

    # --- Realistic end-to-end payload (order + payment list) ---
    def test_realworld_wallet_payment(self):
        payload = {
            "entity": "order",
            "order_id": "order_110358833",
            "order_status": "PAID",
            "customer_details": {"customer_bank_code": None},
            "payment": [
                {
                    "cf_payment_id": "123",
                    "payment_group": "wallet",
                    "payment_method": {"wallet": {"channel": "amazon_pay"}},
                    "payment_status": "SUCCESS",
                }
            ],
        }
        self.assertEqual(_infer_payment_method(payload), "wallet")
