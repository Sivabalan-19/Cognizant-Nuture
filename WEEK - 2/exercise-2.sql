-- EXERCISE 2: ERROR HANDLING

clear screen;
set serveroutput on;

-- SCENARIO 1: Handle exceptions during fund transfers between accounts.
CREATE OR REPLACE PROCEDURE SafeTransferFunds(accountID1 accounts.accountID%TYPE, accountID2 accounts.accountID%TYPE, amount NUMBER)
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

-- SCENARIO 2: Manage errors when updating employee salaries.
CREATE OR REPLACE PROCEDURE UpdateSalary(empID employees.EmployeeID %TYPE, bonus number) 
IS
BEGIN
    IF (bonus <= 0) THEN
        RAISE_APPLICATION_ERROR(-20101, 'Invalid bonus percentage');
    ELSIF (empID < 0) THEN
        RAISE_APPLICATION_ERROR(-20101, 'Invalid employee ID');
    END IF;
    UPDATE employees SET salary = salary + (salary * (bonus / 100)) where EmployeeID = empID;
    IF (SQL%ROWCOUNT = 0) THEN
        RAISE NO_DATA_FOUND;
    END IF;
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Employee not found.');
        ROLLBACK;
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END;
/

-- SCENARIO 3: Ensure data integrity when adding a new customer.
CREATE OR REPLACE PROCEDURE AddNewCustomer(customerID customers.customerID%TYPE, username customers.name%TYPE, DOB customers.dob%TYPE, balance customers.balance%TYPE)
IS
BEGIN
    INSERT INTO customers (customerID, name, DOB, balance, lastModified) VALUES(customerID, username, DOB, balance, SYSDATE);
    COMMIT;
    dbms_output.put_line('Customer inserted.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('Employee with ID already exists.');
        ROLLBACK;
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        ROLLBACK;
END;
/
