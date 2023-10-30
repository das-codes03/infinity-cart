# infinity-cart
DBMS project
This project is based on the e-commerce platform and is a simple demonstration of standard functions that can be performed. 

# NORMALIZATION OF DATA
The data in table is normalised till 3NF . Lets delve deep into normalization
## normalization 
Normalization is a process in database design that aims to organize data in a way that reduces redundancy and dependency. It involves breaking down a large table into smaller, related tables, and establishing relationships between them. The goal of normalization is to minimize data redundancy, improve data integrity, and make it easier to maintain and query the database.

## FORMS OF NORMALIZATION
### First Normal Form (1NF):
A table is in 1NF if it meets the following conditions:
1) It has a primary key (a unique identifier for each record).
2) All columns hold atomic values (indivisible values).
3) There are no repeating groups or arrays.

## Second Normal Form (2NF):
A table is in 2NF if it is in 1NF and every non-key column is fully functionally dependent on the entire primary key, not just part of it.

##Third Normal Form (3NF):
A table is in 3NF if it is in 2NF and there are no transitive dependencies (i.e., no non-key column is functionally dependent on another non-key column).
