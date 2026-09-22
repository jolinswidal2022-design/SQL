use financialdb;
CREATE TABLE Customer_1(
      customer_id INT PRIMARY KEY,
      customer_name VARCHAR(100),
      phone_number bigint
);
INSERT INTO Customer_1 VALUES
(1,'rakesh',2345678901),
(2,'sujatha',1234567890),
(3,'shiya',0987654321);
SELECT*FROM Customer_1;
CREATE TABLE Invoice_1 (
     invoice_id INT PRIMARY KEY,
     customer_id INT,
     invoice_amount INT,
     due_date DATE,
     FOREIGN KEY (customer_id)
        references customer_1(customer_id));
SELECT * FROM Customer_1;

INSERT INTO Invoice_1 VALUES
(201, 1, 75000, '2026-05-12'),
(202, 2, 12500, '2026-05-04'),
(203, 3, 40000, '2026-05-22');
CREATE TABLE Payment_1 (
     payment_id INT PRIMARY KEY,
     invoice_id INT,
     payment_amount DECIMAL(10,2),
     FOREIGN KEY (invoice_id)
       REFERENCES Invoice_1(invoice_id));
select*from Payment_1;
 INSERT INTO Payment_1 VALUES
(1001, 201, 75000),
(1002, 202, 12500),
(1003, 203, 40000);
SELECT * FROM Payment_1;
CREATE VIEW customer_balances AS
SELECT 
    c.customer_name,
    i.invoice_amount,
    p.payment_amount,
    (i.invoice_amount - p.payment_amount) AS balance
FROM Customer_1 c
JOIN Invoice_1 i ON c.customer_id = i.customer_id
JOIN Payment_1 p ON i.invoice_id = p.invoice_id;
SELECT * FROM customer_balances;
CREATE VIEW customer_overdue AS
SELECT 
    c.customer_name,
    i.invoice_amount,
    p.payment_amount AS overdue
FROM Customer_1 c
JOIN Invoice_1 i ON c.customer_id = i.customer_id
JOIN Payment_1 p ON i.invoice_id = p.invoice_id
WHERE invoice_amount>payment_amount;
SELECT * FROM customer_overdue;
CREATE VIEW customer_overdue_balance AS
SELECT
    c.customer_name,
    i.invoice_amount,
    p.payment_amount,
    i.invoice_amount - p.payment_amount AS balance,
    DATEDIFF(CURDATE(), i.due_date) AS days_overdue
FROM Customer_1 c
JOIN Invoice_1 i ON c.customer_id = i.customer_id
JOIN Payment_1 p ON i.invoice_id = p.invoice_id;

SELECT * FROM customer_overdue_balance;
CREATE VIEW customer_restrict AS
SELECT
    c.customer_name,
    i.invoice_amount,
    p.payment_amount,
    i.invoice_amount - p.payment_amount AS balance
FROM Customer_1 c
JOIN Invoice_1 i ON c.customer_id = i.customer_id
JOIN Payment_1 p ON i.invoice_id = p.invoice_id
WHERE i.invoice_amount - p.payment_amount > 0;

SELECT * FROM customer_restrict;
