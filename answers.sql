-- Question 1:
--Creating Tables
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(100)
);

-- adding data to the tables

INSERT INTO ProductDetail(OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- trnsforming this table into 1NF

SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n
  ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;



--Question 2

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,  -- OrderID is the primary key, uniquely identifying each order
    CustomerName VARCHAR(100) 
);

 --Inserting data into the table

INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),       
    (102, 'Jane Smith'),     
    (103, 'Emily Clark');     


CREATE TABLE Product (
    OrderID INT,          -- OrderID is a foreign key, referencing the Orders table
    Product VARCHAR(100),    
    Quantity INT,         
    PRIMARY KEY (OrderID, Product), -- Composite primary key: OrderID and Product together
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) 
);

INSERT INTO Product (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),    
    (101, 'Mouse', 1),     
    (102, 'Tablet', 3),   
    (102, 'Keyboard', 1), 
    (102, 'Mouse', 2),     
    (103, 'Phone', 1);      
