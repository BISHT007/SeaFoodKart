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
2. To perform analysis at Product level, I have formed a new file 'Product_level_summary'.

## 🧙‍♂️ Case Study Questions
<p align="center">
<img src="https://media3.giphy.com/media/JQXKbzdLTQJJKP176X/giphy.gif" width=80% height=80%>

### **A. High Level Sales Analysis**

1. What was the total quantity sold for all products?
2. What is the total generated revenue for all products before discounts?
3. What was the total discount amount for all products?


### **B. Transaction Analysis**

1. How many unique transactions were there?
2. What is the average unique products purchased in each transaction?
3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4. What is the average discount value per transaction?
5. What is the percentage split of all transactions for members vs non-members?
6. What is the average revenue for member transactions and non-member transactions?

### **C. Product Analysis**

1. What are the top 3 products by total revenue before discount?
2. What is the total quantity, revenue and discount for each segment?
3. What is the top selling product for each segment?
4. What is the total quantity, revenue and discount for each category?
5. What is the top selling product for each category?
6. What is the percentage split of revenue by product for each segment?
7. What is the percentage split of revenue by segment for each category?
8. What is the percentage split of total revenue by category?
9. What is the total transaction “penetration” for each product?
10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?
