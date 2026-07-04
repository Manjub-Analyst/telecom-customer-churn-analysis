# Telecom Customer Churn Analysis

## Overview
This project analyzes customer churn for a telecom company using the IBM Telco Customer Churn 
dataset. The goal is to identify which customer segments churn the most, understand the key 
drivers behind churn, and quantify the revenue impact — turning raw customer data into a 
business case for targeted retention action.

## Tools Used
- SQLite (data cleaning, churn rate calculations, segment analysis)
- Power BI (dashboard and visualization)

## Process
1. **Data Cleaning** — Removed 11 incomplete records with missing billing data (new customers 
   with no completed billing cycle)
2. **Overall Churn Rate** — Calculated the baseline churn rate across all customers
3. **Segment Analysis** — Measured churn rate by contract type, tenure, internet service type, 
   and payment method to identify the strongest churn drivers
4. **Revenue Impact** — Quantified monthly and annual recurring revenue at risk from churned customers
5. **Dashboard** — Built an interactive Power BI dashboard visualizing churn rate, key drivers, 
   and revenue at risk

## Key Insights
- **Overall churn rate: 26.58%** (1,869 of 7,032 customers)
- **Contract type is the strongest driver** — Month-to-month customers churn at 42.71%, 
  vs. 11.28% for one-year and just 2.85% for two-year contracts
- **New customers are highest risk** — customers in their first 12 months churn at 47.68%, 
  dropping to 9.51% for customers with 49+ months tenure
- **Fiber optic customers churn more** — 41.89% vs. 19% for DSL and 7.43% for no internet service
- **Payment method matters** — Electronic check users churn at 45.29%, nearly 3x higher than 
  automatic payment methods (~15-17%)
- **Revenue at risk: ₹1,39,130.85/month (₹16,69,570.20/year)** from churned customers

## Business Recommendation
Prioritize converting month-to-month customers to longer contracts through incentives, and 
focus retention efforts on customers in their first year — this is where churn risk and 
revenue loss are both highest. Consider reviewing the Fiber optic service experience and 
pricing, and encourage automatic payment adoption to reduce friction-driven churn.

## Files
- `queries.sql` — SQL scripts for data cleaning and churn analysis
- `Telecom_Churn_Dashboard.pbix` — Power BI dashboard file
- `dashboard_screenshot.png` — Dashboard preview image

## Dataset
[Telco Customer Churn — Kaggle (IBM Sample Dataset)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)