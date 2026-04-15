# PCify Nexus - Cashfree Checkout

This project now includes a Cashfree checkout flow that creates a Cashfree order server-side, opens the Cashfree web checkout, and confirms payment status on return/webhook.

## Environment variables

Set these before running the server:

- `CASHFREE_APP_ID`
- `CASHFREE_SECRET_KEY`
- `CASHFREE_ENV` (use `sandbox` or `production`)
- `CASHFREE_API_VERSION` (default: `2023-08-01`)
- `CASHFREE_WEBHOOK_SECRET` (optional but recommended)

## Install dependencies

```bash
pip install -r requirements.txt
```

## Migrate

```bash
python manage.py makemigrations payments
python manage.py migrate
```

## Checkout flow

1. Go to the cart page and click **Checkout**.
2. The checkout page calls `/payments/create-order/` to create a Cashfree order.
3. Cashfree web checkout opens and processes payment.
4. After payment, Cashfree redirects to `/payments/return/`.
5. (Optional) Configure webhook URL to `/payments/webhook/` in Cashfree dashboard.

## Notes

- Ensure your domain is whitelisted in Cashfree for production.
- A valid user phone number is required to create a Cashfree order.
