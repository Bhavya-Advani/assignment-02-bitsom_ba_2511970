CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_city VARCHAR(50) NOT NULL
);

INSERT INTO customers VALUES
('C001','Rohan Mehta','rohan@gmail.com','Mumbai'),
('C002','Priya Sharma','priya@gmail.com','Delhi'),
('C003','Amit Verma','amit@gmail.com','Bangalore'),
('C004','Sneha Kapoor','sneha@gmail.com','Pune'),
('C005','Vikram Singh','vikram@gmail.com','Mumbai');

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
