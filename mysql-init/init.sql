
USE testdb;

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert 50 Customers
SET @i = 1;
WHILE @i <= 50 DO
    INSERT INTO Customers (Name, Email, City)
    VALUES (
        CONCAT('Customer', @i),
        CONCAT('customer', @i, '@example.com'),
        CASE WHEN MOD(@i,3)=0 THEN 'Austin'
             WHEN MOD(@i,3)=1 THEN 'Dallas'
             ELSE 'Houston' END
    );
    SET @i = @i + 1;
END WHILE;

-- Insert 20 Products
SET @j = 1;
WHILE @j <= 20 DO
    INSERT INTO Products (ProductName, Price, Stock)
    VALUES (
        CONCAT('Product', @j),
        ROUND(RAND() * (500 - 50) + 50, 2),
        FLOOR(RAND() * 200)
    );
    SET @j = @j + 1;
END WHILE;

-- Insert 100 Orders
SET @k = 1;
WHILE @k <= 100 DO
    INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate)
    VALUES (
        FLOOR(RAND() * 50 + 1),
        FLOOR(RAND() * 20 + 1),
        FLOOR(RAND() * 5 + 1),
        DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
    );
    SET @k = @k + 1;
END WHILE;
