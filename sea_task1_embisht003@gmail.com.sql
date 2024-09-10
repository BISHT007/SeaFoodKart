-- Create a database called 'seafoodkart' in the SQL server
--CREATE DATABASE seafoodkart

-- Import all five csv files (data sets) into SQL server under seafoodkart database
-- DONE

--. What is the count of records in each table?
SELECT COUNT(*) AS campaign_identifier_CNT FROM campaign_identifier 
SELECT COUNT(*) AS event_identifier_CNT FROM event_identifier 
SELECT COUNT(*) AS events_CNT FROM events AS events_CNT
SELECT COUNT(*) AS users_CNT FROM users 
SELECT COUNT(*) AS page_heirarchy_CNT FROM page_heirarchy 

-- Create combined table of all the five tables by joining these tables. The final table name should be 'Final_Raw_Data' in the data base
select * into Final_Raw_Data from 
(
SELECT E.*,EI.event_name,P.page_name,P.product_category,P.product_id,U.user_id,U.start_date AS user_StartDate
,C.campaign_id,C.campaign_name,C.start_date as campaign_startDate,C.end_date as campaign_EndDate
FROM events AS E 
INNER JOIN event_identifier AS EI ON E.event_type=EI.event_type
INNER JOIN page_heirarchy AS P ON E.page_id=P.page_id
INNER JOIN users AS U ON E.cookie_id=U.cookie_id 
LEFT JOIN campaign_identifier AS C ON p.product_id=c.products
) as T

--Q. create a new table (product_level_summary) which has the following details:
-- How many times was each product viewed?

SELECT F.product_id,COUNT(*) AS PRODUCT_VIEW_CNT FROM Final_Raw_Data AS F
WHERE F.event_name='PAGE VIEW' AND F.product_id IS NOT NULL
GROUP BY F.product_id

-- How many times was each product added to cart? 
SELECT F.product_id,COUNT(*) AS PRODUCT_ADDED_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.product_id

-- How many times was each product added to a cart but not purchased (abandoned)? 
 --added to cart
