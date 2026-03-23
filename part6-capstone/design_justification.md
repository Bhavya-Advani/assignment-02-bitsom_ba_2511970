
## Storage Systems

The architecture uses a combination of OLTP databases, a data lakehouse, and a vector database to meet different system requirements. A relational database such as PostgreSQL is used for transactional data including customer orders, payments, and delivery status. This ensures ACID compliance, which is critical for maintaining consistency in financial transactions.

For analytical and large-scale data storage, a data lakehouse is used. It stores structured, semi-structured, and unstructured data such as GPS logs, customer reviews, and menu images in formats like Parquet. The lakehouse enables scalable storage and efficient querying, making it suitable for business intelligence and reporting.

Additionally, a vector database is used to store embeddings generated from customer reviews and queries. This enables semantic search and recommendation systems, allowing the platform to understand user intent beyond simple keyword matching.

## OLTP vs OLAP Boundary

The OLTP system ends at the point where transactional data such as orders and payments are recorded in the relational database. This layer is optimized for real-time operations, ensuring fast inserts and updates with high consistency.

The OLAP system begins when this transactional data is extracted and loaded into the data lakehouse through ETL pipelines. In this layer, data is transformed, aggregated, and optimized for analytical queries. The separation ensures that heavy analytical workloads do not impact transactional performance.

## Trade-offs

One significant trade-off in this architecture is increased system complexity due to the use of multiple storage systems. Managing data consistency and synchronization across OLTP, lakehouse, and vector databases can be challenging.

To mitigate this, automated ETL pipelines and data validation mechanisms can be implemented to ensure consistency. Additionally, using unified data governance tools and metadata management systems can help maintain data integrity and simplify system management. Despite the complexity, this trade-off is justified as it enables scalability, flexibility, and advanced analytics capabilities.
