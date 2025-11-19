-- Week 7 Assignment: Database Design and Normalization
-- All solutions written for MySQL

/* ==========================================================
   QUESTION 1: Achieving 1NF
   The original table ProductDetail contains multi-valued
   attributes in Products column (e.g., 'Laptop, Mouse').
   Goal: Transform into First Normal Form (1NF) by ensuring
   each row contains only ONE product.
   ========================================================== */

-- Step 1: Create the original table (for demonstration)
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 2: Insert sample data
INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 3: Transform into 1NF
-- Split multi-valued Products column into separate rows.
-- MySQL does not have STRING_SPLIT, so we use JSON tricks.

SELECT 
    OrderID,
    CustomerName,
    TRIM(JSON_UNQUOTE(JSON_EXTRACT(json_each.value, '$'))) AS Product
FROM ProductDetail,
JSON_TABLE(
    CONCAT('[\"', REPLACE(Products, ', ', '\",\"'), '\"]'),
    "$[*]" COLUMNS(value JSON PATH "$")
) AS json_each;



/* ==========================================================
   QUESTION 2: Achieving 2NF
   The table OrderDetails is in 1NF but still has partial
   dependency: CustomerName depends only on OrderID.
   Goal: Split into two tables:
   (1) Orders table      → OrderID, CustomerName
   (2) OrderItems table  → OrderID, Product, Quantity
   ========================================================== */

-- Step 1: Create the original 1NF table
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

-- Step 2: Insert sample data
INSERT INTO OrderDetails VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 3: Transform to 2NF by removing partial dependency

-- Create Orders table (OrderID uniquely determines CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique orders
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderItems table (each product depends on full key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product items
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
