use my_sweedal;
CREATE DATABASE Financial_DB;
USE FinancialDB;
CREATE TABLE Customers311 (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE Accounts411 (
    Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Account_Type VARCHAR(30) NOT NULL,
    Balance DECIMAL(15,2) DEFAULT 0,
    Open_Date DATE,
    Status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers311(Customer_ID)
);

CREATE TABLE Transactions511 (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_ID INT NOT NULL,
    Transaction_Type VARCHAR(20) NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    Transaction_Date DATE NOT NULL,
    Description VARCHAR(200),

    FOREIGN KEY (Account_ID)
        REFERENCES Accounts411(Account_ID)
);

CREATE TABLE Employees611 (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(12,2),
    Hire_Date DATE
);

CREATE TABLE Expenses711 (
    Expense_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_ID INT,
    Expense_Type VARCHAR(50),
    Amount DECIMAL(12,2),
    Expense_Date DATE,
    Description VARCHAR(200),

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees611(Employee_ID)
);

CREATE TABLE Revenue811(
    Revenue_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT,
    Revenue_Source VARCHAR(100),
    Amount DECIMAL(12,2),
    Revenue_Date DATE,

    FOREIGN KEY (Customer_ID)
        REFERENCES Customers311(Customer_ID)
);

INSERT INTO Customers311
(Customer_Name, Email, Phone, Address)
VALUES
('Rahul Sharma','rahul@gmail.com','9876543210','Mangalore'),
('Ananya Rao','ananya@gmail.com','9876543211','Bangalore'),
('Arjun Kumar','arjun@gmail.com','9876543212','Mumbai'),
('Sneha Thomas','sneha@gmail.com','9876543213','Kochi'),
('Aisha Khan','aisha@gmail.com','9876543214','Mysore');

INSERT INTO Accounts411
(Customer_ID, Account_Type, Balance, Open_Date)
VALUES
(1,'Savings',50000,'2025-01-10'),
(2,'Current',75000,'2025-02-15'),
(3,'Savings',30000,'2025-03-20'),
(4,'Current',90000,'2025-04-05'),
(5,'Savings',45000,'2025-05-10');

INSERT INTO Transactions511
(Account_ID, Transaction_Type, Amount, Transaction_Date, Description)
VALUES
(1,'Deposit',10000,'2026-01-05','Salary'),
(1,'Withdrawal',3000,'2026-01-10','Shopping'),
(2,'Deposit',25000,'2026-01-12','Business Income'),
(2,'Withdrawal',5000,'2026-01-15','Office Expense'),
(3,'Deposit',15000,'2026-01-18','Salary'),
(4,'Withdrawal',10000,'2026-01-20','Rent'),
(5,'Deposit',20000,'2026-01-25','Business Income');

INSERT INTO Employees611
(Employee_Name, Department, Salary, Hire_Date)
VALUES
('John Mathew','Finance',45000,'2024-01-10'),
('Priya Singh','Sales',40000,'2024-03-15'),
('David Joseph','Finance',50000,'2023-06-20'),
('Meera Nair','HR',42000,'2025-01-05');

INSERT INTO Expenses711
(Employee_ID, Expense_Type, Amount, Expense_Date, Description)
VALUES
(1,'Office',5000,'2026-01-05','Stationery'),
(2,'Travel',3000,'2026-01-10','Business Travel'),
(3,'Office',7000,'2026-01-15','Equipment'),
(4,'Training',4000,'2026-01-20','Employee Training');

INSERT INTO Revenue811
(Customer_ID, Revenue_Source, Amount, Revenue_Date)
VALUES
(1,'Product Sales',50000,'2026-01-05'),
(2,'Service Revenue',75000,'2026-01-10'),
(3,'Product Sales',40000,'2026-01-15'),
(4,'Service Revenue',60000,'2026-01-20'),
(5,'Product Sales',55000,'2026-01-25');

SELECT * FROM Customers311;
SELECT * FROM Accounts411;
SELECT * FROM Transactions511;
SELECT * FROM Employees611;
SELECT * FROM Expenses711;
SELECT * FROM Revenue811;

SELECT *
FROM Customers311
WHERE Address = 'Mangalore';

SELECT *
FROM Accounts411
WHERE Balance > 50000;

SELECT *
FROM Customers311
ORDER BY Customer_Name ASC;

SELECT SUM(Balance) AS Total_Balance
FROM Accounts411;

SELECT MAX(Balance) AS Maximum_Balance
FROM Accounts411;

SELECT SUM(Amount) AS Total_Revenue
FROM Revenue811;

SELECT SUM(Amount) AS Total_Expenses
FROM Expenses711;

SELECT
    c.Customer_ID,
    c.Customer_Name,
    a.Account_ID,
    a.Account_Type,
    a.Balance
FROM Customers311 c
INNER JOIN Accounts411 a
ON c.Customer_ID = a.Customer_ID;

SELECT
    c.Customer_Name,
    a.Account_ID,
    t.Transaction_Type,
    t.Amount,
    t.Transaction_Date
FROM Customers311 c
JOIN Accounts411 a
    ON c.Customer_ID = a.Customer_ID
JOIN Transactions511 t
    ON a.Account_ID = t.Account_ID;
    
    SELECT
    e.Employee_Name,
    e.Department,
    ex.Expense_Type,
    ex.Amount
FROM Employees611 e
JOIN Expenses711 ex
ON e.Employee_ID = ex.Employee_ID;

SELECT
    Account_Type,
    SUM(Balance) AS Total_Balance
FROM Accounts411
GROUP BY Account_Type;

SELECT
    Expense_Type,
    SUM(Amount) AS Total_Expense
FROM Expenses711
GROUP BY Expense_Type;

SELECT
    Revenue_Source,
    SUM(Amount) AS Total_Revenue
FROM Revenue811
GROUP BY Revenue_Source;

SELECT
    Account_Type,
    SUM(Balance) AS Total_Balance
FROM Accounts411
GROUP BY Account_Type
HAVING SUM(Balance) > 50000;

SELECT Customer_Name
FROM Customers311
WHERE Customer_ID IN
(
    SELECT Customer_ID
    FROM Accounts411
    WHERE Balance >
    (
        SELECT AVG(Balance)
        FROM Accounts411
    )
);

SELECT *
FROM Employees611
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees611
);

