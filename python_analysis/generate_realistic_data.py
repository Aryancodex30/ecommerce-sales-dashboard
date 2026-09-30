from pathlib import Path
import csv
import random
from datetime import datetime, timedelta

random.seed(42)

ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / 'data' / 'generated'
DATA_DIR.mkdir(parents=True, exist_ok=True)

countries = {
    'USA': ['California', 'Texas', 'New York'],
    'UK': ['England', 'Scotland', 'Wales'],
    'Canada': ['Ontario', 'Quebec', 'Alberta'],
    'Australia': ['NSW', 'Victoria', 'Queensland'],
}

segments = ['Premium', 'Standard', 'Budget']
product_categories = {
    'Electronics': ['Laptop', 'Headphones', 'Monitor', 'Keyboard'],
    'Furniture': ['Desk', 'Chair', 'Shelf', 'Lamp'],
    'Apparel': ['Jacket', 'T-shirt', 'Hoodie', 'Sneakers'],
    'Home': ['Blender', 'Lamp', 'Throw Pillow', 'Desk Organizer'],
}

first_names = ['Emma', 'Liam', 'Olivia', 'Noah', 'Ava', 'Lucas', 'Sophia', 'Mason', 'Mia', 'Ethan']
last_names = ['Smith', 'Johnson', 'Brown', 'Lee', 'Davis', 'Miller', 'Wilson', 'Taylor', 'Moore', 'Anderson']


def write_csv(path: Path, fieldnames, rows):
    with path.open('w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def generate_customers(n=300):
    rows = []
    for i in range(1, n + 1):
        country = random.choice(list(countries.keys()))
        state = random.choice(countries[country])
        city = f'{country.lower()}_city_{random.randint(1, 10)}'
        first = random.choice(first_names)
        last = random.choice(last_names)
        signup = datetime(2023, 1, 1) + timedelta(days=random.randint(0, 700))
        rows.append({
            'customer_id': i,
            'customer_name': f'{first} {last}',
            'email': f'customer{i}@example.com',
            'phone': f'+1{random.randint(100000000, 999999999)}',
            'country': country,
            'state': state,
            'city': city,
            'postal_code': f'{random.randint(10000, 99999)}',
            'address': f'{random.randint(1, 999)} Main Street',
            'customer_segment': random.choice(segments),
            'signup_date': signup.strftime('%Y-%m-%d'),
            'last_purchase_date': (signup + timedelta(days=random.randint(10, 300))).strftime('%Y-%m-%d'),
            'lifetime_value': round(random.uniform(50, 4000), 2),
            'total_orders': random.randint(1, 15),
            'is_active': random.choice([True, False]),
        })
    return rows


def generate_products():
    rows = []
    product_id = 1
    for category, items in product_categories.items():
        for item in items:
            rows.append({
                'product_id': product_id,
                'product_name': item,
                'category': category,
                'subcategory': category,
                'description': f'{item} for modern homes and offices',
                'price': round(random.uniform(25, 450), 2),
                'cost': round(random.uniform(10, 220), 2),
                'stock_quantity': random.randint(20, 400),
                'reorder_level': random.randint(15, 80),
                'supplier_id': random.randint(1, 10),
                'sku': f'{category[:3].upper()}-{product_id:04d}',
                'rating': round(random.uniform(3.5, 5.0), 2),
                'review_count': random.randint(30, 700),
                'created_date': (datetime(2023, 1, 1) + timedelta(days=random.randint(0, 500))).strftime('%Y-%m-%d'),
            })
            product_id += 1
    return rows


def generate_orders(customers, products, n=800):
    rows = []
    for order_id in range(1, n + 1):
        customer_id = random.randint(1, len(customers))
        order_date = datetime(2024, 1, 1) + timedelta(days=random.randint(0, 500))
        ship_date = order_date + timedelta(days=random.randint(1, 5))
        delivery_date = ship_date + timedelta(days=random.randint(2, 10))
        total_amount = round(random.uniform(25, 1200), 2)
        rows.append({
            'order_id': order_id,
            'customer_id': customer_id,
            'order_date': order_date.strftime('%Y-%m-%d %H:%M:%S'),
            'ship_date': ship_date.strftime('%Y-%m-%d'),
            'delivery_date': delivery_date.strftime('%Y-%m-%d'),
            'total_amount': total_amount,
            'order_subtotal': round(total_amount * 0.92, 2),
            'discount_amount': round(random.uniform(0, 90), 2),
            'tax_amount': round(total_amount * 0.08, 2),
            'shipping_cost': round(random.uniform(3, 30), 2),
            'order_status': random.choice(['Completed', 'Pending', 'Cancelled', 'Returned']),
            'payment_method': random.choice(['Credit Card', 'PayPal', 'Debit Card', 'Bank Transfer']),
            'shipping_method': random.choice(['Standard', 'Express', 'Next Day']),
            'shipping_address': f'{random.randint(1, 999)} Sample Street',
        })
    return rows


def generate_order_items(orders, products):
    rows = []
    item_id = 1
    for order in orders:
        item_count = random.randint(1, 4)
        selected_products = random.sample(products, item_count)
        for product in selected_products:
            qty = random.randint(1, 3)
            unit_price = product['price']
            discount_pct = random.uniform(0, 0.2)
            line_total = round(qty * unit_price * (1 - discount_pct), 2)
            rows.append({
                'order_item_id': item_id,
                'order_id': order['order_id'],
                'product_id': product['product_id'],
                'quantity': qty,
                'unit_price': unit_price,
                'discount_percent': round(discount_pct * 100, 2),
                'line_total': line_total,
            })
            item_id += 1
    return rows


def main():
    customers = generate_customers(300)
    products = generate_products()
    orders = generate_orders(customers, products, n=800)
    order_items = generate_order_items(orders, products)

    write_csv(DATA_DIR / 'customers.csv', [
        'customer_id', 'customer_name', 'email', 'phone', 'country', 'state', 'city', 'postal_code',
        'address', 'customer_segment', 'signup_date', 'last_purchase_date', 'lifetime_value', 'total_orders', 'is_active'
    ], customers)

    write_csv(DATA_DIR / 'products.csv', [
        'product_id', 'product_name', 'category', 'subcategory', 'description', 'price', 'cost',
        'stock_quantity', 'reorder_level', 'supplier_id', 'sku', 'rating', 'review_count', 'created_date'
    ], products)

    write_csv(DATA_DIR / 'orders.csv', [
        'order_id', 'customer_id', 'order_date', 'ship_date', 'delivery_date', 'total_amount',
        'order_subtotal', 'discount_amount', 'tax_amount', 'shipping_cost', 'order_status',
        'payment_method', 'shipping_method', 'shipping_address'
    ], orders)

    write_csv(DATA_DIR / 'order_items.csv', [
        'order_item_id', 'order_id', 'product_id', 'quantity', 'unit_price', 'discount_percent', 'line_total'
    ], order_items)

    print(f'Generated data files in {DATA_DIR}')
    print(f'Customers: {len(customers)}')
    print(f'Products: {len(products)}')
    print(f'Orders: {len(orders)}')
    print(f'Order items: {len(order_items)}')


if __name__ == '__main__':
    main()
