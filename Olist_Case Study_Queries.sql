'CASE STUDY'

'Case 1 : Order Analysis'

'Question 1 : Analyze the monthly distribution of orders. The order_approved_at date should be used for the date data'

SELECT
    (date_trunc('month',order_approved_at))::date AS month,
    COUNT(*) AS order_count
FROM
    orders
	 WHERE order_approved_at IS NOT NULL
GROUP BY
    month
ORDER BY
    month;
	
'Question 2: Analyze the number of orders segmentation by order status monthly'	

'Query of Delivered Orders'

SELECT
    (date_trunc('month',order_approved_at))::date AS month,
    order_status,
    COUNT(*) AS order_count
FROM
    orders
WHERE
    order_approved_at IS NOT NULL and 
order_status = 'delivered'
GROUP BY
    month,
    order_status
ORDER BY
    month, order_status;

'Query of Orders Excluding Delivered'

SELECT
    (date_trunc('month',order_approved_at))::date AS month,
    order_status,
    COUNT(*) AS order_count
FROM
    orders
WHERE
    order_approved_at IS NOT NULL and 
	order_status <> 'delivered'
GROUP BY
    month,
    order_status
ORDER BY
    month, order_status;
	
'Question 3: Analyze order numbers by product category segmentation
highlighting categories performing notably during special events/occasions 
(For example, New Year's Eve, Valentine's Day, etc.)'	

SELECT
    DISTINCT p.product_category_name AS product_category,
    COUNT(DISTINCT o.order_id) AS order_count,
    CASE 
        WHEN EXTRACT(MONTH FROM o.order_approved_at) = 12 THEN 'Christmas'
        WHEN EXTRACT(MONTH FROM o.order_approved_at) = 2 THEN 'ValentineDay'
    END AS special_days
FROM
    products p
INNER JOIN
    order_items oi ON p.product_id = oi.product_id
INNER JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    o.order_approved_at IS NOT NULL
    AND p.product_category_name IS NOT NULL
    AND EXTRACT(MONTH FROM o.order_approved_at) IN (12, 2)
GROUP BY
    p.product_category_name, special_days
ORDER BY
    order_count DESC, special_days
LIMIT 10;

'Question 4 : Analyze order numbers based on days of the week (Monday, Thursday,etc.) and 
days of the month (1st, 2nd, etc.).'

'Query of Weekdays Order Counts'

SELECT
    CASE 
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 0 THEN 'Sunday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM order_purchase_timestamp) = 6 THEN 'Saturday'
    END AS days_of_week,
    COUNT(*) AS order_count
FROM
    orders
WHERE
    order_purchase_timestamp IS NOT NULL
GROUP BY
    days_of_week
ORDER BY
    order_count;

'Query of Weekly Order Counts'

SELECT
    CASE
        WHEN EXTRACT(DAY FROM order_purchase_timestamp) BETWEEN 1 AND 8 THEN 'First Week'
        WHEN EXTRACT(DAY FROM order_purchase_timestamp) BETWEEN 9 AND 15 THEN 'Second Week'
        WHEN EXTRACT(DAY FROM order_purchase_timestamp) BETWEEN 16 AND 22 THEN 'Third Week'
        WHEN EXTRACT(DAY FROM order_purchase_timestamp) BETWEEN 23 AND 31 THEN 'Fourth Week'
    END AS weeks_of_month,
    COUNT(*) AS order_count
FROM
    orders
WHERE
    order_purchase_timestamp IS NOT NULL
GROUP BY
    weeks_of_month
ORDER BY
    order_count;

'Case 2 : Customer Analysis'
'Analyze customer order frequency by city, defining a customers primary location as the city 
where they place the highest number of orders'

WITH customer_city_order_counts AS (
    SELECT 
        c.customer_unique_id,
        c.customer_city,
        COUNT(DISTINCT o.order_id) AS customer_order_count,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id 
            ORDER BY COUNT(DISTINCT o.order_id) DESC, MAX(o.order_purchase_timestamp) DESC
        ) AS order_rank
    FROM 
        customers c
    INNER JOIN 
        orders o ON o.customer_id = c.customer_id
    GROUP BY 
        c.customer_unique_id, c.customer_city
),
primary_city_by_customer AS (
    SELECT
        customer_unique_id,
        customer_city AS primary_city,
        customer_order_count
    FROM
        customer_city_order_counts
    WHERE
        order_rank = 1
)

SELECT 
    primary_city,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    SUM(customer_order_count) AS total_orders
FROM 
    primary_city_by_customer
GROUP BY 
    primary_city
ORDER BY 
    total_orders DESC
	LIMIT 10;

'Case 3: Seller Analysis'
'Question 1: Who are the sellers that deliver orders to customers the fastest? 
Bring the top 5. Examine and interpret these sellers order numbers along with their product reviews and ratings'

