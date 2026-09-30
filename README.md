# E-Commerce Sales Dashboard

An end-to-end data analytics mini-project for a portfolio, combining SQL, Python, and dashboard design around an online retail business.

## Why this project matters
This project demonstrates practical data analysis skills that employers look for:
- working with structured data and relational schemas
- cleaning and validating business data
- deriving KPI metrics from transactional data
- segmenting customers and analyzing behavior
- creating executive dashboard visuals
- turning analysis into business recommendations

## Project structure

```text
ecommerce-sales-dashboard/
├── README.md
├── .gitignore
├── database/
│   ├── schema.sql
│   ├── sample_data.sql
│   └── data_dictionary.md
├── sql_queries/
│   ├── 01_revenue_analysis.sql
│   ├── 02_product_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_order_analysis.sql
│   └── 05_geographic_analysis.sql
├── python_analysis/
│   ├── requirements.txt
│   ├── generate_realistic_data.py
│   ├── 01_data_loading.py
│   ├── 02_data_cleaning.py
│   ├── 03_exploratory_analysis.py
│   ├── 04_customer_segmentation.py
│   ├── 05_forecasting.py
│   └── 06_export_dashboard_data.py
├── dashboards/
│   ├── dashboard_wireframe.md
│   └── powerbi_dashboard_spec.md
├── docs/
│   ├── portfolio_summary.md
│   └── project_notes.md
└── data/
    └── generated/
```

## Business questions answered
- Which products and categories produce the most revenue?
- Which geographies contribute the highest sales?
- Which customer segments are the highest value?
- What are the biggest causes of cancelation and returns?
- How is revenue trending over months and seasons?
- What actions should be recommended to improve conversion and retention?

## Core KPIs
- Total Revenue
- Total Orders
- Average Order Value (AOV)
- Revenue Growth Rate
- Profit Margin
- Customer Retention Rate
- Return Rate
- New vs Returning Customers

## Tools used
- SQL for querying and validation
- Python with pandas and scikit-learn for analysis
- Matplotlib and seaborn for charts
- Power BI / Tableau for dashboard visual storytelling

## Setup

### Database setup
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p < database/sample_data.sql
```

### Python environment
```bash
cd python_analysis
pip install -r requirements.txt
```

### Generate realistic test data
```bash
python python_analysis/generate_realistic_data.py
```

### Run analysis scripts
```bash
python python_analysis/01_data_loading.py
python python_analysis/02_data_cleaning.py
python python_analysis/03_exploratory_analysis.py
python python_analysis/04_customer_segmentation.py
python python_analysis/05_forecasting.py
python python_analysis/06_export_dashboard_data.py
```

## SQL analytics coverage
The SQL folder contains analysis for:
- revenue trends
- product contribution
- customer segmentation
- order behavior and fulfillment
- geographic performance

## Dashboard roadmap
The dashboard wireframe includes:
- Executive overview page
- Revenue analysis page
- Product performance page
- Customer insights page
- Fulfillment and returns page

## Portfolio-ready story
This project can be positioned as:
- "E-commerce Sales Analytics Dashboard"
- "Retail Performance and Customer Insights"
- "Sales KPI Dashboard with SQL and Python"

## Recommended project narrative for GitHub
Use a simple narrative in your portfolio:
- Built a sales analytics dashboard using transactional retail data
- Cleansed and modeled data in SQL and Python
- Identified top revenue drivers and customer segments
- Created KPI dashboards to support business decisions
- Produced actionable recommendations for product and retention strategies

## Next steps
The project can be extended with:
- customer churn modeling
- product recommendation logic
- forecasting and time-series prediction
- A/B test or campaign performance analysis
