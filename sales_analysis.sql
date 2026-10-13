SELECT *
FROM mini_sales;
SELECT
    SUM(sales_bdt) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS total_orders
FROM mini_sales;
SELECT
    product,
    SUM(quantity) AS total_quantity,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY product
ORDER BY total_sales DESC;
SELECT
    category,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY category
ORDER BY total_sales DESC;
SELECT
    region,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY region
ORDER BY total_sales DESC;
SELECT
    payment_method,
    COUNT(*) AS transactions,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY payment_method
ORDER BY total_sales DESC;
SELECT *
FROM mini_sales
ORDER BY sales_bdt DESC
LIMIT 1;
SELECT
    product,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY product
ORDER BY total_sales DESC
LIMIT 1;
SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM mini_sales
GROUP BY payment_method
ORDER BY total_transactions DESC;
SELECT
    order_date,
    SUM(sales_bdt) AS daily_sales
FROM mini_sales
GROUP BY order_date
ORDER BY order_date;
SELECT *
FROM mini_sales
WHERE region = 'Chattogram'
  AND sales_bdt > 300;
  SELECT *
FROM mini_sales
WHERE payment_method = 'Cash'
   OR payment_method = 'Card';
   SELECT *
FROM mini_sales
WHERE region = 'Chattogram'
  AND sales_bdt > 300;
  SELECT *
FROM mini_sales
WHERE product LIKE 'R%';
SELECT *
FROM mini_sales
WHERE sales_bdt BETWEEN 200 AND 400;
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(order_date) AS missing_order_date,
    COUNT(*) - COUNT(product) AS missing_product,
    COUNT(*) - COUNT(sales_bdt) AS missing_sales,
    COUNT(DISTINCT order_id) AS unique_order_ids
FROM mini_sales;
SELECT
    order_id,
    product,
    sales_bdt,
    CASE
        WHEN sales_bdt >= 500 THEN 'High'
        WHEN sales_bdt >= 250 THEN 'Medium'
        ELSE 'Low'
    END AS sales_level
FROM mini_sales
ORDER BY sales_bdt DESC;
SELECT
    product,
    SUM(sales_bdt) AS total_sales
FROM mini_sales
GROUP BY product
HAVING SUM(sales_bdt) > 500
ORDER BY total_sales DESC;
WITH regional_sales AS (
    SELECT
        region,
        SUM(sales_bdt) AS total_sales
    FROM mini_sales
    GROUP BY region
)
SELECT
    region,
    total_sales,
    ROUND(
        100.0 * total_sales /
        NULLIF(SUM(total_sales) OVER (), 0),
        2
    ) AS sales_percentage
FROM regional_sales
ORDER BY total_sales DESC;
WITH product_sales AS (
    SELECT
        product,
        SUM(sales_bdt) AS total_sales
    FROM mini_sales
    GROUP BY product
)
SELECT
    product,
    total_sales,
    DENSE_RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_sales
ORDER BY sales_rank;
SELECT
    payment_method,
    COUNT(*) AS transactions,
    SUM(sales_bdt) AS total_sales,
    ROUND(
        100.0 * SUM(sales_bdt) /
        NULLIF((SELECT SUM(sales_bdt)
                FROM mini_sales), 0),
        2
    ) AS revenue_percentage
FROM mini_sales
GROUP BY payment_method
ORDER BY total_sales DESC;
WITH daily_sales AS (
    SELECT
        order_date,
        SUM(sales_bdt) AS total_sales
    FROM mini_sales
    GROUP BY order_date
)
SELECT
    order_date,
    total_sales,
    total_sales - LAG(total_sales) OVER (
        ORDER BY order_date
    ) AS change_from_previous_date
FROM daily_sales
ORDER BY order_date;