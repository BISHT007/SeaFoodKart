# 🌲 SeaFoodKart 

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - 📂 [Dataset](#dataset)
  - 🧙‍♂️ [Case Study Questions](#case-study-questions)
  -  🚀 [Solutions](#-solutions)

## 🛠️ Problem Statement

>SeaFoodKart is an online seafood store founded by Ramesh. Ramesh is CEO and is also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry to enhance customer experience, optimize operations, and drive sales. 
SeaFoodKart  offers a wide range of seafood products delivered directly to customers' doorsteps, with a focus on quality, convenience, and sustainability. 
SeaFoodKart is an online seafood store. When people visit their website, they're on a journey, like going through a funnel. At the top of the funnel are all the people who visit the site, and at the bottom are the ones who actually buy something. 
But, not everyone who visits ends up buying. Some people might leave before even looking at the products, some might add things to their cart but then change their mind, and some might start to buy but then decide not to. 
SeaFoodKart wants to figure out where exactly people are dropping out of this journey, like where they're leaving without buying anything. This helps them understand what parts of their website or the buying process might be turning people away. For example, maybe the website is hard to navigate, or maybe the prices are too high.
By figuring this out,  SeaFoodKart can make changes to their website or how they sell things online to try and keep more people from leaving without buying. It's all about making the buying process smoother and more appealing, so more people end up making a purchase.

## 📂 Dataset

### **```Product Details```**

<details>
<summary>
View table
</summary>

`TopoDesigns.Product_Details` includes all information about the entire range that Balanced Clothing sells in their store.

| "product_id" | "price" | "product_name"                     | "category_id" | "segment_id" | "style_id" | "category_name" | "segment_name" | "style_name"          |
|--------------|---------|------------------------------------|---------------|--------------|------------|-----------------|----------------|-----------------------|
| "c4a632"     | 13      | "Navy Oversized Jeans - Womens"    | 1             | 3            | 7          | "Womens"        | "Jeans"        | "Navy Oversized"      |
| "e83aa3"     | 32      | "Black Straight Jeans - Womens"    | 1             | 3            | 8          | "Womens"        | "Jeans"        | "Black Straight"      |
| "e31d39"     | 10      | "Cream Relaxed Jeans - Womens"     | 1             | 3            | 9          | "Womens"        | "Jeans"        | "Cream Relaxed"       |
| "d5e9a6"     | 23      | "Khaki Suit Jacket - Womens"       | 1             | 4            | 10         | "Womens"        | "Jacket"       | "Khaki Suit"          |
| "72f5d4"     | 19      | "Indigo Rain Jacket - Womens"      | 1             | 4            | 11         | "Womens"        | "Jacket"       | "Indigo Rain"         |
| "9ec847"     | 54      | "Grey Fashion Jacket - Womens"     | 1             | 4            | 12         | "Womens"        | "Jacket"       | "Grey Fashion"        |
| "5d267b"     | 40      | "White Tee Shirt - Mens"           | 2             | 5            | 13         | "Mens"          | "Shirt"        | "White Tee"           |
| "c8d436"     | 10      | "Teal Button Up Shirt - Mens"      | 2             | 5            | 14         | "Mens"          | "Shirt"        | "Teal Button Up"      |
| "2a2353"     | 57      | "Blue Polo Shirt - Mens"           | 2             | 5            | 15         | "Mens"          | "Shirt"        | "Blue Polo"           |
| "f084eb"     | 36      | "Navy Solid Socks - Mens"          | 2             | 6            | 16         | "Mens"          | "Socks"        | "Navy Solid"          |
| "b9a74d"     | 17      | "White Striped Socks - Mens"       | 2             | 6            | 17         | "Mens"          | "Socks"        | "White Striped"       |
| "2feb6b"     | 29      | "Pink Fluro Polkadot Socks - Mens" | 2             | 6            | 18         | "Mens"          | "Socks"        | "Pink Fluro Polkadot" |

</details>

### **```Product Sales```**

<details>
<summary>
View table
</summary>

`TopoDesigns.Product_Sales` contains product level information for all the transactions made for Balanced Tree including quantity, price, percentage discount, member status, a transaction ID and also the transaction timestamp.

Below is the display of the first 10 rows in this dataset:


| "prod_id" | "qty" | "price" | "discount" | "member" | "txn_id" | "start_txn_time          |
|-----------|-------|---------|------------|----------|----------|----------------------------|
| "c4a632"  | 4     | 13      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "5d267b"  | 4     | 40      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "b9a74d"  | 4     | 17      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "2feb6b"  | 2     | 29      | 17         | True     | "54f307" | "2021-02-13 01:59:43.296"  |
| "c4a632"  | 5     | 13      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "e31d39"  | 2     | 10      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "72f5d4"  | 3     | 19      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "2a2353"  | 3     | 57      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "f084eb"  | 3     | 36      | 21         | True     | "26cc98" | "2021-01-19 01:39:00.3456" |
| "c4a632"  | 1     | 13      | 21         | False    | "ef648d" | "2021-01-27 02:18:17.1648" |

</details>

### **```Product Price```**

<details>
<summary>
View table
</summary>

`TopoDesigns.Product_Price`

product_id	price
c4a632	13
e83aa3	32
e31d39	10
d5e9a6	23
72f5d4	19
9ec847	54
5d267b	40
c8d436	10
2a2353	57
</details>

### **```Product Hierarchy```**

<details>
<summary>
View table
</summary>

`TopoDesigns.Product_Hierarchy`

Parent_id	Level_code	level_text	level_name
1	0	Womens	Category
2	0	Mens	Category
3	1	Jeans	Segment
4	1	Jacket	Segment
5	1	Shirt	Segment
6	1	Socks	Segment
7	2	Navy Oversized	Style
8	2	Black Straight	Style
9	2	Cream Relaxed	Style
</details>

### **```User```**

<details>
<summary>
View table
</summary>

`TopoDesigns.Users`

User_id	cookie_id	Gender	Location
1	c4ca42	F	South
2	c81e72	M	South
3	eccbc8	F	South
4	a87ff6	F	North
5	e4da3b	M	South
6	e4da3c	M	South
7	8f14e4	M	North
8	c9f0f8	M	North
9	45c48c	F	South
</details>

## 🧙‍♂️ Data Preparation
1. To perform exploratory data analysis, I have combined all the above tables as 'final_raw_data'.
2. To perform analysis at customer level, I have formed a new file 'customer_360'.

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
