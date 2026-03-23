
## OP1: insertMany() — insert all 3 documents

db.products.insertMany([
  {
    _id: "E101",
    name: "Samsung 55 inch Smart TV",
    category: "Electronics",
    price: 55000,
    brand: "Samsung",
    warranty_years: 2,
    specifications: {
      resolution: "4K",
      voltage: "220V",
      screen_type: "LED"
    },
    features: ["Smart TV", "WiFi", "Bluetooth"],
    stock: 25
  },
  {
    _id: "C101",
    name: "Men's Denim Jacket",
    category: "Clothing",
    price: 2500,
    brand: "Levis",
    size_options: ["S", "M", "L", "XL"],
    material: "Denim",
    colors: ["Blue", "Black"],
    ratings: {
      average: 4.5,
      reviews: 120
    },
    stock: 50
  },
  {
    _id: "G101",
    name: "Organic Milk 1L",
    category: "Groceries",
    price: 60,
    brand: "Amul",
    expiry_date: new Date("2024-12-20"),
    nutritional_info: {
      calories: 150,
      protein: "8g",
      fat: "7g"
    },
    storage: "Refrigerated",
    stock: 200
  }
]);

## OP2: find() — Electronics products with price > 20000

db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

## OP3: find() — Groceries expiring before 2025-01-01

db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

## OP4: updateOne() — add discount_percent field

db.products.updateOne(
  { _id: "E101" },
  { $set: { discount_percent: 10 } }
);

## OP5: createIndex() — index on category

db.products.createIndex({ category: 1 });

Explanation:
Creating an index on the category field improves query performance, especially for frequent filtering like Electronics, Clothing, or Groceries.
It reduces full collection scans and speeds up retrieval.
