# E-Commerce Sales Dashboard

An end-to-end data analytics project covering e-commerce sales, customer behavior, and performance trends using SQL, Python, and dashboarding tools.

## Project overview
This project is designed to help you build a portfolio-ready analytical dashboard based on an online retail dataset. It includes:
- a relational schema for e-commerce data
- SQL for business analysis
- Python data preparation and analysis
- a dashboard wireframe for Power BI or Tableau
- clear business metrics and recommendations

## Folder structure

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
│   └── 03_customer_analysis.sql
├── dashboards/
│   └── dashboard_wireframe.md
├── python_analysis/
│   └── requirements.txt
└── docs/
    └── project_notes.md
```

## Business questions this project answers
- Which products generate the most revenue?
- Which customer segments are most valuable?
- How is revenue trending over time?
- Which regions perform best?
- Which orders are at risk or problematic?
- What are the main return and fulfillment issues?

## Dataset schema
The schema includes these core tables:
- suppliers
- products
- customers
- orders
- order_items
- returns
- payment_transactions
- inventory_log
- customer_reviews
- marketing_campaigns

See `database/schema.sql` for the exact implementation.

## Key KPIs
- Total Revenue
- Total Orders
- Average Order Value (AOV)
- Revenue Growth Rate
- Return Rate
- Gross Profit Margin
- Top Products by Revenue
- New vs Returning Customers
- Geographic Sales by Country/State

## SQL analysis highlights
This project includes SQL analysis for:
- revenue and monthly growth
- product contribution analysis
- customer segmentation (RFM style)
- geographic sales performance
- return analysis and refund review

## Dashboard layout
The project includes a dashboard wireframe in `dashboards/dashboard_wireframe.md` with pages such as:
- Executive Overview
- Revenue Analysis
- Product Performance
- Customer Analytics
- Order & Fulfillment

## Recommended tools
- SQL: PostgreSQL / MySQL / SQL Server
- Python: pandas, numpy, matplotlib, seaborn, scikit-learn
- Visualization: Power BI or Tableau

## Getting started
1. Run the schema in your database:
   `mysql -u root -p < database/schema.sql`
2. Load sample data:
   `mysql -u root -p < database/sample_data.sql`
3. Run SQL queries in `sql_queries/`
4. Open the dashboard wireframe and build the report in Power BI or Tableau

## Project outcomes
By the end of this project, you will have:
- a clean data model for e-commerce analytics
- SQL queries that reveal business performance
- an understandable business dashboard
- a portfolio-ready project that shows analytical thinking

## Notes
This project is intentionally designed for portfolio use and can be extended with forecasting, customer churn modeling, and ad hoc marketing analysis.
