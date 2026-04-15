CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE events(
    event_time DATETIME,
    event_type VARCHAR(50),
    product_id BIGINT,
    category_id BIGINT,
    category_code VARCHAR(100),
    brand VARCHAR(50),
    price FLOAT,
    user_id BIGINT,
    user_session VARCHAR(100)
);
SELECT * FROM events 
LIMIT 10;

##Daily Active Users (DAU)

SELECT DATE(event_timestamp) AS date,
       COUNT(DISTINCT user_id) AS DAU 
FROM events
GROUP BY DATE(event_timestamp)
ORDER BY date

## Monthly Active Users (MAU)

SELECT MONTH(event_timestamp) AS month,
       COUNT(DISTINCT user_id) AS MAU
FROM events 
GROUP BY MONTH(event_timestamp)
ORDER BY month

## Funnel Analysis
SELECT event_type,
     COUNT(DISTINCT user_id) AS Users
FROM events 
GROUP BY event_typeevents

##Conversion Rate 
SELECT 
     COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) * 100.0 /
     COUNT(DISTINCT CASE WHEN event_type = 'view' THEN user_id END)
     AS conversion_rate
FROM events
