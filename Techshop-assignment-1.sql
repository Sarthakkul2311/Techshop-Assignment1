create database TechShop;

use TechShop;

CREATE TABLE Customers (
    CustomerId VARCHAR(3) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(15) NOT NULL,
    LastName VARCHAR(15) NOT NULL,
    email VARCHAR(30),
    Phone VARCHAR(15),
    Address VARCHAR(15)
);
select * from Customers;

create table Products (
	ProductId VARCHAR(3) NOT NULL PRIMARY KEY,
	ProductName varchar(30) not null,
	Description varchar(30),
	Price money
);
select * from Products;

create table orders (
	OrderId int not null primary key,
	CustomerId VARCHAR(3) NOT NULL, 
    OrderDate DATE, 
    TotalAmount MONEY, 
    CONSTRAINT FK_CustomerOrder FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);
select * from orders;

create table OrderDetails(
	OrderDetailId int not null primary key,
	OrderId int not null,
	ProductId VARCHAR(3) NOT NULL,
	Quantity bigint,
    CONSTRAINT FK_order_OrderDetails FOREIGN KEY (OrderId) REFERENCES orders(OrderId),
    CONSTRAINT FK_Product_OrderDetails FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
select * from OrderDetails;

create table Inventory(
	InventoryId int not null primary key,
	ProductId varchar(3) not null,
	QuantityInStock int not null,
	LastStockUpdate Date,
	constraint FK_Product_Inventory Foreign key (ProductId) references Products(ProductId)
);

INSERT INTO Customers (CustomerId, FirstName, LastName, email, Phone, Address) VALUES
('C01', 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm St'),
('C02', 'Jane', 'Smith', 'jane.smith@example.com', '123-555-7891', '456 Oak St'),
('C03', 'Alice', 'Johnson', 'alice.johnson@example.com', '123-555-7892', '789 Pine St'),
('C04', 'Bob', 'Brown', 'bob.brown@example.com', '123-555-7893', '101 Maple St'),
('C05', 'Charlie', 'Davis', 'charlie.davis@example.com', '123-555-7894', '202 Birch St'),
('C06', 'Diana', 'Martinez', 'diana.martinez@example.com', '123-555-7895', '303 Cedar St'),
('C07', 'Eve', 'Wilson', 'eve.wilson@example.com', '123-555-7896', '404 Spruce St'),
('C08', 'Frank', 'Taylor', 'frank.taylor@example.com', '123-555-7897', '505 Fir St'),
('C09', 'Grace', 'Anderson', 'grace.anderson@example.com', '123-555-7898', '606 Redwood St'),
('C10', 'Hannah', 'Thomas', 'hannah.thomas@example.com', '123-555-7899', '707 Willow St');

INSERT INTO Products (ProductId, ProductName, Description, Price) VALUES
('P01', 'Laptop', '15-inch laptop with 16GB RAM', 999.99),
('P02', 'Smartphone', 'Latest with 128GB storage', 699.99),
('P03', 'Headphones', 'Noise-cancelling headphones', 199.99),
('P04', 'Monitor', '24-inch full HD monitor', 149.99),
('P05', 'Keyboard', 'Mechanical keyboard', 89.99),
('P06', 'Mouse', 'Wireless mouse', 49.99),
('P07', 'Printer', 'All-in-one printer', 129.99),
('P08', 'External HDD', '1TB external hard drive', 89.99),
('P09', 'Webcam', 'HD webcam with microphone', 79.99),
('P10', 'USB Drive', '32GB USB flash drive', 19.99);

INSERT INTO orders (OrderId, CustomerId, OrderDate, TotalAmount) VALUES
(101, 'C01', '2024-09-01', 1149.97),
(102, 'C02', '2024-09-02', 799.98),
(103, 'C03', '2024-09-03', 199.99),
(104, 'C04', '2024-09-04', 149.99),
(105, 'C05', '2024-09-05', 89.99),
(106, 'C06', '2024-09-06', 49.99),
(107, 'C07', '2024-09-07', 129.99),
(108, 'C08', '2024-09-08', 89.99),
(109, 'C09', '2024-09-09', 79.99),
(110, 'C10', '2024-09-10', 19.99);

INSERT INTO OrderDetails (OrderDetailId, OrderId, ProductId, Quantity) VALUES
(201, 101, 'P01', 1),
(202, 101, 'P03', 1),
(203, 101, 'P08', 1),
(204, 102, 'P02', 1),
(205, 102, 'P07', 1),
(206, 103, 'P03', 1),
(207, 104, 'P04', 1),
(208, 105, 'P05', 1),
(209, 106, 'P06', 1),
(210, 107, 'P07', 1);

INSERT INTO Inventory (InventoryId, ProductId, QuantityInStock, LastStockUpdate) VALUES
(301, 'P01', 50, '2024-09-01'),
(302, 'P02', 75, '2024-09-02'),
(303, 'P03', 100, '2024-09-03'),
(304, 'P04', 40, '2024-09-04'),
(305, 'P05', 60, '2024-09-05'),
(306, 'P06', 80, '2024-09-06'),
(307, 'P07', 30, '2024-09-07'),
(308, 'P08', 25, '2024-09-08'),
(309, 'P09', 15, '2024-09-09'),
(310, 'P10', 120, '2024-09-10');

Select FirstName, LastName, email
from Customers
order by FirstName;

SELECT o.OrderId, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerId = c.CustomerId;

select * from Customers; 

insert into Customers values('C11','Harry','Potter','harrypotter@example.com','321-456-7809','345 Palm St');

select * from products;

UPDATE Products
SET Price = Price * 1.10;

select * from orders;
select * from OrderDetails;

DECLARE @OrderId INT = 107; 

DELETE FROM OrderDetails
WHERE OrderId = @OrderId;

DELETE FROM orders
WHERE OrderId = @OrderId;


INSERT INTO Customers (CustomerId, FirstName, LastName, email, Phone, Address)
VALUES ('C12', 'John', 'wick', 'john.wick@example.com', '2135468790', '619 Raw St');

insert into orders(OrderId,CustomerId, OrderDate, TotalAmount)
values(112, 'C12', '2024-10-12', 250.75);


declare @custid varchar(3) = 'C01';
update Customers 
set email = 'doe.john@example.com', Address = '123 Mle St'
where CustomerId = @custid;
select * from Customers;

UPDATE orders
SET TotalAmount = (
    SELECT SUM(Products.Price * OrderDetails.Quantity)
    FROM Products, OrderDetails 
	WHERE OrderDetails.ProductID = Products.ProductID   
      AND OrderDetails.OrderID = Orders.OrderID);


DECLARE @CustomerId VARCHAR(3) = 'C08';  
DELETE FROM OrderDetails
WHERE OrderId IN (
    SELECT OrderId
    FROM orders
    WHERE CustomerId = @CustomerId
);
DELETE FROM orders
WHERE CustomerId = @CustomerId;


INSERT INTO Products (ProductId, ProductName, Description, Price)
VALUES ('P12','Camera','Hd camera with 256GB', 899.99);
select * from Products;


ALTER TABLE Customers
ADD NumberOfOrders INT DEFAULT 0;

UPDATE Customers
SET NumberOfOrders = COALESCE(OrderCounts.NumberOfOrders, 0)
FROM Customers
LEFT JOIN (
    SELECT CustomerId, COUNT(*) AS NumberOfOrders
    FROM orders
    GROUP BY CustomerId
) AS OrderCounts
ON Customers.CustomerId = OrderCounts.CustomerId;


------------task 3---------


SELECT 
    orders.OrderId,
    orders.OrderDate,
    orders.TotalAmount,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email,
    Customers.Phone
FROM orders
JOIN Customers ON Orders.CustomerId = Customers.CustomerId;


SELECT 
    Products.ProductName, 
    SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM 
    Products
JOIN 
    OrderDetails ON Products.ProductId = OrderDetails.ProductId
GROUP BY 
    Products.ProductName;


select distinct 
	Customers.FirstName,
	Customers.LastName,
	Customers.Phone
from 
	Customers
join orders on customers.CustomerId = orders.CustomerId;


SELECT 
    Products.ProductName,
    SUM(OrderDetails.Quantity) AS TotalQuantityOrdered
FROM 
    Products
JOIN 
    OrderDetails ON Products.ProductId = OrderDetails.ProductId
GROUP BY 
    Products.ProductName
ORDER BY 
    TotalQuantityOrdered DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY; 

-------------------------------------
--5)
CREATE TABLE Categories (
    CategoryId INT NOT NULL PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

ALTER TABLE Products
ADD CategoryId INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Category_Product 
FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId);

INSERT INTO Categories (CategoryId, CategoryName) VALUES
(1, 'Laptops'),
(2, 'Smartphones'),
(3, 'Accessories'),
(4, 'Printers'),
(5, 'Storage Devices');

UPDATE Products
SET CategoryId = 1 WHERE ProductId = 'P01';  -- Laptop
UPDATE Products
SET CategoryId = 2 WHERE ProductId = 'P02';  -- Smartphone
UPDATE Products
SET CategoryId = 3 WHERE ProductId = 'P03';  -- Headphones
UPDATE Products
SET CategoryId = 3 WHERE ProductId = 'P04';  -- Monitor
UPDATE Products
SET CategoryId = 3 WHERE ProductId = 'P05';  -- Keyboard
UPDATE Products
SET CategoryId = 3 WHERE ProductId = 'P06';  -- Mouse
UPDATE Products
SET CategoryId = 4 WHERE ProductId = 'P07';  -- Printer
UPDATE Products
SET CategoryId = 5 WHERE ProductId = 'P08';  -- External HDD
UPDATE Products
SET CategoryId = 3 WHERE ProductId = 'P09';  -- Webcam
UPDATE Products
SET CategoryId = 5 WHERE ProductId = 'P10';  -- USB Drive

SELECT 
    Products.ProductName, 
    Categories.CategoryName
FROM 
    Products
JOIN 
    Categories ON Products.CategoryId = Categories.CategoryId;

--6)
SELECT 
    Customers.FirstName, 
    Customers.LastName, 
    AVG(Orders.TotalAmount) AS AverageOrderValue
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerId = Orders.CustomerId
GROUP BY 
    Customers.FirstName, 
    Customers.LastName;

