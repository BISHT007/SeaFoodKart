# 🌲 SeaFoodKart 

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - 📂 [Dataset](#dataset)
  - 🧙‍♂️ [Case Study Questions](#case-study-questions)
  -  🚀 [Solutions](#-solutions)

## 🛠️ Problem Statement

>SeaFoodKart is an online seafood store founded by Ramesh. Ramesh is CEO and is also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry to enhance customer experience, optimize operations, and drive sales. 
>SeaFoodKart  offers a wide range of seafood products delivered directly to customers' doorsteps, with a focus on quality, convenience, and sustainability. 
>SeaFoodKart is an online seafood store. When people visit their website, they're on a journey, like going through a funnel. At the top of the funnel are all the people who visit the site, and at the bottom are the ones who actually buy something. 
>But, not everyone who visits ends up buying. Some people might leave before even looking at the products, some might add things to their cart but then change their mind, and some might start to buy but then decide not to. 
>SeaFoodKart wants to figure out where exactly people are dropping out of this journey, like where they're leaving without buying anything. This helps them understand what parts of their website or the buying process might be turning people away. For example, maybe the website is hard to navigate, or maybe the prices are too high.
>By figuring this out,  SeaFoodKart can make changes to their website or how they sell things online to try and keep more people from leaving without buying. It's all about making the buying process smoother and more appealing, so more people end up making a purchase.

## 📂 Dataset

### **```Users Table```**

<details>
Users Table - Customers who visit the SeaFoodKart website are tagged via their cookie_id.
Column Description:
-- user_id: unique id for customer
-- cookie_id: Cookies are small pieces of text sent to your browser by a website you visit. They help that website remember information about your visit, which can both make it easier to visit the site again and make the site more useful to you. Most cookies contain a unique identifier called a cookie ID: a string of characters that websites and servers associate with the browser on which the cookie is stored.
-- start_date: customer start date

</details>

### **```Events Table```**

<details>
Customer visits are logged in this events table at a cookie_id level and the event_type and page_id values can be used to join onto relevant satellite tables to obtain further information about each event. The sequence_number is used to order the events within each visit.
Column Description:
-- visit_id: unique id for the visit
-- cookie_id: Cookies are small pieces of text sent to your browser by a website you visit. They help that website remember information about your visit, which can both make it easier to visit the site again and make the site more useful to you. Most cookies contain a unique identifier called a cookie ID: a string of characters that websites and servers associate with the browser on which the cookie is stored.
-- page_id: id for each page in the website
-- event_type: customer action on the website (page view, add to cart, purchase, ad click, ad impression etc.)
-- sequence_number: The sequence_number is used to order (sort) the events within each visit.
-- event_time: event time stamp

</details>

### **```Event Identifier  Table```**

<details>
The event_identifier table shows the types of events which are captured by  SeaFoodKart's digital data systems
Column Description:
-- Event_type: unique identifier for customer action on the website (page view, add to cart, purchase, ad click, ad impression etc.)
-- Event_name: Event Name

</details>

### **```Campaign Identifier Table```**

<details>
This table shows information for the 3 campaigns that SeaFoodKart has ran on their website so far in 2020.
Column Description:
-- campaign_id : unique id for campaign
-- products: which of the products under this campaign
-- campaign_name: description of campaign (Name of the campaign)
-- start_date: campaign start date
-- end_date: campaign end date

</details>

### **```Page Hierarchy Table ```**

<details>
This table lists all of the pages on the SeaFoodKart website which are tagged and have data passing through from user interaction events
Column Description:
-- page_id: unique id for page in website
-- page_name: name of page
-- product_category: hierarchy of product (which category product page falls into)
-- product_id: unique id for product

</details>

## 🧙‍♂️ Data Preparation
1. To perform exploratory data analysis, I have combined all the above tables as 'final_raw_data'.
2. To perform analysis at Product level, I have formed a new table 'Product_level_summary'.
3. To perform analysis at Product category level, I have formed a new table 'Product_level_summary'.
4. I have created a new table 'visit_summary' that has 1 single row for every unique visit_id record.

## 🧙‍♂️ Case Study Questions
<p align="center">
<img src="https://media3.giphy.com/media/JQXKbzdLTQJJKP176X/giphy.gif" width=80% height=80%>

### **A. Digital Analysis**

--Q1. How many users are there? 
--Q2. How many cookies does each user have on average? 
--Q3. What is the unique number of visits by all users per month?  
--Q4. What is the number of events for each event type? 
--Q5. What is the percentage of visits which have a purchase event? 
--Q6. What is the percentage of visits which view the checkout page but do not have a purchase event?
--Q7. What are the top 3 pages by number of views? 
--Q8. What is the number of views and cart adds for each product category?  

### ****B. Product Funnel Analysis****

--Q9. What are the top 3 products by purchases?
--Q10.  Using prodct_level_summary and product_category_level_summary tables, 
--Find which product had the most views, cart adds and purchases? 
--Q11.  Using prodct_level_summary and product_category_level_summary tables, 
--Find Which product was most likely to be abandoned? 
--Q12.  Using prodct_level_summary and product_category_level_summary tables,
--Find which product had the highest view to purchase percentage? 
--Q13.  Using prodct_level_summary and product_category_level_summary tables,
--Find what is the average conversion rate from view to cart add? (5 marks each for excel & sql)
--Q14.  Using prodct_level_summary and product_category_level_summary tables,
--Find What is the average conversion rate from cart add to purchase? (5 marks each for excel & sql)

### ****B. Product Funnel Analysis****

--Q15.  Using visit_summary table, Identifying users who have received impressions during each campaign period and comparing each metric with other users who did not have an impression event. 
--Q16.  Using visit_summary table, can we conclude that clicking on an impression lead to higher purchase rates?
--Q17.  Using visit_summary table, What is the uplift in purchase rate when comparing users who click on a campaign impression versus users who do not receive an impression? What if we compare them with users who just an impression but do not click? 
--Q18.  Using visit_summary table, What metrics can you use to quantify the success or failure of each campaign compared to each other?
