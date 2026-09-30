from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

customers = pd.read_csv(OUTPUT_DIR / 'customers_clean.csv')
orders = pd.read_csv(OUTPUT_DIR / 'orders_clean.csv')
products = pd.read_csv(OUTPUT_DIR / 'products_clean.csv')
order_items = pd.read_csv(OUTPUT_DIR / 'order_items_clean.csv')

orders['order_date'] = pd.to_datetime(orders['order_date'])
orders['month'] = orders['order_date'].dt.to_period('M').astype(str)

daily_sales = orders.groupby('month').agg(
    revenue=('total_amount', 'sum'),
    orders=('order_id', 'count'),
    avg_order_value=('total_amount', 'mean')
).reset_index()

daily_sales.columns = ['month', 'revenue', 'orders', 'avg_order_value']

product_perf = order_items.groupby('product_id').agg(
    units_sold=('quantity', 'sum'),
    revenue=('line_total', 'sum')
).reset_index()
product_perf = product_perf.merge(products[['product_id', 'product_name', 'category']], on='product_id', how='left')

customer_segments = pd.read_csv(OUTPUT_DIR / 'customer_segments.csv')

# Save dashboard-ready files
customer_segments.to_csv(OUTPUT_DIR / 'dashboard_customer_segments.csv', index=False)
daily_sales.to_csv(OUTPUT_DIR / 'dashboard_daily_sales.csv', index=False)
product_perf.to_csv(OUTPUT_DIR / 'dashboard_product_performance.csv', index=False)

print('Dashboard files exported to:', OUTPUT_DIR)
