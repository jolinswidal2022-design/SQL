create database swee22;
use swee22;
CREATE TABLE Customers2 (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    City VARCHAR(50)
);
CREATE TABLE Orders7 (
Order_id INT PRIMARY KEY,
Customer_id INT,
Order_date DATE,
Order_amount DECIMAL(10,2),
FOREIGN KEY (Customer_id) REFERENCES Customers2(Customer_id)
);
CREATE TABLE Invoices6 (
    Invoice_id INT PRIMARY KEY,
    Order_id INT,
    Invoice_date DATE,
    Invoice_amount DECIMAL(10,2),
    FOREIGN KEY (Order_id) REFERENCES Orders7(Order_id)
);
 CREATE TABLE Payments4 (
 Payment_id INT PRIMARY KEY,
 Invoice_id INT,
 Payment_date DATE,
 Payment_amount DECIMAL(10,2),
 FOREIGN KEY (Invoice_id) REFERENCES Invoices6(Invoice_id)
 );
 CREATE TABLE Ledger0 (
 Ledger_id INT PRIMARY KEY,
 Customer_id INT,
 Transaction_date DATE,
 Debit DECIMAL(10,2),
 Credit DECIMAL(10,2),
 Description VARCHAR(100),
 FOREIGN KEY (Customer_id) REFERENCES Customers2(customer_id)
 );
 select*from Customers2;
 select*from Orders7;
 select*from Invoices6;
 select*from Payments4;
 select*from Ledger0;
 insert into Customers2 values
 (1, 'Asha', 'Bangalore'),
(2, 'Rahul', 'Mangalore'),
(3, 'Meera', 'Mysore'),
(4, 'Arjun', 'Chennai'),
(5, 'Sneha', 'Mumbai');
select*from Customers2;
insert into Orders7 values
(101, 1, '2026-09-01', 1500.00),
(102, 2, '2026-09-02', 2500.00),
(103, 3, '2026-09-03', 1800.00),
(104, 4, '2026-09-04', 3200.00),
(105, 5, '2026-09-05', 2100.00);
select*from Orders7;
insert into Invoices6 values
(1, 101, '2026-09-01', 2500.00),
(2, 102, '2026-09-02', 1800.00),
(3, 103, '2026-09-03', 3200.00),
(4, 104, '2026-09-04', 1500.00),
(5, 105, '2026-09-05', 2750.00);
select*from Invoices6;
insert into Payments4 values
(101, 1, '2026-09-01', 5000.00),
(102, 2, '2026-09-03', 3500.00),
(103, 3, '2026-09-05', 7200.00),
(104, 4, '2026-09-07', 4500.00),
(105, 5, '2026-09-10', 6000.00);
select*from  Payments4;
insert into Ledger0 values
(1, 1, '2026-09-01', 5000.00, 0.00, 'Cash Deposit'),
(2, 2, '2026-09-03', 0.00, 3500.00, 'Office Expense'),
(3, 3, '2026-09-05', 7200.00, 0.00, 'Sales Income'),
(4, 4, '2026-09-07', 0.00, 4500.00, 'Electricity Payment'),
(5, 5, '2026-09-10', 6000.00, 0.00, 'Customer Payment');
select*from Ledger0;
select
	 c.Customer_id,
     c.Customer_name,
     o.Order_id,
     o.Order_amount
from Customers2 c
inner join Orders7 o
on c.Customer_id=o.Customer_id;
select
     c.Customer_id,
     c.Customer_name,
     o.Order_id,
     o.Order_amount
from Customers2 c
left join Orders7 o
on c.Customer_id=o.Customer_id;
select
     c.Customer_id,
     c.Customer_name,
     o.Order_id,
     o.Order_amount
from Customers2 c
right join Orders7 o
on c.Customer_id=o.Customer_id;
SELECT
    c.Customer_id,
    c.Customer_name,
    o.Order_id,
    o.Order_amount,
    i.Invoice_id,
    i.Invoice_amount,
    p.Payment_id,
    p.Payment_amount,
    l.Ledger_id,
    l.Debit,
    l.Credit
FROM Customers2 c
LEFT JOIN Orders7 o
    ON c.Customer_id = o.Customer_id
LEFT JOIN Invoices6 i
    ON o.Order_id = i.Order_id
LEFT JOIN Payments4 p
    ON i.Invoice_id = p.Invoice_id
LEFT JOIN Ledger0 l
    ON c.Customer_id = l.Customer_id;

     

 