USE seafoodkart

--Q1. How many users are there?  (3 marks each for excel & sql)
SELECT COUNT(DISTINCT U.user_id) FROM users AS U

--Q2. How many cookies does each user have on average?  (4 marks each for excel & sql)

SELECT T.TOTAL_COOKIES/cast(T.TOTAL_USER_ID as float) FROM (
SELECT  COUNT(DISTINCT U.user_id) AS TOTAL_USER_ID,COUNT(*) AS TOTAL_COOKIES FROM users AS U
)AS T

--Q3. What is the unique number of visits by all users per month?  (4 marks each for excel & sql)
SELECT MONTH(F.date) AS MONTH_,COUNT(DISTINCT F.visit_id) AS VISIT_PER_MONTH FROM Final_Raw_Data AS F
GROUP BY MONTH(F.date)
ORDER BY MONTH_

--Q4. What is the number of events for each event type?  (4 marks each for excel & sql)
SELECT F.event_type,COUNT(*) AS EVENT_CNT FROM Final_Raw_Data AS F 
GROUP BY F.event_type

--Q5. What is the percentage of visits which have a purchase event?  (4 marks each for excel & sql)
SELECT ROUND((T.PUR_VISIT_CNT)/(T.TOTAL_EVENT)*100,2) AS PURCHASE_EVENT_PERCENTAGE FROM (
SELECT CAST(COUNT(F.visit_id) AS float) AS PUR_VISIT_CNT ,(SELECT COUNT(DISTINCT F.visit_id) AS PER FROM Final_Raw_Data AS F) AS TOTAL_EVENT 
FROM Final_Raw_Data AS F
WHERE F.event_type=3) AS T

--Q6. What is the percentage of visits which view the checkout page but do not have a purchase event?  (4 marks each for excel & sql)
SELECT ROUND(CAST(COUNT(*) AS FLOAT)/(SELECT COUNT(DISTINCT F.visit_id) FROM Final_Raw_Data AS F)*100,2) AS CHECKOUT_NOT_PURCHASE FROM (
SELECT F.visit_id FROM Final_Raw_Data AS F WHERE F.page_id=12
EXCEPT
SELECT F.visit_id FROM Final_Raw_Data AS F WHERE F.event_type=3
)AS T
--Q7. What are the top 3 pages by number of views?  (4 marks each for excel & sql)
SELECT TOP 3 F.page_name,COUNT(*) AS VIEWS_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=1
GROUP BY F.page_name
ORDER BY VIEWS_CNT DESC


--Q8. What is the number of views and cart adds for each product category?  (4 marks each for excel & sql)
SELECT T1.*,T2.ADD_TO_CART_CNT FROM(
SELECT F.product_category,COUNT(*) AS VIEW_COUNT FROM Final_Raw_Data AS F
WHERE F.event_type=1 
GROUP BY F.product_category
HAVING  F.product_category <> 'NULL') AS T1
INNER JOIN (
SELECT F.product_category,COUNT(*) AS ADD_TO_CART_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.product_category) AS T2 ON T1.product_category=T2.product_category


--Q9. What are the top 3 products by purchases?  (4 marks each for excel & sql)
SELECT TOP 3 F.page_name,count(*)  AS TOTAL_PURCHASE FROM Final_Raw_Data AS F
WHERE F.visit_id IN (
SELECT DISTINCT F.visit_id FROM Final_Raw_Data as F WHERE F.event_type=3
) AND F.product_id IS NOT NULL AND F.event_type=2
GROUP BY F.page_name
ORDER BY TOTAL_PURCHASE DESC


--Q10.  Using prodct_level_summary and product_category_level_summary tables, 
--Find which product had the most views, cart adds and purchases? (5 marks each for excel & sql)
SELECT P.product_id,p.PRODUCT_NAME FROM product_level_summary AS P
WHERE P.PRODUCT_VIEW_CNT=(SELECT MAX(PRODUCT_VIEW_CNT) FROM product_level_summary)

SELECT P.product_id,p.PRODUCT_NAME FROM product_level_summary AS P
WHERE P.PRODUCT_ADDED_CNT=(SELECT MAX(P.PRODUCT_ADDED_CNT) FROM product_level_summary AS P)

SELECT P.product_id,p.PRODUCT_NAME FROM product_level_summary AS P
WHERE P.PURCHASED_CNT=(SELECT MAX(P.PURCHASED_CNT) FROM product_level_summary AS P)


