create database shreedairy;
use shreedairy;
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Admin', 'Customer', 'Farmer', 'Staff') NOT NULL,
    Contact VARCHAR(15),
    OTPVerified BOOLEAN DEFAULT FALSE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
CREATE TABLE Dairies (
    DairyID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address TEXT,
    Contact VARCHAR(15)
);
CREATE TABLE Farmers (
    FarmerID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Name VARCHAR(100),
    Contact VARCHAR(15),
    Address TEXT,
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
CREATE TABLE MilkCollections (
    CollectionID INT AUTO_INCREMENT PRIMARY KEY,
    FarmerID INT,
    Date DATE,
    Session ENUM('Morning', 'Evening'),
    Quantity DECIMAL(6,2),
    FatPercentage DECIMAL(4,2),
    SNF DECIMAL(4,2),
    PricePerFatUnit DECIMAL(6,2),
    EnteredBy INT,
    FOREIGN KEY (FarmerID) REFERENCES Farmers(FarmerID),
    FOREIGN KEY (EnteredBy) REFERENCES Users(UserID)
);
CREATE TABLE FarmerPayments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    FarmerID INT,
    StartDate DATE,
    EndDate DATE,
    TotalMilkSupplied DECIMAL(10,2),
    PaymentStatus ENUM('Pending', 'Paid'),
    GeneratedBy INT,
    FOREIGN KEY (FarmerID) REFERENCES Farmers(FarmerID),
    FOREIGN KEY (GeneratedBy) REFERENCES Users(UserID)
);
CREATE TABLE MilkStorage (
    StorageID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Date DATE,
    MorningCollection DECIMAL(8,2),
    EveningCollection DECIMAL(8,2),
    TotalStored DECIMAL(10,2),
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Name VARCHAR(100),
    Contact VARCHAR(15),
    Address TEXT,
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
CREATE TABLE MilkSales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Date DATE,
    QuantityPurchased DECIMAL(6,2),
    RatePerLiter DECIMAL(6,2),
    TotalAmount DECIMAL(8,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE CustomerPayments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Month YEAR,
    TotalAmount DECIMAL(10,2),
    PaymentStatus ENUM('Pending', 'Paid'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE MilkDeliveries (
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    SaleID INT,
    DeliveryDate DATE,
    Status ENUM('Delivered', 'Pending', 'Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SaleID) REFERENCES MilkSales(SaleID)
);
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Contact VARCHAR(15),
    Salary DECIMAL(10,2),
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
CREATE TABLE Expenses (
    ExpenseID INT AUTO_INCREMENT PRIMARY KEY,
    DairyID INT,
    Date DATE,
    ExpenseType VARCHAR(50),
    Amount DECIMAL(10,2),
    Description TEXT,
    FOREIGN KEY (DairyID) REFERENCES Dairies(DairyID)
);
INSERT INTO Users (UserID, DairyID, Username, PasswordHash, Role, Contact, OTPVerified, CreatedAt)
VALUES
(1, 1, 'admin.singh', 'a7f9b99edcf97a62c3fd4321d0f4f7ee', 'Admin', '9812345670', TRUE, '2025-04-01 08:45:00'),
(2, 1, 'farmer.ramesh', 'c09a55b1f5c842db8f1a1a8d99f87643', 'Farmer', '9823456781', TRUE, '2025-04-01 09:00:00'),
(3, 1, 'staff.meena', 'e0b9f7f7a2845b3b6fa321a75bdc41fc', 'Staff', '9834567892', TRUE, '2025-04-02 08:30:00'),
(4, 1, 'customer.nisha', 'b8d7c2fe83a56b9c0c6e9aa1bdc12e7f', 'Customer', '9845678903', FALSE, '2025-04-03 10:10:00'),
(5, 2, 'admin.patel', 'd1e43a8c8d7ff53c95f6e7c1b123a4be', 'Admin', '9856789014', TRUE, '2025-04-01 08:00:00'),
(6, 2, 'farmer.santosh', 'f4e2b1caa87e61a3c3a2dfbcf739c321', 'Farmer', '9867890125', TRUE, '2025-04-01 08:50:00'),
(7, 2, 'staff.deepa', 'e9bfc1299fc8a1f57322a7b8b1c7aa98', 'Staff', '9878901236', FALSE, '2025-04-02 09:30:00'),
(8, 2, 'customer.vikas', 'c3d7aa9fb76dd1d6bc8d09a87a34ee9c', 'Customer', '9889012347', TRUE, '2025-04-03 07:45:00'),
(9, 3, 'admin.sharma', 'aad2c8a5c97ed229d3f11f1a612b0aa1', 'Admin', '9890123458', TRUE, '2025-04-01 07:55:00'),
(10, 3, 'customer.kiran', 'b4aa7e65a3f71c8f11cb63bbd4f66dcd', 'Customer', '9901234569', FALSE, '2025-04-03 08:15:00');

INSERT INTO Dairies (DairyID, Name, Address, Contact)
VALUES
(1, 'Shree Krishna Dairy', 'M.G. Road, Indore, Madhya Pradesh', '07314001234'),
(2, 'Amrit Dairy Farm', 'Bada Bazar, Ujjain, Madhya Pradesh', '07342506789'),
(3, 'Saraswati Milk Center', 'VIP Road, Bhopal, Madhya Pradesh', '07552503321'),
(4, 'Gokul Milk Dairy', 'Civil Lines, Jabalpur, Madhya Pradesh', '07612607890'),
(5, 'Kamdhenu Dairy Services', 'Jawahar Marg, Ratlam, Madhya Pradesh', '07412204567'),
(6, 'Annapurna Dairy Farm', 'Lashkar, Gwalior, Madhya Pradesh', '07512405678'),
(7, 'Shivam Dairy', 'Bhanwarkuan, Indore, Madhya Pradesh', '07314007654'),
(8, 'Mangal Dairy', 'Main Market, Dewas, Madhya Pradesh', '07272407891'),
(9, 'Patanjali Milk Point', 'Kotwali Road, Hoshangabad, Madhya Pradesh', '07574203089'),
(10, 'Rajasthan Dairy Products', 'New Market, Bhopal, Madhya Pradesh', '07552204567');
INSERT INTO Farmers (FarmerID, DairyID, Name, Contact, Address)
VALUES
(1, 1, 'Ramesh Choudhary', '9823012345', 'Village Palda, Indore, Madhya Pradesh'),
(2, 1, 'Mahesh Patel', '9823023456', 'Village Rau, Indore, Madhya Pradesh'),
(3, 2, 'Santosh Verma', '9823034567', 'Village Unhel, Ujjain, Madhya Pradesh'),
(4, 2, 'Devraj Meena', '9823045678', 'Village Tarana, Ujjain, Madhya Pradesh'),
(5, 3, 'Ganesh Ahirwar', '9823056789', 'Village Kolar, Bhopal, Madhya Pradesh'),
(6, 4, 'Kailash Yadav', '9823067890', 'Village Kundam, Jabalpur, Madhya Pradesh'),
(7, 5, 'Narayan Singh', '9823078901', 'Village Jaora, Ratlam, Madhya Pradesh'),
(8, 6, 'Bhagwan Das', '9823089012', 'Village Dabra, Gwalior, Madhya Pradesh'),
(9, 7, 'Mukesh Prajapati', '9823090123', 'Village Sanwer, Indore, Madhya Pradesh'),
(10, 8, 'Virendra Tomar', '9823101234', 'Village Hatpipliya, Dewas, Madhya Pradesh');
INSERT INTO MilkCollections (CollectionID, FarmerID, Date, Session, Quantity, FatPercentage, SNF, PricePerFatUnit, EnteredBy)
VALUES
(1, 1, '2025-04-01', 'Morning', 12.50, 4.2, 8.5, 7.5, 3),
(2, 2, '2025-04-01', 'Evening', 10.00, 4.5, 8.3, 7.5, 3),
(3, 3, '2025-04-01', 'Morning', 14.00, 3.8, 8.0, 7.0, 6),
(4, 4, '2025-04-01', 'Evening', 11.20, 4.1, 8.6, 7.2, 6),
(5, 5, '2025-04-01', 'Morning', 13.75, 4.0, 8.4, 7.4, 1),
(6, 6, '2025-04-01', 'Evening', 12.60, 3.9, 8.2, 7.1, 1),
(7, 7, '2025-04-01', 'Morning', 9.80, 4.3, 8.5, 7.6, 1),
(8, 8, '2025-04-01', 'Evening', 11.90, 4.0, 8.4, 7.3, 7),
(9, 9, '2025-04-01', 'Morning', 10.50, 4.4, 8.6, 7.8, 7),
(10, 10, '2025-04-01', 'Evening', 13.00, 4.1, 8.7, 7.7, 7);

INSERT INTO FarmerPayments (PaymentID, FarmerID, StartDate, EndDate, TotalMilkSupplied, PaymentStatus, GeneratedBy)
VALUES
(1, 1, '2025-03-21', '2025-03-30', 125.50, 'Paid', 1),
(2, 2, '2025-03-21', '2025-03-30', 112.75, 'Paid', 3),
(3, 3, '2025-03-21', '2025-03-30', 132.40, 'Pending', 5),
(4, 4, '2025-03-21', '2025-03-30', 119.60, 'Paid', 6),
(5, 5, '2025-03-21', '2025-03-30', 143.00, 'Pending', 1),
(6, 6, '2025-03-21', '2025-03-30', 110.20, 'Paid', 1),
(7, 7, '2025-03-21', '2025-03-30', 104.90, 'Paid', 1),
(8, 8, '2025-03-21', '2025-03-30', 120.30, 'Pending', 7),
(9, 9, '2025-03-21', '2025-03-30', 117.40, 'Paid', 7),
(10, 10, '2025-03-21', '2025-03-30', 135.00, 'Pending', 7);

INSERT INTO MilkStorage (StorageID, DairyID, Date, MorningCollection, EveningCollection, TotalStored)
VALUES
(1, 1, '2025-03-21', 150.25, 170.40, 320.65),
(2, 1, '2025-03-22', 140.10, 160.35, 300.45),
(3, 1, '2025-03-23', 155.60, 162.80, 318.40),
(4, 2, '2025-03-21', 120.00, 130.55, 250.55),
(5, 2, '2025-03-22', 125.30, 132.60, 257.90),
(6, 2, '2025-03-23', 130.10, 140.75, 270.85),
(7, 3, '2025-03-21', 110.40, 115.80, 226.20),
(8, 3, '2025-03-22', 112.75, 117.65, 230.40),
(9, 3, '2025-03-23', 115.00, 119.00, 234.00),
(10, 1, '2025-03-24', 160.00, 165.50, 325.50);
INSERT INTO Customers (CustomerID, DairyID, Name, Contact, Address)
VALUES
(1, 1, 'Nisha Verma', '9845678903', 'MG Road, Indore, Madhya Pradesh'),
(2, 1, 'Ravi Deshmukh', '9871234560', 'Vijay Nagar, Indore, Madhya Pradesh'),
(3, 1, 'Suman Joshi', '9823456712', 'Palasia, Indore, Madhya Pradesh'),
(4, 2, 'Vikas Patil', '9889012347', 'Alkapuri, Vadodara, Gujarat'),
(5, 2, 'Meena Shah', '9834567890', 'Ellora Park, Vadodara, Gujarat'),
(6, 2, 'Ankit Trivedi', '9811122233', 'Gotri Road, Vadodara, Gujarat'),
(7, 3, 'Kiran Mehta', '9901234569', 'Baner Road, Pune, Maharashtra'),
(8, 3, 'Rohit Pawar', '9912233445', 'Kothrud, Pune, Maharashtra'),
(9, 3, 'Sneha Kulkarni', '9923344556', 'Deccan, Pune, Maharashtra'),
(10, 1, 'Rahul Jain', '9934455667', 'Rajwada, Indore, Madhya Pradesh');
INSERT INTO MilkSales (SaleID, CustomerID, Date, QuantityPurchased, RatePerLiter, TotalAmount)
VALUES
(1, 1, '2025-04-01', 10.00, 50.00, 500.00),
(2, 2, '2025-04-01', 8.50, 50.00, 425.00),
(3, 3, '2025-04-01', 12.00, 48.00, 576.00),
(4, 4, '2025-04-01', 9.00, 49.00, 441.00),
(5, 5, '2025-04-01', 7.50, 50.00, 375.00),
(6, 6, '2025-04-01', 10.50, 48.00, 504.00),
(7, 7, '2025-04-01', 11.00, 47.00, 517.00),
(8, 8, '2025-04-01', 8.00, 49.00, 392.00),
(9, 9, '2025-04-01', 9.50, 50.00, 475.00),
(10, 10, '2025-04-01', 10.00, 50.00, 500.00);
INSERT INTO CustomerPayments (PaymentID, CustomerID, Month, TotalAmount, PaymentStatus)
VALUES
(1, 1, 2025, 4500.00, 'Paid'),
(2, 2, 2025, 4200.00, 'Paid'),
(3, 3, 2025, 4700.00, 'Pending'),
(4, 4, 2025, 4100.00, 'Paid'),
(5, 5, 2025, 3900.00, 'Pending'),
(6, 6, 2025, 4600.00, 'Paid'),
(7, 7, 2025, 4800.00, 'Paid'),
(8, 8, 2025, 4000.00, 'Pending'),
(9, 9, 2025, 4300.00, 'Paid'),
(10, 10, 2025, 4450.00, 'Paid');
INSERT INTO MilkDeliveries (DeliveryID, CustomerID, SaleID, DeliveryDate, Status)
VALUES
(1, 1, 1, '2025-04-01', 'Delivered'),
(2, 2, 2, '2025-04-01', 'Delivered'),
(3, 3, 3, '2025-04-02', 'Pending'),
(4, 4, 4, '2025-04-02', 'Delivered'),
(5, 5, 5, '2025-04-03', 'Cancelled'),
(6, 6, 6, '2025-04-03', 'Delivered'),
(7, 7, 7, '2025-04-04', 'Pending'),
(8, 8, 8, '2025-04-04', 'Delivered'),
(9, 9, 9, '2025-04-05', 'Delivered'),
(10, 10, 10, '2025-04-05', 'Cancelled');
INSERT INTO Employees (EmployeeID, DairyID, Name, Role, Contact, Salary)
VALUES
(1, 1, 'Suresh Yadav', 'Delivery Staff', '9876543201', 18500.00),
(2, 1, 'Meena Kumari', 'Quality Checker', '9876543202', 20500.00),
(3, 1, 'Amit Verma', 'Clerk', '9876543203', 18000.00),
(4, 2, 'Pooja Patel', 'Delivery Staff', '9876543204', 19000.00),
(5, 2, 'Ravi Deshmukh', 'Store Manager', '9876543205', 26000.00),
(6, 2, 'Kiran Joshi', 'Helper', '9876543206', 16000.00),
(7, 3, 'Deepak Sharma', 'Delivery Staff', '9876543207', 18800.00),
(8, 3, 'Anjali Mehta', 'Accountant', '9876543208', 24000.00),
(9, 3, 'Nilesh Bhatt', 'Cleaning Staff', '9876543209', 15000.00),
(10, 3, 'Ritika Jain', 'Quality Supervisor', '9876543210', 22000.00);

INSERT INTO Expenses (ExpenseID, DairyID, Date, ExpenseType, Amount, Description)
VALUES
(1, 1, '2025-04-01', 'Electricity Bill', 5200.00, 'Monthly electricity usage for cooling units'),
(2, 1, '2025-04-03', 'Fuel', 2300.50, 'Fuel used for delivery vans'),
(3, 1, '2025-04-04', 'Maintenance', 3000.00, 'Repair of pasteurization machine'),
(4, 2, '2025-04-01', 'Packaging', 1800.00, 'Plastic milk packet rolls'),
(5, 2, '2025-04-02', 'Water Bill', 950.75, 'Water usage charges for cleaning equipment'),
(6, 2, '2025-04-03', 'Veterinary Services', 4000.00, 'Routine check-up for dairy cows'),
(7, 3, '2025-04-01', 'Lab Testing', 2100.00, 'Milk quality lab tests'),
(8, 3, '2025-04-03', 'Office Supplies', 780.00, 'Printer ink, files, and registers'),
(9, 3, '2025-04-04', 'Internet Charges', 1200.00, 'Monthly broadband bill'),
(10, 1, '2025-04-05', 'Wages', 15000.00, 'Weekly payout to temporary labor');
SELECT * FROM Users WHERE OTPVerified = TRUE;
SELECT * FROM Dairies WHERE Address LIKE '%Madhya Pradesh%';
SELECT * FROM MilkCollections WHERE Session = 'Morning';
SELECT f.* 
FROM Farmers f
JOIN Dairies d ON f.DairyID = d.DairyID
WHERE d.Name = 'Shree Dairy - Indore';
SELECT * FROM MilkSales WHERE TotalAmount > 100;
SELECT * FROM CustomerPayments WHERE PaymentStatus = 'Pending';
SELECT * FROM Employees WHERE Salary > 12000;
SELECT * FROM MilkDeliveries WHERE Status = 'Cancelled';
SELECT * FROM Expenses WHERE ExpenseType = 'Packaging';
SELECT * FROM MilkCollections WHERE Date = '2025-04-02';
SELECT FarmerID, SUM(Quantity) AS TotalMilk
FROM MilkCollections
GROUP BY FarmerID;
SELECT CustomerID, SUM(TotalAmount) AS TotalPurchase
FROM MilkSales
GROUP BY CustomerID;
SELECT DairyID, COUNT(*) AS FarmerCount
FROM Farmers
GROUP BY DairyID;
SELECT Date, SUM(TotalStored) AS TotalStored
FROM MilkStorage
GROUP BY Date;
SELECT FarmerID, SUM(Quantity) AS TotalMilk
FROM MilkCollections
GROUP BY FarmerID
ORDER BY TotalMilk DESC
LIMIT 3;
SELECT ExpenseType, SUM(Amount) AS TotalSpent
FROM Expenses
GROUP BY ExpenseType;
SELECT Month, SUM(TotalAmount) AS Income
FROM CustomerPayments
GROUP BY Month;
SELECT FarmerID, AVG(FatPercentage) AS AvgFat
FROM MilkCollections
GROUP BY FarmerID;
SELECT Role, COUNT(*) AS UserCount
FROM Users
GROUP BY Role;
SELECT DeliveryDate, Status, COUNT(*) AS Count
FROM MilkDeliveries
GROUP BY DeliveryDate, Status;
SELECT m.Date, m.Quantity, f.Name AS Farmer, u.Username AS EnteredBy
FROM MilkCollections m
JOIN Farmers f ON m.FarmerID = f.FarmerID
JOIN Users u ON m.EnteredBy = u.UserID;
SELECT cp.*, c.Name
FROM CustomerPayments cp
JOIN Customers c ON cp.CustomerID = c.CustomerID;
SELECT e.*
FROM Employees e
JOIN Dairies d ON e.DairyID = d.DairyID
WHERE d.Name = 'Amul Dairy - Bhopal';
SELECT d.DeliveryDate, d.Status, s.TotalAmount, c.Name
FROM MilkDeliveries d
JOIN MilkSales s ON d.SaleID = s.SaleID
JOIN Customers c ON d.CustomerID = c.CustomerID;
SELECT p.*, f.Name
FROM FarmerPayments p
JOIN Farmers f ON p.FarmerID = f.FarmerID;
SELECT u.Username, u.Role, d.Name AS DairyName
FROM Users u
JOIN Dairies d ON u.DairyID = d.DairyID;
SELECT DISTINCT c.Name
FROM MilkSales m
JOIN Customers c ON m.CustomerID = c.CustomerID
WHERE m.QuantityPurchased > 5;
SELECT d.Name, s.Date, s.TotalStored
FROM MilkStorage s
JOIN Dairies d ON s.DairyID = d.DairyID;
SELECT e.*
FROM Expenses e
JOIN Dairies d ON e.DairyID = d.DairyID
WHERE d.Name = 'Shree Krishna Dairy';
SELECT DISTINCT u.Username
FROM MilkCollections m
JOIN Users u ON m.EnteredBy = u.UserID;