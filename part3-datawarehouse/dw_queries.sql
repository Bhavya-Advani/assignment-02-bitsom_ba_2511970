
CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    month_name TEXT NOT NULL,
    quarter INTEGER NOT NULL
);

INSERT INTO dim_date VALUES
(1,'2024-01-01',1,1,2024,'January',1),
(2,'2024-02-01',1,2,2024,'February',1),
(3,'2024-03-01',1,3,2024,'March',1),
(4,'2024-04-01',1,4,2024,'April',2),
(5,'2024-05-01',1,5,2024,'May',2);

CREATE TABLE dim_store (
    store_id INTEGER PRIMARY KEY,
    store_name TEXT NOT NULL,
    city TEXT NOT NULL
);

INSERT INTO dim_store VALUES
(1,'Store Mumbai','Mumbai'),
(2,'Store Delhi','Delhi'),
(3,'Store Bangalore','Bangalore');

CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL
);

INSERT INTO dim_product VALUES
(1,'Laptop','Electronics'),
(2,'Shirt','Clothing'),
(3,'Milk','Groceries'),
(4,'Headphones','Electronics'),
(5,'Jeans','Clothing');

CREATE TABLE fact_sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_id INTEGER NOT NULL,
    store_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_sales DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO fact_sales 
(date_id, store_id, product_id, quantity, unit_price, total_sales)
VALUES
(1,1,1,1,60000,60000),
(1,2,2,2,1500,3000),
(2,1,3,5,50,250),
(2,3,4,2,2000,4000),
(3,2,5,3,2000,6000),
(3,3,1,1,62000,62000),
(4,1,2,4,1400,5600),
(4,2,3,10,55,550),
(5,3,4,3,2100,6300),
(5,1,5,2,1800,3600);