--7)

SELECT 
    orders.OrderId,
    orders.TotalAmount AS TotalRevenue,
    Customers.FirstName,
    Customers.LastName,
    Customers.email,
    Customers.Phone
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerId = Customers.CustomerId
ORDER BY 
    orders.TotalAmount DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

--8)
select
	Products.ProductName,
	count(OrderDetails.OrderId) as 'Times Ordered'
from 
	Products
join 
	OrderDetails on Products.ProductId = OrderDetails.ProductId
group by 
	Products.ProductName
order by 
	'Times Ordered' desc;

--9)
declare @Productname varchar(15) = 'Headphones';

select 
	Customers.FirstName,
	Customers.LastName,
	Customers.email,
	Customers.Phone
from 
	Customers
join 
	orders on Customers.CustomerId = orders.CustomerId
join 
	OrderDetails on orders.OrderId = OrderDetails.OrderId
join 
	Products on OrderDetails.ProductId = Products.ProductId
where
	Products.ProductName = @Productname;

--10)
declare @start date = '2024-09-01';
declare @end date = '2024-09-30';

select 
	sum(TotalAmount) as Total_Revenue
from 
	orders
where 
	OrderDate between @start and @end;

---------------------Task 4---------------
--1)
SELECT 
    Customers.CustomerId,
    Customers.FirstName,
    Customers.LastName,
    Customers.Email
