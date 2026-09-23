create database JS5;
use JS5;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

INSERT INTO transactions
VALUES
(201, 'SALES Account', 'WITHDRAWAL', 60000, '2026-02-11'),
(202, 'CASH Account', 'CREDIT', 70000, '2026-02-10'),
(203, 'BANK Account', 'DEPOSIT', 85000, '2026-01-15');

CREATE TABLE audit_transactions (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    account_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER after_transaction_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id, NEW.account_name, NEW.transaction_type,
     NEW.amount, 'INSERT');
END //

DELIMITER ;

INSERT INTO transactions
VALUES (102, 'CASH Account', 'Debit', 60000, '2026-02-10');

SELECT * FROM audit_transactions;

DELIMITER //

CREATE TRIGGER after_transaction_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id, NEW.account_name, NEW.transaction_type,
     NEW.amount, 'UPDATE');
END //

DELIMITER ;

UPDATE transactions
SET amount = 19000
WHERE transaction_id = 103;

SELECT * FROM audit_transactions;

DELIMITER //

CREATE TRIGGER after_transaction_delete
AFTER DELETE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO audit_transactions
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (OLD.transaction_id, OLD.account_name, OLD.transaction_type,
     OLD.amount, 'DELETE');
END //

DELIMITER ;
DELETE FROM transactions
WHERE transaction_id = 103;

SELECT * FROM audit_transactions;