
# 1.1 — Anomaly Analysis (for `normalization.md`)

## Anomaly Analysis

### Insert Anomaly

An insert anomaly occurs when we cannot insert data about an entity without inserting unrelated data.

Example from dataset:

Columns involved:
`product_id, product_name, category, unit_price`

If the company wants to add a **new product** (e.g., `P110 – Wireless Mouse`) that has not yet been ordered, it **cannot be inserted** because the table requires values for:

* `order_id`
* `customer_id`
* `sales_rep_id`
* `quantity`

Thus a product cannot exist unless an order already exists.

Example row structure from CSV:

| order_id | product_id | product_name | unit_price | quantity |
| -------- | ---------- | ------------ | ---------- | -------- |
| ORD1027  | P104       | USB Keyboard | 800        | 2        |

A new product would require creating a not genuine order, which is incorrect.

---

### Update Anomaly

An update anomaly occurs when the same information appears in multiple rows and must be updated everywhere.

Example:

Customer C001 – Rohan Mehta appears in multiple rows with the same attributes:

Columns involved:
`customer_id, customer_name, customer_email, customer_city`

Example rows:

| order_id | customer_id | customer_name | customer_city |
| -------- | ----------- | ------------- | ------------- |
| ORD1114  | C001        | Rohan Mehta   | Mumbai        |
| ORD1083  | C001        | Rohan Mehta   | Mumbai        |

If Rohan moves to Bhopal, the value must be updated in every row where `customer_id = C001`.
If one row is missed, inconsistent data occurs.

---

### Delete Anomaly

A delete anomaly occurs when deleting one record unintentionally discards important information.

Example:

If the only order containing a specific product is deleted, all information about that product is lost.

Example structure:

| order_id | product_id | product_name |
| -------- | ---------- | ------------ |
| ORD1002  | P107       | Laptop Stand |

If `ORD1002` is deleted, the database also loses:
product name, category, and unit price

Thus deleting an order removes product information, which should be stored independently.


## Normalization Justification

Normalization to Third Normal Form (3NF) resolves insufficency in data by separating the dataset into logically independent tables such as `customers`, `products`, `sales_reps`, `orders`, and `order_items`. Each table stores data about a single entity, eliminating redundancy and ensuring data integrity through primary and foreign key relationships. This structure improves maintainability, prevents anomalies, and allows the database to scale efficiently as the business expands.
---

# 1.2 — Schema Design (3NF)

File: `schema_design.sql`

Normalization separates entities into independent tables.

## Tables in 3NF

* Customers
* Products
* Sales_Representatives
* Orders
* Order_Items

---

## Customers Table


CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);


### Sample Data


INSERT INTO customers VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Kapoor','sneha@gmail.com','Pune'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai');


---

## Products Table


CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

INSERT INTO products VALUES
('P101','Laptop','Electronics',65000),
('P102','Smartphone','Electronics',30000),
('P103','Headphones','Accessories',2000),
('P104','USB Keyboard','Accessories',800),
('P105','Monitor','Electronics',12000);


---

## Sales Representatives Table

CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL,
    office_address VARCHAR(200) NOT NULL
);

INSERT INTO sales_reps VALUES
('S001','Rahul Khanna','rahul@company.com','Mumbai HQ'),
('S002','Anita Desai','anita@company.com','Delhi Office'),
('S003','Karan Patel','karan@company.com','Bangalore Office'),
('S004','Meera Joshi','meera@company.com','Mumbai HQ'),
('S005','Arjun Shah','arjun@company.com','Delhi Office');


## Orders Table

CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

INSERT INTO orders VALUES
('ORD1001','C001','S001','2024-01-10'),
('ORD1002','C002','S002','2024-01-11'),
('ORD1003','C003','S003','2024-01-12'),
('ORD1004','C004','S004','2024-01-13'),
('ORD1005','C005','S005','2024-01-14');
```



## Order Items Table


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id,product_id,quantity) VALUES
('ORD1001','P101',1),
('ORD1001','P103',2),
('ORD1002','P102',1),
('ORD1003','P104',3),
('ORD1004','P105',1);


# 1.3 — SQL Queries


## Q1: List all customers from Mumbai along with their total order value

SELECT 
c.customer_name,
SUM(p.unit_price * oi.quantity) AS total_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_name;


## Q2: Find the top 3 products by total quantity sold

SELECT 
p.product_name,
SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 3;


## Q3: List all sales representatives and the number of unique customers they have handled

SELECT 
s.sales_rep_name,
COUNT(DISTINCT o.customer_id) AS unique_customers
FROM sales_reps s
LEFT JOIN orders o ON s.sales_rep_id = o.sales_rep_id
GROUP BY s.sales_rep_name;



## Q4: Find all orders where the total value exceeds 10000, sorted by value descending

SELECT 
o.order_id,
SUM(p.unit_price * oi.quantity) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING order_value > 10000
ORDER BY order_value DESC;


## Identify any products that have never been ordered

SELECT 
p.product_name
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;



