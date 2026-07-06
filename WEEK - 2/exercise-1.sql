-- EXERCISE 1: CONTROL STRUCTURES

clear screen;
set serveroutput on;

-- SCENARIO 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
BEGIN
  FOR rec IN (SELECT customerID, DOB FROM customers) LOOP
    IF (FLOOR(MONTHS_BETWEEN(rec.DOB, SYSDATE) / 12) > 60) THEN
        UPDATE loans SET interestRate = interestRate - 1 WHERE customerID = rec.customerID;
    END IF;
  END LOOP;
END;
/

-- SCENARIO 2: A customer can be promoted to VIP status based on their balance.
DECLARE 
    balance_threshold number(10, 2) := 10000;
BEGIN
    FOR rec IN (SELECT customerID, balance FROM customers) LOOP
        IF (rec.balance > balance_threshold) THEN
            UPDATE customers SET isVIP = 'Y' WHERE customerID = rec.customerID;
        END IF;
    END LOOP;
END;
/   
-- SCENARIO 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
BEGIN
    FOR rec IN (SELECT c.name, l.enddate FROM customers c JOIN loans l ON c.customerID = l.customerID AND l.enddate BETWEEN SYSDATE AND SYSDATE + 30) LOOP
        dbms_output.put_line('Loan due for customer ' || rec.name || ' within ' || FLOOR(rec.enddate - SYSDATE) || ' days.');
    END LOOP;
END; 
/

        