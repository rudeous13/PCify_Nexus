from django.test import TestCase
from django.urls import reverse


class CashfreeOrderTests(TestCase):
    def test_checkout_requires_login(self):
        url = reverse("payments:checkout")
        response = self.client.get(url)
        self.assertEqual(response.status_code, 302)

    def test_create_order_requires_login(self):
        url = reverse("payments:create_order")
        response = self.client.post(url)
        self.assertEqual(response.status_code, 401)
