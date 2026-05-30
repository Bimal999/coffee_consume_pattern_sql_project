# ☕ Coffee Sales Data Analysis using PostgreSQL

## 📌 Project Overview

This project analyzes coffee sales data using PostgreSQL to generate business insights related to customer behavior, product performance, market potential, and sales growth.

The analysis is performed using SQL and covers real-world business questions that a coffee chain might face when planning expansion and evaluating performance across multiple cities.

---

## 🎯 Project Objectives

- Estimate coffee market size across cities.
- Analyze revenue generated from coffee sales.
- Identify top-selling coffee products.
- Measure customer spending behavior.
- Compare city-level profitability metrics.
- Track monthly sales growth trends.
- Support data-driven business expansion decisions.

---

## 🛠️ Tools & Technologies

- PostgreSQL
- pgAdmin 4
- SQL

---

## 🗄️ Database Schema

### City

| Column | Data Type |
|----------|----------|
| city_id | INT (PK) |
| city_name | VARCHAR |
| population | INT |
| estimated_rent | FLOAT |
| city_rank | FLOAT |

### Customers

| Column | Data Type |
|----------|----------|
| customer_id | INT (PK) |
| customer_name | VARCHAR |
| city_id | INT (FK) |

### Products

| Column | Data Type |
|----------|----------|
| product_id | INT (PK) |
| product_name | VARCHAR |
| price | INT |

### Sales

| Column | Data Type |
|----------|----------|
| sale_id | INT (PK) |
| sale_date | DATE |
| product_id | INT (FK) |
| customer_id | INT (FK) |
| total | FLOAT |
| rating | FLOAT |

---

## 🔗 Entity Relationship Diagram

```text
City
 │
 └── city_id
       │
       ▼
Customers
 │
 └── customer_id
       │
       ▼
Sales
 │
 ├── product_id
 │
 ▼
Products
```

---

# 📊 Business Questions Solved

## 1. Estimated Coffee Consumers by City

### Business Problem
The company wants to estimate the potential coffee-consuming population in each city.

### Analysis
Assuming 25% of the population consumes coffee.

### Business Impact
- Identifies potential market size.
- Helps prioritize city expansion.
- Supports demand forecasting.

---

## 2. Total Revenue Generated in Q4 2023

### Business Problem
Determine revenue generated across cities during the last quarter of 2023.

### Analysis
- Extract year and quarter from sales date.
- Aggregate revenue by city.

### SQL Concepts Used
- Joins
- Aggregation
- Date Functions

---

## 3. Units Sold per Product

### Business Problem
Identify the most popular coffee products.

### Analysis
Count total sales transactions for each product.

### SQL Concepts Used
- GROUP BY
- COUNT()
- ORDER BY

---

## 4. Average Sales per Customer in Each City

### Business Problem
Understand customer spending behavior city-wise.

### KPI

```text
Average Sales per Customer =
Total Revenue / Unique Customers
```

### SQL Concepts Used
- COUNT(DISTINCT)
- SUM()
- Aggregation

---

## 5. Top 3 Selling Products in Each City

### Business Problem
Identify the highest-performing products across cities.

### Analysis
- Rank products by sales volume.
- Select top three products per city.

### SQL Concepts Used
- CTE
- Window Functions
- RANK()

---

## 6. Unique Customers by City

### Business Problem
Measure customer penetration in each city.

### Analysis
Count distinct customers who purchased coffee.

### SQL Concepts Used
- COUNT(DISTINCT)
- GROUP BY

---

## 7. Average Sales and Rent per Customer

### Business Problem
Compare revenue generation against city operating costs.

### KPIs

```text
Average Sales per Customer

Average Rent per Customer
```

### Business Value
- Compare city profitability.
- Evaluate expansion feasibility.

---

## 8. Monthly Sales Growth Rate Analysis

### Business Problem
Track sales growth and decline trends over time.

### KPI Formula

```text
Growth Rate (%) =
(Current Month Sales - Previous Month Sales)
/
Previous Month Sales
× 100
```

### SQL Concepts Used

- DATE_TRUNC()
- LAG()
- Window Functions
- CTEs
- NULLIF()

---

# 🚀 Advanced SQL Concepts Demonstrated

### Joins

```sql
INNER JOIN
```

### Aggregation Functions

```sql
SUM()
COUNT()
AVG()
```

### Window Functions

```sql
RANK()
LAG()
```

### Date Functions

```sql
EXTRACT()
DATE_TRUNC()
```

### Common Table Expressions (CTEs)

```sql
WITH
```

### Ranking Analysis

```sql
RANK() OVER()
```

### Growth Analysis

```sql
LAG()
```

---

# 📈 Key Insights Generated

- Cities with the largest coffee-consuming population.
- Revenue contribution by city.
- Best-selling coffee products.
- Customer purchasing behavior.
- Customer penetration across cities.
- Revenue versus rental cost comparison.
- Monthly sales growth trends.
- Product demand ranking by city.

---

# 💡 Skills Demonstrated

- SQL Query Writing
- Data Analysis
- Data Modeling
- Business Analytics
- KPI Development
- Window Functions
- Data Aggregation
- Time-Series Analysis
- Analytical Thinking
- Problem Solving

---

# 📁 Project Structure

```text
coffee-sales-analysis/
│
├── coffee_sales_data.sql
├── README.md
└── dataset/
```

---

# 👨‍💻 Author

**Bimal**

Aspiring Data Analyst passionate about:

- SQL
- Power BI
- Data Visualization
- Business Intelligence
- Analytics Engineering

---

## ⭐ Project Highlights

✔ Relational Database Design  
✔ Business KPI Analysis  
✔ Window Functions & Ranking  
✔ Time-Series Growth Analysis  
✔ Real-World Business Problem Solving  
✔ Portfolio-Ready SQL Project

---

### If you found this project useful, consider giving it a ⭐ on GitHub.
