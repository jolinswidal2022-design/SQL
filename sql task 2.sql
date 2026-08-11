CREATE DATABASE FinancialDB;
USE FinancialDB;
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);
CREATE TABLE Accounts (
    Account_ID INT PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Account_Type VARCHAR(30) NOT NULL,
    Balance DECIMAL(12,2) NOT NULL,
    
    CONSTRAINT fk_customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID),
        
    CONSTRAINT chk_balance
        CHECK (Balance >= 0)
);
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT NOT NULL,
    Transaction_Date DATE NOT NULL,
    Transaction_Type VARCHAR(10) NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    
    CONSTRAINT fk_account
        FOREIGN KEY (Account_ID)
        REFERENCES Accounts(Account_ID),
        
    CONSTRAINT chk_amount
        CHECK (Amount >= 0),
        
    CONSTRAINT chk_transaction_type
        CHECK (Transaction_Type IN ('Credit', 'Debit'))
);
ALTER TABLE Customers
ADD Address VARCHAR(200);
ALTER TABLE Customers
MODIFY Phone VARCHAR(20);
CREATE TABLE Test_Table (
    Test_ID INT PRIMARY KEY,
    Test_Name VARCHAR(50)
);
DROP TABLE Test_Table;
select * from customer;
select * from customer;
select * from customer;





