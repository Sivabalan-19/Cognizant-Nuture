-- Scenario 1: Apply 1% monthly interest to savings accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
    total_interest NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Processing monthly interest (1%)...');
    
    FOR acc IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings') LOOP
        DECLARE
            interest NUMBER := acc.Balance * 0.01;
        BEGIN
            UPDATE Accounts SET Balance = Balance + interest WHERE AccountID = acc.AccountID;
            INSERT INTO Transactions VALUES (NVL((SELECT MAX(TransactionID) FROM Transactions),0) + 1,
                                           acc.AccountID, SYSDATE, interest, 'Interest');
            total_interest := total_interest + interest;
            DBMS_OUTPUT.PUT_LINE('Account ' || acc.AccountID || ': +$' || interest);
        END;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total interest: $' || total_interest);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END ProcessMonthlyInterest;
/

-- Scenario 2: Add bonus to employees in a department
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept VARCHAR2,
    bonus_pct NUMBER
) AS
    count_emp NUMBER := 0;
    total_bonus NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Applying ' || bonus_pct || '% bonus to ' || dept || ' department...');
    
    FOR emp IN (SELECT EmployeeID, Name, Salary FROM Employees WHERE Department = dept) LOOP
        DECLARE
            bonus_amt NUMBER := emp.Salary * (bonus_pct / 100);
        BEGIN
            UPDATE Employees SET Salary = Salary + bonus_amt WHERE EmployeeID = emp.EmployeeID;
            count_emp := count_emp + 1;
            total_bonus := total_bonus + bonus_amt;
            DBMS_OUTPUT.PUT_LINE(emp.Name || ': +$' || bonus_amt);
        END;
    END LOOP;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Updated ' || count_emp || ' employees. Total bonus: $' || total_bonus);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END UpdateEmployeeBonus;
/

-- Scenario 3: Transfer funds between accounts
CREATE OR REPLACE PROCEDURE TransferFunds (
    from_id NUMBER,
    to_id NUMBER,
    amt NUMBER
) AS
    src_balance NUMBER;
BEGIN
    IF amt <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid amount');
        RETURN;
    END IF;
    
    SELECT Balance INTO src_balance FROM Accounts WHERE AccountID = from_id;
    
    IF src_balance < amt THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient balance');
        RETURN;
    END IF;
    
    UPDATE Accounts SET Balance = Balance - amt WHERE AccountID = from_id;
    UPDATE Accounts SET Balance = Balance + amt WHERE AccountID = to_id;
    
    INSERT INTO Transactions VALUES ((SELECT NVL(MAX(TransactionID),0)+1 FROM Transactions),
                                    from_id, SYSDATE, amt, 'Transfer');
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Transfer complete: $' || amt);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Account not found');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
END TransferFunds;
/

-- Test the procedures
-- EXEC ProcessMonthlyInterest;
-- EXEC UpdateEmployeeBonus('IT', 10);
-- EXEC TransferFunds(1, 2, 500);
