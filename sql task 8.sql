use my_database;
CREATE TABLE customers1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);
INSERT INTO customers1 (customer_id, customer_name, email, city)
VALUES
(1, 'Asha', 'asha@gmail.com', 'Mangalore'),
(2, 'Rahul', 'rahul@gmail.com', 'Bangalore'),
(3, 'Meera', 'meera@gmail.com', 'Mysore'),
(4, 'Arjun', 'arjun@gmail.com', 'Udupi'),
(5, 'Sneha', 'sneha@gmail.com', 'Hubli');
SELECT* FROM customers1;
CREATE TABLE transactions (
      transaction_id INT PRIMARY KEY,
      Customer_id INT,
      Amount DECIMAL,
      Transaction_date DATE,
	  FOREIGN KEY (customer_id) REFERENCES Customers1(customer_id)
);
 INSERT INTO transactions
(transaction_id, customer_id, amount, transaction_date)
VALUES
(1, 1, 2500.00, '2026-01-05'),
(2, 2, 1800.00, '2026-01-10'),
(3, 3, 3200.00, '2026-01-15'),
(4, 4, 1500.00, '2026-02-02'),
(5, 5, 2750.00, '2026-02-08'),
(6, 1, 1200.00, '2026-02-15'),
(7, 2, 4500.00, '2026-03-01'),
(8, 3, 2100.00, '2026-03-10'),
(9, 4, 3500.00, '2026-03-18'),
(10, 5, 1900.00, '2026-04-05'),
(11, 1, 2800.00, '2026-04-12'),
(12, 3, 4000.00, '2026-04-20');
SELECT * FROM transactions;
SELECT * FROM transactions;

CREATE TABLE invoices1 (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(10,2),
    invoice_date DATE,
    due_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers1(customer_id)
);
INSERT INTO invoices1
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(18, 1, 2750.00, '2026-06-05', '2026-06-20', 'Pending'),
(19, 3, 4100.00, '2026-06-12', '2026-06-27', 'Paid'),
(20, 5, 3650.00, '2026-06-18', '2026-07-03', 'Pending'),
(21, 2, 5200.00, '2026-06-25', '2026-07-10', 'Paid'),
(22, 4, 2900.00, '2026-07-02', '2026-07-17', 'Pending');
INSERT INTO invoices1
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(18, 1, 2750.00, '2026-06-05', '2026-06-20', 'Pending'),
(19, 3, 4100.00, '2026-06-12', '2026-06-27', 'Paid'),
(20, 5, 3650.00, '2026-06-18', '2026-07-03', 'Pending'),
(21, 2, 5200.00, '2026-06-25', '2026-07-10', 'Paid'),
(22, 4, 2900.00, '2026-07-02', '2026-07-17', 'Pending');
INSERT INTO invoices1
(invoice_id, customer_id, invoice_amount, invoice_date, due_date, payment_status)
VALUES
(18, 1, 2750.00, '2026-06-05', '2026-06-20', 'Pending'),
(19, 3, 4100.00, '2026-06-12', '2026-06-27', 'Paid'),
(20, 5, 3650.00, '2026-06-18', '2026-07-03', 'Pending'),
(21, 2, 5200.00, '2026-06-25', '2026-07-10', 'Paid'),
(22, 4, 2900.00, '2026-07-02', '2026-07-17', 'Pending');
SELECT * FROM invoices1;
     UPDATE invoices1
SET invoice_amount = CASE invoice_id
    WHEN 1 THEN 1500.00
    WHEN 2 THEN 2200.00
    WHEN 3 THEN 1800.00
    WHEN 4 THEN 3200.00
    WHEN 5 THEN 2750.00
    WHEN 6 THEN 1950.00
    WHEN 7 THEN 4100.00
    WHEN 8 THEN 2850.00
    WHEN 9 THEN 3600.00
    WHEN 10 THEN 2400.00
    WHEN 11 THEN 3100.00
    WHEN 12 THEN 1950.00
    WHEN 13 THEN 4200.00
    WHEN 14 THEN 2750.00
    WHEN 15 THEN 3300.00
    WHEN 16 THEN 2250.00
    WHEN 17 THEN 3900.00
END
WHERE invoice_id BETWEEN 1 AND 17;
select*from invoices1;
select customer_name from customers1 where customer_id in
(select customer_id from invoices1 where payment_status="pending");
SELECT customer_name
FROM customers1
WHERE customer_id IN
(
    SELECT customer_id
    FROM transactions
    WHERE amount > 2500
);
SELECT customer_name
FROM customers1
WHERE customer_id IN
(
    SELECT customer_id
    FROM transactions
    WHERE amount =
    (
        SELECT MAX(amount)
        FROM transactions
    )
);
SELECT *
FROM transactions
WHERE amount >
(
    SELECT AVG(amount)
    FROM transactions
);
SELECT customer_name
FROM customers1
WHERE customer_id IN
(
    SELECT customer_id
    FROM transactions
    WHERE city = 'Mangalore'
);
SELECT c.customer_id,
       c.customer_name
FROM customers1 c
WHERE EXISTS
(
    SELECT 1
    FROM invoices1 i
    WHERE c.customer_id = i.customer_id
      AND i.payment_status = 'Paid'
);
SELECT c.customer_id,
       c.customer_name
FROM customers1 c
WHERE EXISTS
(
    SELECT 1
    FROM transactions i
    WHERE c.customer_id = i.customer_id
      AND i.amount > 2500
);
SELECT t1.transaction_id, t1.amount
FROM transactions AS t1
WHERE t1.amount > (
    SELECT AVG(t2.amount)
    FROM transactions AS t2
    WHERE t2.customer_id = t1.customer_id
);
SELECT t1.transaction_id,t1.customer_id,t1.amount
FROM transactions AS t1
WHERE t1.amount > (
    SELECT AVG(t2.amount)
    FROM transactions AS t2
    WHERE t2.customer_id = t1.customer_id
);
SELECT c.customer_id, c.customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM transactions t
    WHERE c.customer_id = t.customer_id
    AND c.city = "Mangalore"
);




