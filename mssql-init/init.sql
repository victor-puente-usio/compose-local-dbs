
CREATE DATABASE SampleDB;
GO
USE SampleDB;
GO

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    City NVARCHAR(50)
);
GO

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);
GO

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    OrderDate DATETIME
);
GO

-- Insert 50 Customers
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Customers (Name, Email, City)
    VALUES (
        CONCAT('Customer', @i),
        CONCAT('customer', @i, '@example.com'),
        CASE WHEN @i % 3 = 0 THEN 'Austin'
             WHEN @i % 3 = 1 THEN 'Dallas'
             ELSE 'Houston' END
    );
    SET @i = @i + 1;
END
GO

-- Insert 20 Products
DECLARE @j INT = 1;
WHILE @j <= 20
BEGIN
    INSERT INTO Products (ProductName, Price, Stock)
    VALUES (
        CONCAT('Product', @j),
        CAST(ROUND(RAND() * (500 - 50) + 50, 2) AS DECIMAL(10,2)),
        CAST(RAND() * 200 AS INT)
    );
    SET @j = @j + 1;
END
GO

-- Insert 100 Orders
DECLARE @k INT = 1;
WHILE @k <= 100
BEGIN
    INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate)
    VALUES (
        CAST(RAND() * 50 + 1 AS INT),
        CAST(RAND() * 20 + 1 AS INT),
        CAST(RAND() * 5 + 1 AS INT),
        DATEADD(DAY, -CAST(RAND() * 365 AS INT), GETDATE())
    );
    SET @k = @k + 1;
END
GO
