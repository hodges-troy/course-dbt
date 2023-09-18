##
# Week 1 Project Questions

**1. How many users do we have?**

We have 130 users. Our data does not say if they are inactive or not, so we assume all our active.

Found using this query:
```
SELECT COUNT(DISTINCT USER_ID) AS DISTINCT_USERS
FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_USERS
```

**2. On average, how many orders do we receive per hour?**

On average, there are 7.52 orders every hour.

Found using this query:
```
WITH ORDERS_BY_HOUR AS (
    SELECT
        TO_CHAR(CREATED_AT, 'YYYY-MM-DD HH24') AS HOUR_OF_ORDER,
        COUNT(ORDER_ID) AS ORDER_COUNT
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_ORDERS
    GROUP BY HOUR_OF_ORDER
)

SELECT AVG(ORDER_COUNT) AS AVG_ORDER_COUNT_PER_HOUR
FROM ORDERS_BY_HOUR
```

**3. On average, how long does an order take from being placed to being delivered?**

On average, it takes an order 93.4 hours from being placed to being delivered.

Found using this query:
```
WITH TIME_ORDER_TO_DELIVER AS (
    SELECT
        timestampdiff(HOUR, CAST(CREATED_AT AS TIMESTAMP), CAST(DELIVERED_AT AS TIMESTAMP)) AS ORDER_TO_DELIVER_HOURS
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_ORDERS
    WHERE STATUS = 'delivered'
)

SELECT AVG(ORDER_TO_DELIVER_HOURS) AS AVG_ORDER_TO_DELIVER_HOURS
FROM TIME_ORDER_TO_DELIVER
```

**4. How many users have only made one purchase? Two purchases? Three+ purchases?**

*Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.*

25 users have made one purchase.

28 users have made two purchases.

71 users have made three or more purchases.

Found using this query:
```
WITH ORDERS_BY_USER AS (
    SELECT
        USER_ID,
        COUNT(ORDER_ID) AS ORDER_COUNT
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_ORDERS
    GROUP BY USER_ID
)

SELECT 
    CASE
        WHEN ORDER_COUNT = 1 THEN '1 order'
        WHEN ORDER_COUNT = 2 THEN '2 orders'
        ELSE '3 or more orders'
    END AS ORDER_COUNT_CATEGORY,
    COUNT(USER_ID) AS USER_COUNT
FROM ORDERS_BY_USER
GROUP BY ORDER_COUNT_CATEGORY
ORDER BY ORDER_COUNT_CATEGORY
```

**5. On average, how many unique sessions do we have per hour?**

On average, there are 16.3 unique sessions per hour.

Found using this query:
```
WITH SESSIONS_BY_HOUR AS (
    SELECT
        TO_CHAR(CREATED_AT, 'YYYY-MM-DD HH24') AS HOUR_OF_SESSION,
        COUNT(DISTINCT SESSION_ID) AS SESSION_COUNT
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_EVENTS
    GROUP BY HOUR_OF_SESSION
)

SELECT AVG(SESSION_COUNT) AS AVG_SESSION_COUNT_PER_HOUR
FROM SESSIONS_BY_HOUR
```