FROM 
    Customers
Left JOIN 
    orders ON Customers.CustomerId = orders.CustomerId
WHERE 
    orders.OrderId IS NULL;

--2)
select count(*) as 'Available Products' from products 
join 
	Inventory on Products.ProductId = Inventory.ProductId
where Inventory.QuantityInStock >= 1 ;

--3)

select sum(TotalAmount) as 'Total Revenue'
from orders;

--4)
DECLARE @CategoryName VARCHAR(15) = 'Printers';  

SELECT 
    AVG(od.Quantity) AS AverageQuantityOrdered
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductId = p.ProductId
JOIN 
    Categories c ON p.CategoryId = c.CategoryId
WHERE 
    c.CategoryName = @CategoryName;

--5)
DECLARE @CustomerId VARCHAR(3) = 'C01'; 

SELECT 
    SUM(o.TotalAmount) AS TotalRevenue
FROM 
    orders o
WHERE 
    o.CustomerId = @CustomerId;

--6)
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderId) AS 'Number Of Orders'
FROM 
    Customers c
JOIN 
    orders o ON c.CustomerId = o.CustomerId
GROUP BY 
    c.FirstName, c.LastName
ORDER BY 
    'Number Of Orders' DESC;

--7)
SELECT 
    c.CategoryName, 
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductId = p.ProductId
JOIN 
    Categories c ON p.CategoryId = c.CategoryId
GROUP BY 
    c.CategoryName
ORDER BY 
    TotalQuantityOrdered DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY; -- For SQL Server

--8)
SELECT 
    c.FirstName, 
    c.LastName, 
    SUM(o.TotalAmount) AS TotalSpending
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerId = o.CustomerId
JOIN 
    OrderDetails od ON o.OrderId = od.OrderId
JOIN 
    Products p ON od.ProductId = p.ProductId
GROUP BY 
    c.CustomerId, c.FirstName, c.LastName
ORDER BY 
    TotalSpending DESC
OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY; 

--9)
SELECT 
    AVG(TotalRevenue) AS AverageOrderValue
FROM (
    SELECT 
        c.CustomerId,
        SUM(o.TotalAmount) AS TotalRevenue
    FROM 
        Customers c
    LEFT JOIN 
        Orders o ON c.CustomerId = o.CustomerId
    GROUP BY 
        c.CustomerId
) AS CustomerTotals;

--10)
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderId) AS TotalOrders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerId = o.CustomerId
GROUP BY 
    c.FirstName, c.LastName;
