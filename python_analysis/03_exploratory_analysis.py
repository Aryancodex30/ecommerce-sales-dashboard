from pathlib import Path
import matplotlib.pyplot as plt
import pandas as pd

ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = ROOT / 'python_analysis' / 'output'
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def run_eda():
    orders = pd.read_csv(OUTPUT_DIR / 'orders_clean.csv')
    products = pd.read_csv(OUTPUT_DIR / 'products_clean.csv')

    orders['order_date'] = pd.to_datetime(orders['order_date'])
    orders['month'] = orders['order_date'].dt.to_period('M').astype(str)

    monthly_sales = orders.groupby('month')['total_amount'].sum().reset_index()
    print(monthly_sales.head())

    plt.figure(figsize=(10, 5))
    plt.plot(monthly_sales['month'], monthly_sales['total_amount'], marker='o')
    plt.title('Monthly revenue trend')
    plt.xlabel('Month')
    plt.ylabel('Revenue')
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / 'monthly_revenue_trend.png', dpi=150)

    category_sales = products[['product_id', 'category', 'price']].groupby('category')['price'].mean().reset_index()
    print('\nAverage product price by category:')
    print(category_sales)

    plt.figure(figsize=(8, 6))
    category_sales.plot(kind='bar', x='category', y='price', legend=False)
    plt.title('Average product price by category')
    plt.tight_layout()
    plt.savefig(OUTPUT_DIR / 'category_price.png', dpi=150)

    print('\nEDA complete. Charts saved to python_analysis/output/')


if __name__ == '__main__':
    run_eda()
