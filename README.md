# Case Study on Brazilian E-Commerce Dataset by Olist 

This repository contains a detailed case study on data analysis for the Brazilian e-commerce company, Olist. Using SQL queries, the analysis covers multiple aspects of Olist's operations, including order trends, customer behaviors, seller performance, and payment preferences. This project aims to derive insights that can guide strategic decisions, such as optimizing inventory, enhancing customer retention, and improving logistics.

## Dataset

The dataset used in this analysis is from Olist, an e-commerce platform in Brazil, and includes transaction data from 2016 to 2018. It covers detailed information about orders, customers, sellers, products, and payment methods, providing a rich foundation for in-depth analysis.

You can access and download the dataset from the following link:

[Olist Brazilian E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download)

## Case Study Overview

The analysis is divided into several cases, each focusing on a specific area of business performance:

### Case 1: Order Analysis
This section examines order patterns over time, segmenting orders by month, order status, and product category.

1. **Monthly Order Distribution**: Analyzes how orders are distributed across months, revealing trends in sales growth.
2. **Order Status by Month**: Investigates the distribution of order statuses monthly, identifying any seasonal patterns or periods with significant fluctuations.
3. **Product Category Segmentation**: Highlights top-performing product categories during special occasions, such as Christmas and Valentine's Day, showing how customer preferences shift during these periods.
4. **Order Trends by Day and Week**: Explores customer order behavior based on the day of the week and weeks within the month, providing insights into peak shopping times.

### Case 2: Customer Analysis
This section focuses on customer location and purchasing frequency, revealing insights into the regional distribution of orders and repeat shopping behavior.

- **Primary Customer Location**: Identifies the primary cities where customers place the most orders, with a focus on economic and population centers that drive e-commerce activity.
- **Regional Variations**: Explores regional differences, highlighting which areas show strong engagement with the platform and where there might be growth potential.

### Case 3: Seller Analysis
This section evaluates seller performance based on delivery speed, product diversity, and customer satisfaction.

1. **Fastest Deliveries**: Ranks sellers by their average delivery time and customer review scores, identifying those with efficient logistics and high customer satisfaction.
2. **Product Category Diversity**: Analyzes the diversity of product categories offered by sellers, examining whether sellers with broader product ranges have higher order volumes.

### Case 4: Payment Analysis
This section examines customer payment behavior, focusing on payment types, installment usage, and category-based payment trends.

1. **Installment Preferences by Region**: Identifies regions where customers use the highest number of installment options, providing insights into regional payment preferences.
2. **Successful Payments by Type**: Analyzes the number and value of successful payments by payment type, highlighting the dominance of credit cards and the use of "boleto" as a preferred alternative.
3. **Category Analysis for Single and Installment Payments**: Examines which product categories are most frequently purchased with single payments versus installment options, revealing pricing sensitivities and customer preferences.

## SQL Queries

The analysis relies on SQL queries to extract insights from the dataset. Key queries include:

- Monthly distribution of orders and order statuses.
- Product category segmentation for special events.
- Analysis of customer location and order frequency.
- Seller performance metrics, including delivery speed and review scores.
- Payment analysis by type and installment usage.

## Analysis Insights

Here are some of the main insights derived from the case study:

- **Order Growth**: A steady increase in orders from 2016 to 2018 suggests strong growth, likely driven by increased adoption of e-commerce in Brazil.
- **Customer Behavior**: Customers are more active on Mondays and during the first and fourth weeks of each month, likely influenced by salary payment schedules.
- **Seller Performance**: Fast delivery times and high customer ratings are correlated, highlighting the importance of efficient logistics for customer satisfaction.
- **Payment Preferences**: Credit cards are the dominant payment method, especially due to installment options, while "boleto" provides a cash-based alternative.
- **Product Categories**: Bedding, beauty, and sports categories see high demand across both single and installment payments, suggesting strong customer interest in these areas.

## Strategic Recommendations

Based on the findings, several recommendations have been proposed:

1. **Increase Weekend Sales**: Implement special discounts and promotions during weekends to boost customer engagement.
2. **Regional Campaigns**: Target high-density urban areas with focused advertising and promotional efforts.
3. **Flexible Payment Options**: Emphasize installment payment options for higher-cost products, especially in categories with high demand.
4. **Encourage Customer Loyalty**: Foster repeat purchases through loyalty programs, particularly in regions showing high engagement with the platform.
5. **Optimize Seller Operations**: Encourage sellers to maintain quick delivery times and high product quality to improve customer satisfaction.

## Getting Started

To reproduce the analysis, follow these steps:

1. Download the dataset from Kaggle ([Olist Brazilian E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download)).
2. Run the SQL scripts provided in this repository to generate insights for each case study section.
3. For visualizations, you can export query results and use tools like Excel for further analysis and graph creation.

## Tools and Libraries

- **SQL**: The primary language used for querying the dataset.
- **Excel**: For visualization and additional data analysis.
- **PostgreSQL**: Database used for storing and querying the Olist dataset.

## Contact

For any questions or further information, feel free to reach out via email or connect on [LinkedIn](https://linkedin.com/in/elifatasal).

