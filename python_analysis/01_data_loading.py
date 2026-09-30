from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / 'data' / 'generated'
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def load_all():
    customers = pd.read_csv(DATA_DIR / 'customers.csv')
    products = pd.read_csv(DATA_DIR / 'products.csv')
    orders = pd.read_csv(DATA_DIR / 'orders.csv')
    order_items = pd.read_csv(DATA_DIR / 'order_items.csv')
    return customers, products, orders, order_items


def clean_data(customers, products, orders, order_items):
    customers = customers.copy()
    products = products.copy()
    orders = orders.copy()
    order_items = order_items.copy()

    customers['signup_date'] = pd.to_datetime(customers['signup_date'], errors='coerce')
    customers['last_purchase_date'] = pd.to_datetime(customers['last_purchase_date'], errors='coerce')
    customers['lifetime_value'] = pd.to_numeric(customers['lifetime_value'], errors='coerce').fillna(0)
    customers['total_orders'] = pd.to_numeric(customers['total_orders'], errors='coerce').fillna(0)

    products['created_date'] = pd.to_datetime(products['created_date'], errors='coerce')
    products['price'] = pd.to_numeric(products['price'], errors='coerce')
    products['cost'] = pd.to_numeric(products['cost'], errors='coerce')
    products['stock_quantity'] = pd.to_numeric(products['stock_quantity'], errors='coerce').fillna(0)

    orders['order_date'] = pd.to_datetime(orders['order_date'], errors='coerce')
    orders['ship_date'] = pd.to_datetime(orders['ship_date'], errors='coerce')
    orders['delivery_date'] = pd.to_datetime(orders['delivery_date'], errors='coerce')
    orders['total_amount'] = pd.to_numeric(orders['total_amount'], errors='coerce').fillna(0)
    orders['order_subtotal'] = pd.to_numeric(orders['order_subtotal'], errors='coerce').fillna(0)
    orders['discount_amount'] = pd.to_numeric(orders['discount_amount'], errors='coerce').fillna(0)
    orders['tax_amount'] = pd.to_numeric(orders['tax_amount'], errors='coerce').fillna(0)
    orders['shipping_cost'] = pd.to_numeric(orders['shipping_cost'], errors='coerce').fillna(0)

    order_items['quantity'] = pd.to_numeric(order_items['quantity'], errors='coerce').fillna(1)
    order_items['unit_price'] = pd.to_numeric(order_items['unit_price'], errors='coerce').fillna(0)
    order_items['discount_percent'] = pd.to_numeric(order_items['discount_percent'], errors='coerce').fillna(0)
    order_items['line_total'] = pd.to_numeric(order_items['line_total'], errors='coerce').fillna(0)

    return customers, products, orders, order_items


def main():
    customers, products, orders, order_items = load_all()
    customers, products, orders, order_items = clean_data(customers, products, orders, order_items)

    customers.to_csv(OUTPUT_DIR / 'customers_clean.csv', index=False)
    products.to_csv(OUTPUT_DIR / 'products_clean.csv', index=False)
    orders.to_csv(OUTPUT_DIR / 'orders_clean.csv', index=False)
    order_items.to_csv(OUTPUT_DIR / 'order_items_clean.csv', index=False)

    print('Cleaned files saved to:', OUTPUT_DIR)
    print('Missing values summary:')
    print({
        'customers': customers.isna().sum().sum(),
        'products': products.isna().sum().sum(),
        'orders': orders.isna().sum().sum(),
        'order_items': order_items.isna().sum().sum(),
    })


if __name__ == '__main__':
    main()
