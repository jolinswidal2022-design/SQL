CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(200)
);
CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY,
    Account_Name VARCHAR(100),
    Account_Type VARCHAR(50),
    Balance DECIMAL(10,2)
);
CREATE TABLE Ledgers (
    Ledger_ID INT PRIMARY KEY,
    Account_ID INT,
    Ledger_Name VARCHAR(100),
    Opening_Balance DECIMAL(10,2),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Transaction_Date DATE,
    Transaction_Type VARCHAR(50),
    Amount DECIMAL(10,2),
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
);
CREATE TABLE Invoices (
    Invoice_ID INT PRIMARY KEY,
    Customer_ID INT,
    Invoice_Date DATE,
    Total_Amount DECIMAL(10,2),
    Status VARCHAR(30),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Invoice_ID INT,
    Payment_Date DATE,
    Payment_Amount DECIMAL(10,2),
    Payment_Method VARCHAR(50),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoices(Invoice_ID)
);
