CREATE TABLE customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(255),
    customer_state VARCHAR(10)
);

COPY customers(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE order_items (
    order_id VARCHAR(255),
    order_item_id INTEGER,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC
);

COPY order_items(order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE order_payments (
    order_id VARCHAR(255),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value NUMERIC
);

COPY order_payments(order_id, payment_sequential, payment_type, payment_installments, payment_value)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE order_reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

COPY order_reviews(review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE orders (
    order_id VARCHAR(255),
    customer_id VARCHAR(255),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

COPY orders(order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_lenght INTEGER,
    product_description_lenght INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

COPY products(product_id, product_category_name, product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE sellers (
    seller_id VARCHAR(255),
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(255),
    seller_state VARCHAR(10)
);

COPY sellers(seller_id, seller_zip_code_prefix, seller_city, seller_state)
FROM '/Users/elifcici/Desktop/Olist_Dataset/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(255),
    product_category_name_english VARCHAR(255)
);


COPY product_category_name_translation(product_category_name, product_category_name_english)
FROM '/Users/elifcici/Desktop/Olist_Dataset/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;