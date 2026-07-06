
-- Customers
INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastModified)
VALUES (1, 'John Doe', TO_DATE('1960-05-15', 'YYYY-MM-DD'), 1000, 'FALSE', SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastModified)
VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 15000, 'FALSE', SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastModified)
VALUES (3, 'Robert Johnson', TO_DATE('1962-03-10', 'YYYY-MM-DD'), 50000, 'FALSE', SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP, LastModified)
VALUES (4, 'Maria Garcia', TO_DATE('1985-12-25', 'YYYY-MM-DD'), 5000, 'FALSE', SYSDATE);

-- Accounts
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Checking', 15000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 50000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (4, 4, 'Checking', 5000, SYSDATE);

-- Transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 200, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

-- Loans
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 5000, 5, SYSDATE-20, ADD_MONTHS(SYSDATE, 10));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 10000, 4.5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 3, 25000, 3.5, SYSDATE-10, ADD_MONTHS(SYSDATE, 35));

-- Employees
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (3, 'Carol White', 'Analyst', 55000, 'IT', TO_DATE('2018-08-10', 'YYYY-MM-DD'));

COMMIT;
