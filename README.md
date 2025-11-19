Database Design & Normalization – Week 7 Assignment
Overview

This assignment focuses on improving database structure through normalization. The goal is to understand and apply 1NF, 2NF, and 3NF principles to remove redundancy, eliminate partial dependencies, and ensure efficient data organization.

The assignment requires transforming poorly structured tables into properly normalized versions using SQL queries.

Files Included

answers.sql – Contains all SQL queries for Question 1 and Question 2.

README.md – Explains the database design concepts and summarizes the solutions.

Learning Objectives

Apply First Normal Form (1NF) to eliminate repeating groups.

Apply Second Normal Form (2NF) to remove partial dependencies.

Understand how normalization improves database integrity and structure.

Question 1 – Achieving 1NF

The original table contains a Products column with multiple comma-separated values, violating 1NF.

You must transform:

OrderID	CustomerName	Products
101	John Doe	Laptop, Mouse
102	Jane Smith	Tablet, Keyboard, Mouse
103	Emily Clark	Phone

Into a structure where each row contains only one product.

The SQL solution in answers.sql:

Splits the multi-valued product column.

Produces one row per product per order.

Question 2 – Achieving 2NF

The table contains a partial dependency:
CustomerName depends only on OrderID, not on the full composite key (OrderID + Product).

You must normalize:

OrderID	CustomerName	Product	Quantity
101	John Doe	Laptop	2
101	John Doe	Mouse	1
102	Jane Smith	Tablet	3
102	Jane Smith	Keyboard	1
102	Jane Smith	Mouse	2
103	Emily Clark	Phone	1

The SQL solution in answers.sql:

Separates customer information into a dedicated Orders table.

Creates a proper OrderItems table holding product and quantity details.

Ensures all non-key attributes depend on the full primary key.

How to Run

Open MySQL Workbench or any SQL environment.

Import or copy the contents of answers.sql.

Run each section of SQL step by step.

Verify that the resulting tables match the normalized structures.

Notes

Queries are written to be readable and easy to modify.

Always test SQL in a clean database/schema to avoid conflicts.

This assignment demonstrates practical normalization processes used in real-world systems.
