from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

orders = pd.read_csv(OUTPUT_DIR / 'orders_clean.csv')
orders['order_date'] = pd.to_datetime(orders['order_date'])

daily_sales = orders.groupby(orders['order_date'].dt.date).agg(
    revenue=('total_amount', 'sum'),
    orders=('order_id', 'count')
).reset_index()

daily_sales = daily_sales.rename(columns={'order_date': 'date'})
daily_sales['date'] = pd.to_datetime(daily_sales['date'])
daily_sales = daily_sales.sort_values('date')

daily_sales['period_index'] = range(len(daily_sales))

daily_sales['forecast_7day_ma'] = daily_sales['revenue'].rolling(window=7, min_periods=1).mean()

forecast = daily_sales[['date', 'revenue', 'forecast_7day_ma']].copy()
forecast.to_csv(OUTPUT_DIR / 'revenue_forecast.csv', index=False)
print(forecast.tail())
