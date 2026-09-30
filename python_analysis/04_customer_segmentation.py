import pandas as pd
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

customers = pd.read_csv(OUTPUT_DIR / 'customers_clean.csv')
orders = pd.read_csv(OUTPUT_DIR / 'orders_clean.csv')
order_items = pd.read_csv(OUTPUT_DIR / 'order_items_clean.csv')
products = pd.read_csv(OUTPUT_DIR / 'products_clean.csv')

# RFM-style segmentation
orders['order_date'] = pd.to_datetime(orders['order_date'])
latest_date = orders['order_date'].max()
rfm = orders.groupby('customer_id').agg(
    recency=('order_date', lambda x: (latest_date - x.max()).days),
    frequency=('order_id', 'count'),
    monetary=('total_amount', 'sum')
).reset_index()

rfm['recency_score'] = pd.qcut(rfm['recency'].rank(method='first'), 5, labels=[5, 4, 3, 2, 1])
rfm['frequency_score'] = pd.qcut(rfm['frequency'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5])
rfm['monetary_score'] = pd.qcut(rfm['monetary'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5])

rfm['segment'] = 'Standard'
rfm.loc[(rfm['recency_score'] >= '4') & (rfm['frequency_score'] >= '4') & (rfm['monetary_score'] >= '4'), 'segment'] = 'High Value'
rfm.loc[(rfm['recency_score'] >= '3') & (rfm['frequency_score'] >= '3'), 'segment'] = 'Loyal'
rfm.loc[(rfm['recency_score'] <= '2'), 'segment'] = 'At Risk'

rfm.to_csv(OUTPUT_DIR / 'customer_segments.csv', index=False)
print(rfm['segment'].value_counts())
