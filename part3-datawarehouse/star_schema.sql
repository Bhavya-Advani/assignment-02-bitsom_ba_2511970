
## ETL Decisions

### Decision 1 — Date Standardization
Problem:
The raw dataset contained inconsistent date formats such as DD-MM-YYYY, MM/DD/YYYY, and text formats. This makes time-based analysis unreliable.

Resolution:
All dates were converted into a standard YYYY-MM-DD format. A separate dim_date table was created to enable consistent and 
efficient time-based aggregation.

---

### Decision 2 — Category Normalization
Problem:
Product categories appeared in inconsistent formats such as "electronics", "ELECTRONICS", and "Electronics", leading to incorrect grouping.

Resolution:
All category values were standardized into proper case (Electronics, Clothing, Groceries) during the transformation stage to ensure accurate aggregation.

---

### Decision 3 — Handling Missing Values
Problem:
Some records contained NULL values in important fields like quantity and unit_price, which would affect revenue calculations.

Resolution:
Records with missing critical values were removed or corrected. Additionally, fact_sales was derived as (quantity × unit_price) 
to ensure consistency and avoid incomplete metrics.