WITH RevenueSummary AS
(
    SELECT
        Customer_ID,
        SUM(Amount) AS Total_Revenue
    FROM Revenue811
    GROUP BY Customer_ID
)
SELECT
    c.Customer_Name,
    r.Total_Revenue
FROM Customers311 c
JOIN RevenueSummary r
ON c.Customer_ID = r.Customer_ID;

SELECT
    c.Customer_Name,
    SUM(r.Amount) AS Total_Revenue,
    RANK() OVER (
        ORDER BY SUM(r.Amount) DESC
    ) AS Revenue_Rank
FROM Customers311 c
JOIN Revenue811 r
ON c.Customer_ID = r.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name;

SELECT
    Transaction_ID,
    Account_ID,
    Transaction_Date,
    Amount,
    SUM(Amount) OVER (
        PARTITION BY Account_ID
        ORDER BY Transaction_Date
    ) AS Running_Total
FROM Transactions511;

CREATE VIEW CustomerFinancialSummary AS
SELECT
    c.Customer_ID,
    c.Customer_Name,
    a.Account_Type,
    a.Balance
FROM Customers311 c
JOIN Accounts411 a
ON c.Customer_ID = a.Customer_ID;

SELECT *
FROM CustomerFinancialSummary;

CREATE VIEW FinancialReport AS
SELECT
    (SELECT COALESCE(SUM(Amount411),0)
     FROM Revenue811) AS Total_Revenue,

    (SELECT COALESCE(SUM(Amount411),0)
     FROM Expenses6111) AS Total_Expenses,

    (
        (SELECT COALESCE(SUM(Amount411),0)
         FROM Revenue811)
        -
        (SELECT COALESCE(SUM(Amount411),0)
         FROM Expenses6111)
    ) AS Net_Profit;
    
    SELECT *
FROM FinancialReport;

DELIMITER //

CREATE PROCEDURE GetCustomerAccount(IN C_ID INT)
BEGIN

    SELECT
        c.Customer_ID,
        c.Customer_Name,
        a.Account_ID,
        a.Account_Type,
        a.Balance
    FROM Customers311 c
    JOIN Accounts411 a
        ON c.Customer_ID = a.Customer_ID
    WHERE c.Customer_ID = C_ID;

END //

DELIMITER ;

CALL GetCustomerAccount(1);

DELIMITER //

CREATE PROCEDURE AddRevenue(
    IN C_ID INT,
    IN Source_Name VARCHAR(100),
    IN Revenue_Amount DECIMAL(12,2),
    IN R_Date DATE
)
BEGIN

    INSERT INTO Revenue811
    (Customer_ID, Revenue_Source, Amount, Revenue_Date)
    VALUES
    (C_ID, Source_Name, Revenue_Amount, R_Date);

END //

DELIMITER ;

CALL AddRevenue(
    1,
    'Online Sales',
    25000,
    '2026-02-01'
);

DELIMITER //

CREATE TRIGGER AfterDeposit
AFTER INSERT ON Transactions511
FOR EACH ROW
BEGIN

    IF NEW.Transaction_Type = 'Deposit' THEN

        UPDATE Accounts411
        SET Balance = Balance + NEW.Amount
        WHERE Account_ID = NEW.Account_ID;

    END IF;

END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER AfterDeposit
AFTER INSERT ON Transactions511
FOR EACH ROW
BEGIN

    IF NEW.Transaction_Type = 'Deposit' THEN

        UPDATE Accounts411
        SET Balance = Balance + NEW.Amount
        WHERE Account_ID = NEW.Account_ID;

    END IF;

END //

DELIMITER ;

CREATE USER 'financial_reader'@'localhost'
IDENTIFIED BY 'Finance@123';

GRANT SELECT
ON FinancialDB.*
TO 'financial_reader'@'localhost';

CREATE USER 'financial_admin'@'localhost'
IDENTIFIED BY 'Admin@123';

FLUSH PRIVILEGES;

SELECT
    (SELECT SUM(Amount411)
     FROM Revenue811) AS Total_Revenue,

    (SELECT SUM(Amount411)
     FROM Expenses611) AS Total_Expenses,

    (SELECT SUM(Amount411)
     FROM Revenue811)
    -
    (SELECT SUM(Amount411)
     FROM Expenses611) AS Net_Profit,

    (SELECT SUM(Balance)
     FROM Accounts411) AS Total_Assets;
     
     
     SELECT
    Revenue_Source,
    SUM(Amount) AS Total_Revenue
FROM Revenue811
GROUP BY Revenue_Source
ORDER BY Total_Revenue DESC;

SELECT
    Expense_Type,
    COUNT(*) AS Number_of_Expenses,
    SUM(Amount) AS Total_Expense,
    AVG(Amount) AS Average_Expense
FROM Expenses611
GROUP BY Expense_Type;

SELECT
    c.Customer_Name,
    a.Account_Type,
    a.Balance,
    COALESCE(SUM(r.Amount),0) AS Revenue811
FROM Customers311 c
LEFT JOIN Accounts411 a
    ON c.Customer_ID = a.Customer_ID
LEFT JOIN Revenue811 r
    ON c.Customer_ID = r.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    a.Account_Type,
    a.Balance;
    