WITH seller_delivery_times AS (
    SELECT
        s.seller_id,
        AVG(o.order_delivered_customer_date - o.order_purchase_timestamp) AS avg_delivery_time,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM
        sellers s
    INNER JOIN 
        order_items oi ON oi.seller_id = s.seller_id
    INNER JOIN 
        orders o ON o.order_id = oi.order_id	
    WHERE
        o.order_status = 'delivered'
    GROUP BY
        s.seller_id 
)

SELECT
    sdt.seller_id,
    sdt.avg_delivery_time,
    sdt.total_orders,
    ROUND(AVG(r.review_score)::NUMERIC, 2) AS avg_review_score, 
    COUNT(r.review_comment_message) AS review_comment_count
FROM
    seller_delivery_times sdt
INNER JOIN 
    order_items oi ON oi.seller_id = sdt.seller_id
INNER JOIN 
    order_reviews r ON r.order_id = oi.order_id
WHERE 
    sdt.total_orders > 40
GROUP BY 
    sdt.seller_id, sdt.avg_delivery_time, sdt.total_orders
ORDER BY 
    sdt.avg_delivery_time ASC
LIMIT 5;

'Question 2:  Which sellers sell products from more categories?Do sellers with more categories also have more orders?'

SELECT
	oi.seller_id,
COUNT(DISTINCT p.product_category_name) AS category_count,
COUNT(DISTINCT o.order_id) AS order_count
FROM
    order_items oi
INNER JOIN 
	orders o ON o.order_id = oi.order_id
INNER JOIN 
    products p ON p.product_id = oi.product_id
WHERE
    o.order_status = 'delivered'
GROUP BY
    oi.seller_id
HAVING COUNT(DISTINCT p.product_category_name) >= 10
ORDER BY
    category_count DESC, order_count DESC;

'4: Payment Analysis'

'Question 1: Which regions do the users who make payments with the highest number of installments live in? 
Interpret this output.'

WITH Customer_Installments AS (
    SELECT
        c.customer_unique_id,
        c.customer_city,
        c.customer_state,
        o.order_id,
        p.payment_installments
    FROM
        customers c
    INNER JOIN
        orders o ON c.customer_id = o.customer_id
    INNER JOIN
        order_payments p ON o.order_id = p.order_id
    WHERE
        p.payment_type = 'credit_card'
    ORDER BY
        p.payment_installments DESC
)

SELECT
    customer_state,
    customer_city,
    MAX(payment_installments) AS max_installments,
    COUNT(DISTINCT order_id) AS order_count
FROM
    Customer_Installments
GROUP BY
    customer_state, customer_city
ORDER BY
    max_installments DESC, order_count DESC
LIMIT 10;

'Question 2: Calculate the number of successful orders and the total successful payment amount by payment type. 
Sort from the most used payment type to the least.'

WITH SuccessfulPayments AS (
    SELECT
        o.order_id,
        p.payment_type,
        p.payment_value
    FROM
        orders o
    INNER JOIN
        order_payments p ON o.order_id = p.order_id
    WHERE 
	o.order_status IN ('delivered','invoiced')
	GROUP BY 
	o.order_id,
    p.payment_type,
p.payment_value
	ORDER BY 
	p.payment_type
)

SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS successful_order_count,
    SUM(payment_value) AS total_successful_payment_amount
FROM
    SuccessfulPayments
GROUP BY
    payment_type
ORDER BY
    successful_order_count DESC;

'Question 3: Perform a category-based analysis of orders paid in full and in installments.
Which categories have the highest usage of installment payments?
''Single Payment Query'

WITH single_pay_orders AS (
    SELECT
        oi.order_id,
        p.product_category_name,
        pay.payment_type
    FROM
        order_items oi
    INNER JOIN
        products p ON oi.product_id = p.product_id
    INNER JOIN
        orders o ON oi.order_id = o.order_id
    INNER JOIN
        order_payments pay ON o.order_id = pay.order_id
    WHERE
        pay.payment_installments = 1
)

SELECT
    product_category_name,
    COUNT(DISTINCT order_id) AS single_pay_order_count,
    payment_type
FROM
    single_pay_orders
GROUP BY
    product_category_name, payment_type
ORDER BY
    single_pay_order_count DESC
LIMIT 5;

'Installment Payment Query'

WITH Installment_orders AS (
    SELECT
        oi.order_id,
        p.product_category_name,
        pay.payment_installments
    FROM
        order_items oi
    INNER JOIN
        products p ON oi.product_id = p.product_id
    INNER JOIN
        orders o ON oi.order_id = o.order_id
    INNER JOIN
        order_payments pay ON o.order_id = pay.order_id
    WHERE
        pay.payment_installments > 1
)

SELECT
    product_category_name,
    COUNT(DISTINCT order_id) AS installment_order_count,
    payment_installments
FROM
    Installment_orders
GROUP BY
    product_category_name, payment_installments
ORDER BY
    installment_order_count DESC
LIMIT 5;
