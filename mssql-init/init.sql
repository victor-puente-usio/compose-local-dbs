
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
DELIMITER $$

CREATE PROCEDURE init_data()    
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1; 
    DECLARE k INT DEFAULT 1;    

WHILE i <= 50 DO 
    INSERT INTO Customers
    (Name,Email, City)
    VALUES(
        CONCAT("Customer", i),
        CONCAT("custoomer", i), 
    CREATE DATABASE testdb;
    GO

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

    -- Populate data using a T-SQL stored procedure
    CREATE PROCEDURE init_data
    AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @i INT = 1;
        DECLARE @j INT = 1;
        DECLARE @k INT = 1;

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

        WHILE @j <= 20
        BEGIN
            INSERT INTO Products (ProductName, Price, Stock)
            VALUES (
                CONCAT('Product', @j),
                CAST(50.00 + (ABS(CHECKSUM(NEWID())) % 451) + (ABS(CHECKSUM(NEWID())) % 100) / 100.0 AS DECIMAL(10,2)),
                ABS(CHECKSUM(NEWID())) % 200
            );
            SET @j = @j + 1;
        END

        WHILE @k <= 100
        BEGIN
            INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate)
            VALUES (
                (ABS(CHECKSUM(NEWID())) % 50) + 1,
                (ABS(CHECKSUM(NEWID())) % 20) + 1,
                (ABS(CHECKSUM(NEWID())) % 5) + 1,
                DATEADD(day, - (ABS(CHECKSUM(NEWID())) % 365), GETDATE())
            );
            SET @k = @k + 1;
        END
    END
    GO

    EXEC init_data;
    GO

    DROP PROCEDURE init_data;
    GO

