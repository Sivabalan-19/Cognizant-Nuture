-- Exercise 1: Scenario 1 - Senior Customer Loan Discount
-- Apply 1% discount to loans for customers above 60 years old

BEGIN
    FOR cust IN (SELECT c.CustomerID, c.Name, TRUNC((SYSDATE - c.DOB) / 365.25) age
                 FROM Customers c) LOOP
        IF cust.age > 60 THEN
            UPDATE Loans SET InterestRate = InterestRate * 0.99 
            WHERE CustomerID = cust.CustomerID;
            DBMS_OUTPUT.PUT_LINE(cust.Name || ' - Senior discount applied');
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Done!');
END;
/

-- Exercise 1: Scenario 2 - VIP Customer Promotion
-- Mark customers with balance over $10,000 as VIP

BEGIN
    FOR cust IN (SELECT * FROM Customers) LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers SET IsVIP = 'TRUE', LastModified = SYSDATE 
            WHERE CustomerID = cust.CustomerID;
            DBMS_OUTPUT.PUT_LINE(cust.Name || ' promoted to VIP');
        END IF;
    END LOOP;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('VIP List:');
    FOR v IN (SELECT Name, Balance FROM Customers WHERE IsVIP = 'TRUE') LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v.Name || ' - $' || v.Balance);
    END LOOP;
END;
/

-- Exercise 1: Scenario 3 - Loan Due Reminders
-- Send reminders for loans due within 30 days

BEGIN
    DBMS_OUTPUT.PUT_LINE('Loans due in next 30 days:');
    DBMS_OUTPUT.PUT_LINE('');
    
    FOR loan IN (SELECT l.LoanID, c.Name, l.LoanAmount, l.EndDate,
                        TRUNC(l.EndDate - SYSDATE) days_left
                 FROM Loans l
                 JOIN Customers c ON l.CustomerID = c.CustomerID
                 WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
                 ORDER BY l.EndDate) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: ' || loan.Name);
        DBMS_OUTPUT.PUT_LINE('  Loan: $' || loan.LoanAmount);
        DBMS_OUTPUT.PUT_LINE('  Due: ' || TO_CHAR(loan.EndDate, 'DD-MON-YYYY') || ' (' || loan.days_left || ' days)');
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
