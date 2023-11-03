-- Drop tables if they exist
DROP TABLE IF EXISTS CreditCardAuthorizations;
DROP TABLE IF EXISTS OrderShipping;
DROP TABLE IF EXISTS ShippingCharges;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- Table to store customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    ShipingAddress TEXT,
    CreditCardNumber VARCHAR(16), -- Store as encrypted/hashed data for security
    ExpirationDate DATE
);

-- Table to store product information
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    PartNumber VARCHAR(50) UNIQUE,
    Description TEXT,
    Weight DECIMAL(8, 2),
    Price DECIMAL(8, 2)
);

-- Table to store customer orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATETIME,
    TotalPrice DECIMAL(10, 2),
    Status ENUM('Pending', 'Authorized', 'Shipped', 'Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table to store order items
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table to store inventory information
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    QuantityOnHand INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Table to store shipping and handling charges
CREATE TABLE ShippingCharges (
    WeightBracket INT PRIMARY KEY AUTO_INCREMENT,
    MinWeight DECIMAL(8, 2),
    MaxWeight DECIMAL(8, 2),
    Charge DECIMAL(8, 2)
);

-- Table to store order shipping details
CREATE TABLE OrderShipping (
    OrderShippingID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Weight DECIMAL(8, 2),
    ShippingCharge DECIMAL(8, 2),
    ShippingLabel TEXT,
    Invoice TEXT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Table to store credit card authorizations
CREATE TABLE CreditCardAuthorizations (
    AuthorizationID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    AuthorizationNumber VARCHAR(255),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

