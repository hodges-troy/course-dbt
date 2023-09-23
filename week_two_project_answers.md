## Week Two Project Questions

### Part 1.Models

**1. What is our user repeat rate?

Repeat Rate = Users who purchased 2 or more times / users who purchased**

The Repeat rate of our users is 79.8%.

Found using this query:
```
WITH user_purchase_counts AS (
    SELECT
        USER_ID,
        CASE
            WHEN COUNT(ORDER_ID) = 1 THEN '1 order'
            ELSE '2 or more orders'
        END AS ORDER_COUNT_CATEGORY
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_ORDERS
    GROUP BY USER_ID
)

SELECT
    SUM(CASE WHEN ORDER_COUNT_CATEGORY = '2 or more orders' THEN 1 ELSE 0 END) * 100.0 / COUNT(USER_ID) AS RETURN_RATE
FROM user_purchase_counts;
```

**2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

Good indicators of a user who will likely purchase again could be:
- high number of previous purchases
- high number and high total length of browsing sessions since last purchase
- positive reviews left on review sites
- low number of previous returns

Good indicators of a user who will likely not purchase again could be:
- low number and low total length of browsing sessions since last purchase
- negative reviews left on review sites
- high number of previous returns

If I had more data, potential features I would look into:
- boolen, if person left a review
- sentiment of review
- number of browising sessions since last purchase
- total length of browsing sessions since last purchase
- number of returns

**3. Explain the product mart models you added. Why did you organize the models in the way you did?**

**4. Explain the core mart models you added. Why did you organize the models in the way you did?**

**5. Explain the marketing mart models you added. Why did you organize the models in the way you did?**

## Part 2.Tests