SELECT  F.product_id,COUNT(*) AS ABANDONED_CNT FROM Final_Raw_Data AS F WHERE 
F.visit_id IN (
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=2
EXCEPT
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F 
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_id


-- How many times was each product purchased?
SELECT F.product_id,COUNT(*) AS PURCHASED_CNT FROM Final_Raw_Data AS F 
WHERE F.visit_id IN (
SELECT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_id

-- Hint: The above calculations should be at product level (one record for each product). This table should be present in the database

--creating a new table (product_level_summary)->
DROP TABLE product_level_summary
SELECT * INTO product_level_summary FROM (
SELECT T1.*,T2.PRODUCT_ADDED_CNT,T3.ABANDONED_CNT,T4.PURCHASED_CNT FROM 
(
SELECT F.product_id,F.page_name AS PRODUCT_NAME,COUNT(*) AS PRODUCT_VIEW_CNT FROM Final_Raw_Data AS F
WHERE F.event_name='PAGE VIEW' AND F.product_id IS NOT NULL
GROUP BY F.product_id,F.page_name
) AS T1
INNER JOIN 
(
SELECT F.product_id,COUNT(*) AS PRODUCT_ADDED_CNT FROM Final_Raw_Data AS F
WHERE F.event_name='ADD TO CART'
GROUP BY F.product_id
)  AS T2 ON T1.product_id=T2.product_id
INNER JOIN 
(
SELECT  F.product_id,COUNT(*) AS ABANDONED_CNT FROM Final_Raw_Data AS F WHERE 
F.visit_id IN (
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=2
EXCEPT
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F 
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_id
) AS T3 ON T1.product_id=T3.product_id
INNER JOIN 
(
SELECT F.product_id,COUNT(*) AS PURCHASED_CNT FROM Final_Raw_Data AS F 
WHERE F.visit_id IN (
SELECT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_id
) AS T4 ON T1.product_id=T4.product_id
) AS TT



--Q. create a new table (product_category_level_summary) which has the following details:
-- How many times was each product viewed? 
SELECT F.product_category,COUNT(*) AS PRODUCT_VIEW_CNT FROM Final_Raw_Data AS F
WHERE F.event_name='PAGE VIEW' AND F.product_id IS NOT NULL
GROUP BY F.product_category

-- How many times was each product added to cart? 
SELECT F.product_category,COUNT(*) AS PRODUCT_ADDED_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.product_category

-- How many times was each product added to a cart but not purchased (abandoned)? 
SELECT  F.product_category,COUNT(*) AS ABANDONED_CNT FROM Final_Raw_Data AS F WHERE 
F.visit_id IN (
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=2
EXCEPT
SELECT DISTINCT F.visit_id FROM Final_Raw_Data AS F 
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_category

-- How many times was each product purchased?
SELECT F.product_category,COUNT(*) AS PURCHASED_CNT FROM Final_Raw_Data AS F 
WHERE F.visit_id IN (
SELECT F.visit_id FROM Final_Raw_Data AS F
WHERE F.event_type=3) AND F.event_type=2
GROUP BY F.product_category

--Hint: The above calculations should be at product category level(one record for each product category). This table should be present in the database.

--Note: Check your logic by checking the rows and columns.

--creating a new table (product_category_level_summary)->

SELECT * INTO product_category_level_summary FROM(
SELECT P.product_category,SUM(PL.ABANDONED_CNT) AS ABANDONED_CAT_CNT,
SUM(PL.PRODUCT_ADDED_CNT) AS PRODUCT_CAT_ADDED_CNT,
SUM(PL.PRODUCT_VIEW_CNT) AS PRODUCT_CAT_VIEW_CNT,
SUM(PL.PURCHASED_CNT) AS PURCHASED_CAT_CNT 
FROM product_level_summary AS PL INNER JOIN page_heirarchy AS P ON PL.product_id=P.product_id
GROUP BY P.product_category) AS TT 


--Q. Create a new table 'visit_summary' that has 1 single row for every unique visit_id record and has the following 10 columns:

--1. user_id
--2. visit_id 
--3. visit_start_time: the earliest event_time for each visit
--4. page_views: count of page views for each visit
SELECT F.visit_id,COUNT(*) AS PAGE_VIEW_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=1
GROUP BY F.visit_id

--5. cart_adds: count of product cart add events for each visit 
SELECT F.visit_id,COUNT(*) AS CART_ADD_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.visit_id

--6. purchase: 1/0 flag if a purchase event exists for each visit 
SELECT F.visit_id,
CASE 
WHEN F.visit_id IN (SELECT F.visit_id FROM Final_Raw_Data AS F WHERE F.event_type=3) THEN 1 ELSE 0 
END AS PURCHASE_FLAG
FROM Final_Raw_Data AS F

--7. campaign_name: map the visit to a campaign if the visit_start_time falls between the start_date and end_date 
SELECT DISTINCT F.visit_id,F.campaign_name FROM Final_Raw_Data AS F 
WHERE F.date BETWEEN F.campaign_startDate AND F.campaign_EndDate 

--8. impression: count of ad impressions for Each visit 

SELECT F.visit_id,COUNT(*) AS AD_IMPRESSION_PER_VISIT FROM Final_Raw_Data AS F
WHERE F.event_type=4
GROUP BY F.visit_id

--9. click: count of ad clicks for each visit 
SELECT F.visit_id,COUNT(*) AS AD_CLICK_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=5
GROUP BY F.visit_id

--10. cart_products: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
SELECT F.visit_id,STRING_AGG(F.page_name,',') WITHIN GROUP (ORDER BY F.SEQUENCE_NUMBER) AS CART_PRODUCT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.visit_id
--Hint: The above calculations should be at visit_id level(one record for each visit_id). This table should be present in the database.

--Note: Check your logic by checking the rows and columns.

--CREATING visit_summary TABLE->

SELECT * INTO visit_summary FROM (
SELECT T1.*,T2.PAGE_VIEW_CNT,T3.CART_ADD_CNT,T4.PURCHASE_FLAG,T5.campaign_name,T6.AD_IMPRESSION_PER_VISIT,T7.AD_CLICK_CNT,T8.CART_PRODUCT FROM (
SELECT F.visit_id,F.user_id,MIN(F.time) AS EARLIEST_TIME
FROM Final_Raw_Data AS F
GROUP BY F.visit_id,F.user_id) AS T1
LEFT JOIN (
SELECT F.visit_id,COUNT(*) AS PAGE_VIEW_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=1
GROUP BY F.visit_id) AS T2 ON T1.visit_id=T2.visit_id
LEFT JOIN (
SELECT F.visit_id,COUNT(*) AS CART_ADD_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.visit_id
) AS T3 ON T1.visit_id=T3.visit_id
LEFT JOIN (
SELECT DISTINCT F.visit_id,
CASE 
WHEN F.visit_id IN (SELECT F.visit_id FROM Final_Raw_Data AS F WHERE F.event_type=3) THEN 1 ELSE 0 
END AS PURCHASE_FLAG
FROM Final_Raw_Data AS F
) AS T4 ON T1.visit_id=T4.visit_id
LEFT JOIN 
(
SELECT DISTINCT F.visit_id,F.campaign_name FROM Final_Raw_Data AS F 
WHERE F.date BETWEEN F.campaign_startDate AND F.campaign_EndDate 
) AS T5 ON T1.visit_id=T5.visit_id
LEFT JOIN (
SELECT F.visit_id,COUNT(*) AS AD_IMPRESSION_PER_VISIT FROM Final_Raw_Data AS F
WHERE F.event_type=4
GROUP BY F.visit_id
) AS T6 ON T1.visit_id=T6.visit_id
LEFT JOIN (
SELECT F.visit_id,COUNT(*) AS AD_CLICK_CNT FROM Final_Raw_Data AS F
WHERE F.event_type=5
GROUP BY F.visit_id
) AS T7 ON T1.visit_id=T7.visit_id
LEFT JOIN (
SELECT F.visit_id,STRING_AGG(F.page_name,',') WITHIN GROUP (ORDER BY F.SEQUENCE_NUMBER) AS CART_PRODUCT FROM Final_Raw_Data AS F
WHERE F.event_type=2
GROUP BY F.visit_id
) AS T8 ON T1.visit_id=T8.visit_id
) AS TT

SELECT * FROM visit_summary