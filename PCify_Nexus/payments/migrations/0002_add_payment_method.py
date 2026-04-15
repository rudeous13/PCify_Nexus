from django.db import migrations, models


def populate_payment_method(apps, schema_editor):
    CashfreeOrder = apps.get_model('payments', 'CashfreeOrder')
    Payment = apps.get_model('orders', 'Payment')
    for c in CashfreeOrder.objects.all():
        try:
            # match by gateway/order id stored in cf_order_id
            p = Payment.objects.filter(gateway_order_id=c.cf_order_id).first()
            if p and p.payment_method:
                c.payment_method = p.payment_method
                c.save(update_fields=['payment_method'])
        except Exception:
            # skip any rows that cause errors
            continue


def reverse_populate(apps, schema_editor):
    CashfreeOrder = apps.get_model('payments', 'CashfreeOrder')
    CashfreeOrder.objects.update(payment_method=None)


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0001_initial'),
        ('orders', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='cashfreeorder',
            name='payment_method',
            field=models.CharField(blank=True, choices=[(
                'card', 'Card'), ('upi', 'UPI'), ('cod', 'Cash on Delivery')], max_length=10, null=True),
        ),
        migrations.RunPython(populate_payment_method, reverse_populate),
    ]