--Q11.  Using prodct_level_summary and product_category_level_summary tables, 
--Find Which product was most likely to be abandoned? (5 marks each for excel & sql)
SELECT P.product_id,p.PRODUCT_NAME FROM product_level_summary AS P
WHERE P.ABANDONED_CNT=(SELECT MAX(P.ABANDONED_CNT) FROM product_level_summary AS P)

--Q12.  Using prodct_level_summary and product_category_level_summary tables,
--Find which product had the highest view to purchase percentage? (5 marks each for excel & sql)

SELECT TOP 1  P.product_id,P.PRODUCT_NAME,ROUND(P.PURCHASED_CNT/CAST(P.PRODUCT_VIEW_CNT AS FLOAT) *100,2) AS PERCENTAGE_ FROM product_level_summary AS P
ORDER BY PERCENTAGE_ DESC

--Q13.  Using prodct_level_summary and product_category_level_summary tables,
--Find what is the average conversion rate from view to cart add? (5 marks each for excel & sql)
SELECT ROUND(SUM(P.PRODUCT_ADDED_CNT)/CAST(SUM(P.PRODUCT_VIEW_CNT) AS FLOAT)*100,2) as AVG_CONVERSION_RATE FROM product_level_summary AS P


--Q14.  Using prodct_level_summary and product_category_level_summary tables,
--Find What is the average conversion rate from cart add to purchase? (5 marks each for excel & sql)
SELECT ROUND(SUM(P.PURCHASED_CNT)/CAST(SUM(P.PRODUCT_ADDED_CNT) AS FLOAT)*100,2) as AVG_CONVERSION_RATE FROM product_level_summary AS P

--Q15.  Using visit_summary table, Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event.  (10 marks each for excel & sql)
SELECT T.IMPRESSION,
COUNT(*) AS TOTAL_VISITS,
AVG(T.PAGE_VIEW_CNT) AS AVG_PAGE,
AVG(T.CART_ADD_CNT) AS AVG_ADD,
ROUND(SUM(T.PURCHASE_FLAG)/CAST(COUNT(*) AS FLOAT)*100,2) AS PURCHASE_PERCENTAGE
FROM (
SELECT *,
CASE 
WHEN V.AD_IMPRESSION_PER_VISIT IS NOT NULL THEN 'YES' ELSE 'NO'
END AS IMPRESSION
FROM visit_summary AS V) AS T
GROUP BY T.IMPRESSION


--Q16.  Using visit_summary table, can we conclude that clicking on an impression lead to higher purchase rates?  (10 marks each for excel & sql)
SELECT T.IMPRESSION,
ROUND(SUM(T.PURCHASE_FLAG)/CAST(COUNT(*) AS FLOAT)*100,2) AS PURCHASE_PERCENTAGE
FROM (
SELECT *,
CASE 
WHEN V.AD_IMPRESSION_PER_VISIT IS NOT NULL THEN 'YES' ELSE 'NO'
END AS IMPRESSION
FROM visit_summary AS V) AS T
GROUP BY T.IMPRESSION

--YES, IT LEADS TO HIGHER PURCHASE RATES

--Q17.  Using visit_summary table, What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them with users who just an impression but do not click?  (10 marks each for excel & sql)
SELECT T.ADD_STATUS,ROUND(SUM(T.PURCHASE_FLAG)/CAST(COUNT(*) AS FLOAT)*100,2) AS PURCHASE_PERCENTAGE
FROM (
SELECT V.*,
CASE 
WHEN V.AD_IMPRESSION_PER_VISIT IS NULL THEN 'NO ADDS'
WHEN V.AD_IMPRESSION_PER_VISIT IS NOT NULL AND V.AD_CLICK_CNT IS NULL THEN 'SEEN BUT NOT CLICKED'
ELSE 'CLICKED'
END AS ADD_STATUS
FROM visit_summary AS V
WHERE V.campaign_name IS NOT NULL) AS T
GROUP BY T.ADD_STATUS

--Q18.  Using visit_summary table, What metrics can you use to quantify the success or failure of each campaign compared to each other? (10 marks each for excel & sql)
SELECT V.campaign_name,SUM(V.PAGE_VIEW_CNT) AS PAGE_CNT,SUM(V.CART_ADD_CNT) AS CART_ADD_CNT,SUM(V.PURCHASE_FLAG) AS PURCHASE_CNT
FROM visit_summary AS V
GROUP BY V.campaign_name
