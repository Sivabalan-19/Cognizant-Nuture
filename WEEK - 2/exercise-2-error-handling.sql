-- Scenario 1: Transfer funds with error handling
CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    from_acc NUMBER,
    to_acc NUMBER,
    amount NUMBER
) AS
    balance NUMBER;
BEGIN
    -- Check if amount is valid
    IF amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Amount must be greater than 0');
        RETURN;
    END IF;
    
    -- Get balance from source account
    SELECT Balance INTO balance FROM Accounts WHERE AccountID = from_acc;
    
    -- Check if enough balance
    IF balance < amount THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds');
        RETURN;
    END IF;
    
    -- Do the transfer
    UPDATE Accounts SET Balance = Balance - amount WHERE AccountID = from_acc;
    UPDATE Accounts SET Balance = Balance + amount WHERE AccountID = to_acc;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer successful: $' || amount);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Account not found');
        INSERT INTO ErrorLog VALUES (ErrorLog_SEQ.NEXTVAL, 'Account not found', SYSDATE, 'SafeTransferFunds');
        COMMIT;
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        INSERT INTO ErrorLog VALUES (ErrorLog_SEQ.NEXTVAL, SQLERRM, SYSDATE, 'SafeTransferFunds');
        COMMIT;
END SafeTransferFunds;
/

-- Scenario 2: Update employee salary with validation
CREATE OR REPLACE PROCEDURE UpdateSalary (
    emp_id NUMBER,
    percent NUMBER
) AS
    old_sal NUMBER;
    new_sal NUMBER;
BEGIN
    IF percent < 0 OR percent > 100 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid percentage');
        RETURN;
    END IF;
    
    SELECT Salary INTO old_sal FROM Employees WHERE EmployeeID = emp_id;
    new_sal := old_sal * (1 + percent / 100);
    
    UPDATE Employees SET Salary = new_sal WHERE EmployeeID = emp_id;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Salary updated: ' || old_sal || ' -> ' || new_sal);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Employee not found');
        INSERT INTO ErrorLog VALUES (ErrorLog_SEQ.NEXTVAL, 'Employee ' || emp_id || ' not found', SYSDATE, 'UpdateSalary');
        COMMIT;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END UpdateSalary;
/

-- Scenario 3: Add new customer with duplicate check
CREATE OR REPLACE PROCEDURE AddNewCustomer (
    cust_id NUMBER,
    name VARCHAR2,
    dob DATE,
    balance NUMBER
) AS
    check_id NUMBER;
BEGIN
    IF name IS NULL OR balance < 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid data');
        RETURN;
    END IF;
    
    SELECT COUNT(*) INTO check_id FROM Customers WHERE CustomerID = cust_id;
    
    IF check_id > 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Customer already exists');
        INSERT INTO ErrorLog VALUES (ErrorLog_SEQ.NEXTVAL, 'Duplicate customer ID: ' || cust_id, SYSDATE, 'AddNewCustomer');
        COMMIT;
        RETURN;
    END IF;
    
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastModified)
    VALUES (cust_id, name, dob, balance, 'FALSE', SYSDATE);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Customer added: ' || name);
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END AddNewCustomer;
/

CREATE SEQUENCE ErrorLog_SEQ START WITH 1 INCREMENT BY 1;
