-- EXERCISE 3: STORED PROCEDURES

clear screen;
set serveroutput on;

-- SCENARIO 1: The bank needs to process monthly interest for all savings accounts.
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN 
    UPDATE accounts SET balance = balance + balance * 0.1 WHERE accountTYPE = 'Savings';
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/

-- SCENARIO 2: The bank wants to implement a bonus scheme for employees based on their performance.
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(dept employees.department%TYPE, bonus number) 
IS
INVALID_BONUS EXCEPTION;
BEGIN
    IF (bonus < 1) THEN
        raise INVALID_BONUS;
    END IF;
    UPDATE employees SET salary = salary + salary * (bonus / 100) WHERE department = dept;
    COMMIT;
EXCEPTION
    WHEN INVALID_BONUS THEN
        dbms_output.put_line('Invalid bonus');
        ROLLBACK;
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END;
/

-- SCENARIO 3: Customers should be able to transfer funds between their accounts.
CREATE OR REPLACE PROCEDURE TransferFunds(accountID1 accounts.accountID%TYPE, accountID2 accounts.accountID%TYPE, amount NUMBER)
IS
INSUFFICIENT_FUNDS EXCEPTION;
INVALID_AMOUNT EXCEPTION;
account_amount accounts.balance%TYPE;
dummy accounts%ROWTYPE;

BEGIN
-- Check if amount is valid
    IF (amount <= 0) THEN
        RAISE invalid_amount;
    END IF;

-- Check source account and account balance    
    SELECT balance into account_amount from accounts WHERE accountID = accountID1;
    IF (account_amount < amount) THEN
        RAISE insufficient_funds;
    END IF;    

-- Check destination account    
    SELECT * INTO dummy FROM accounts where accountID = accountID2;
    
-- Update balance    
    UPDATE accounts SET balance = balance - amount WHERE accountID = accountID1;
    UPDATE accounts SET balance = balance + amount WHERE accountID = accountID2;
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Account not found.');
        ROLLBACK;
    WHEN INSUFFICIENT_FUNDS THEN
        dbms_output.put_line('Insufficient funds.');
        ROLLBACK;
    WHEN INVALID_AMOUNT THEN
        dbms_output.put_line('Amount is invalid.');
        ROLLBACK;
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END;
/

