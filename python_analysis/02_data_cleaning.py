from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def load_and_summary():
    customers = pd.read_csv(OUTPUT_DIR / 'customers_clean.csv')
    products = pd.read_csv(OUTPUT_DIR / 'products_clean.csv')
    orders = pd.read_csv(OUTPUT_DIR / 'orders_clean.csv')
    order_items = pd.read_csv(OUTPUT_DIR / 'order_items_clean.csv')

    print('Customer rows:', len(customers))
    print('Product rows:', len(products))
    print('Order rows:', len(orders))
    print('Order item rows:', len(order_items))

    print('\nRevenue summary:')
    print(orders['total_amount'].sum())

    return customers, products, orders, order_items


if __name__ == '__main__':
    load_and_summary()
