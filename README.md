# 🍕 Pizza Hut Sales Analysis (SQL Project)

This project analyzes Pizza Hut sales data using **SQL** to extract meaningful business insights such as total revenue, popular pizzas, order trends, and category-wise performance.

---

## 📌 Project Overview

The goal of this project is to perform **end-to-end SQL analysis** on a pizza sales database.  
It answers real-world business questions related to:
- Sales performance
- Customer ordering behavior
- Revenue trends
- Product popularity

This project is ideal for **Data Analyst / Data Engineer / SQL practice**.

---

## 🛠️ Tech Stack

- **Database:** MySQL  
- **Language:** SQL  
- **Concepts Used:**
  - Joins
  - Aggregate functions
  - Subqueries
  - Window functions
  - Group By & Having
  - Ranking & cumulative analysis

---

## 🗂️ Database Schema

### 📄 Tables Used

#### 1️⃣ orders
| Column Name | Data Type |
|------------|-----------|
| order_id | INT (PK) |
| order_date | DATE |
| order_time | TIME |

#### 2️⃣ order_details
| Column Name | Data Type |
|-------------|----------|
| order_details_id | INT (PK) |
| order_id | INT (FK) |
| pizza_id | TEXT |
| quantity | INT |

#### 3️⃣ pizzas
| Column Name | Data Type |
|-------------|----------|
| pizza_id | TEXT |
| pizza_type_id | TEXT |
| size | TEXT |
| price | DECIMAL |

#### 4️⃣ pizza_types
| Column Name | Data Type |
|-------------|----------|
| pizza_type_id | TEXT |
| name | TEXT |
| category | TEXT |

---

## 🔍 Business Questions Answered

### ✅ Basic Analysis
1. Total number of orders placed  
2. Total revenue generated from pizza sales  
3. Highest-priced pizza  
4. Most common pizza size ordered  

### ✅ Intermediate Analysis
5. Top 5 most ordered pizza types  
6. Total quantity ordered by pizza category  
7. Order distribution by hour of the day  
8. Category-wise pizza distribution  

### ✅ Advanced Analysis
9. Average number of pizzas ordered per day  
10. Top 3 pizza types based on revenue  
11. Percentage contribution of each pizza category to total revenue  
12. Cumulative revenue generated over time  
13. Top 3 pizzas by revenue within each category (using window functions)

---

## 📊 Key SQL Concepts Demonstrated

- **INNER JOIN** across multiple tables  
- **Aggregate functions:** `SUM()`, `COUNT()`, `AVG()`  
- **Window functions:**  
  - `RANK() OVER(PARTITION BY ...)`  
  - `SUM() OVER(ORDER BY ...)`  
- **Subqueries** for revenue comparison  
- **Date & Time functions** (`HOUR()`)

---

## ▶️ How to Run This Project

1. Create the database:
   ```sql
   CREATE DATABASE pizzahut;
   USE pizzahut;
