Insert Anomaly

An insert anomaly occurs when we cannot input data about a new entity without inserting unrelated data.

Example from dataset orders_flat.csv:
Columns involved: product_id, product_name, category, unit_price

If the retail company wants to add a new product (e.g., P110 – Wireless Mouse) that has not yet been ordered, it cannot be inserted because the table requires values for all existing columns: i.e., order_id, customer_id, sales_rep_id, quantity
Thus a product cannot exist unless an order already exists. Therefore, new product would require creating a fake order, which is incorrect.


Update Anomaly

An update anomaly occurs when the same information appears in multiple rows, and in case of any alterations, information must be updated everywhere.

Example: Customer C001 – Rohan Mehta appears in multiple rows with the same attributes:

Columns involved:
customer_id, customer_name, customer_email, customer_city

If Rohan moves to any other city (that is, change in city from Mumbai to Bhopal), the value must be updated in every row where customer_id = C001.
If one row is missed, inconsistent data occurs.

Delete Anomaly

A delete anomaly occurs when deleting one record unintentionally discards all important information.

Example:

If the only order containing a specific product is deleted, all information about that product is lost.

If ORD1003 is deleted, the database also loses the information contained in the table, that is, product name, category, unit price
Thus deleting an order removes product information, which should be stored independently.
