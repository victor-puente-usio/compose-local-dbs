
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
    CASE WHEN MOD(i,3)=0 THEN "Austin"
         WHEN MOD(i,3)=1 THEN "Dallas"
         ELSE "Houston" END
    );

    SET i = i + 1;
END WHILE 



-- Insert 20 Products

  WHILE j <= 20 DO
    INSERT INTO Products (ProductName, Price, Stock)
    VALUES (
      CONCAT('Product', j),
      ROUND(RAND() * (500 - 50) + 50, 2),
      FLOOR(RAND() * 200)
    );
    SET j = j + 1;
  END WHILE;

-- Insert 100 Orders
WHILE k <= 100 DO
    INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate)
    VALUES (
    FLOOR(RAND() * 50 + 1),
    FLOOR(RAND() * 20 + 1),
    FLOOR(RAND() * 5 + 1),
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
    );
    SET k = k + 1;
END WHILE;
END$$

CALL init_data()$$
DROP PROCEDURE IF EXISTS init_data$$
DELIMITER ;

