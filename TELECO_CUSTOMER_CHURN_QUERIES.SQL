-- ============================================
-- Telecom Customer Churn Analysis
-- Dataset: IBM Telco Customer Churn (Kaggle - blastchar)
-- ============================================

-- 1. DATA QUALITY CHECK
-- Check for missing/null TotalCharges and zero-tenure customers
-- (known data quirk: new customers with tenure = 0 have blank TotalCharges)
SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_totalcharges,
       SUM(CASE WHEN tenure = 0 THEN 1 ELSE 0 END) AS zero_tenure_customers
FROM customers;


-- 2. DATA CLEANING
-- Remove incomplete records (customers with no completed billing cycle)
CREATE TABLE customers_clean AS
SELECT *
FROM customers
WHERE TotalCharges IS NOT NULL;

-- Verify row count after cleaning
SELECT COUNT(*) FROM customers_clean;


-- 3. OVERALL CHURN RATE
SELECT 
    Churn,
    COUNT(*) AS num_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers_clean), 2) AS percentage
FROM customers_clean
GROUP BY Churn;


-- 4. CHURN BY CONTRACT TYPE
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- 5. CHURN BY TENURE GROUP
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;


-- 6. CHURN BY INTERNET SERVICE TYPE
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;


-- 7. CHURN BY PAYMENT METHOD
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customers_clean
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;


-- 8. REVENUE AT RISK
-- Total monthly and annualized recurring revenue tied to churned customers
SELECT 
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_at_risk,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 12, 2) AS annual_revenue_at_risk
FROM customers_clean;