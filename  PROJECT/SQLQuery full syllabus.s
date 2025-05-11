DDL commands
--create table 
CREATE TABLE employees(
    EmployeID [int] PRIMARY KEY,
    FIRSTNAME [varchar](50),
    LASTName [varchar](50),
    HireDate [date] NULL,
    salary [decimal](10,2)

)
--add a column
ALTER TABLE employees
    ADD DATEPART [varchar](50);
-- drop column
DROP employees;

--remove all the rows
TRUNCATE TABLE employees;

--DML Commands
-- insert records
INSERT INTO employees (EmployeID, FIRSTNAME, LASTName, HireDate, Salary) VALUES
(1, 'nishant', 'dhall', '2023-05-20', 5000),
(2, 'jasmine', 'parmar', '2023-05-20', 2000);
insert into employees (EmployeID,FIRSTNAME,LASTName,HireDate,salary) VALUES
(3,'rudra','bansal','2024-05-26',4000);
--update 
UPDATE employees
SET salary=65000
WHERE EmployeID=3;
--delete 
DELETE from employees
WHERE EmployeID=1;
--select
SELECT* from employees;
--select salary greater then
select* From employees 
WHERE salary>2000;

--sql constraints

--foreign key
CREATE TABLE Department(
DepartmentID int PRIMARY KEY,
DepartmentNAME varchar(50),
ManagerID int references employees(EmployeID));
--set default unknown
ALTER TABLE Department
ADD LOCATION varchar(50) DEFAULT 'UNKNOWN';

INSERT INTO employees (EmployeID, FIRSTNAME, LASTNAME, HireDate, Salary) VALUES
(11, 'Arjun', 'Sharma', '2023-05-15', 35000),
(12, 'Priya', 'Kumar', '2022-11-20', 42000),
(13, 'Ravi', 'Patel', '2021-09-10', 50000),
(4, 'Neha', 'Gupta', '2020-03-05', 28000),
(5, 'Suresh', 'Singh', '2023-01-18', 55000),
(6, 'Anjali', 'Mehta', '2019-12-30', 47000),
(7, 'Rahul', 'Joshi', '2022-06-22', 39000),
(8, 'Divya', 'Agarwal', '2020-07-25', 32000),
(9, 'Karan', 'Desai', '2021-04-12', 45000),
(10, 'Sneha', 'Nair', '2019-08-17', 60000);

select * from employees

INSERT INTO department (DepartmentID, DepartmentName, ManagerID) VALUES
(11, 'Human Resources', 11),
(2, 'Finance', 2),
(3, 'Information Technology', 3),
(4, 'Marketing', 4),
(5, 'Sales', 5),
(6, 'Customer Service', 6),
(7, 'Research and Development', 7),
(8, 'Logistics', 8),
(9, 'Operations', 9),
(10, 'Legal', 10);

--joins implementation
SELECT EmployeID,FirstName,LastName,DepartmentID, DepartmentName FROM employees
RIGHT JOIN Department ON EmployeID=ManagerID;

SELECT EmployeID, FIRSTNAME, LASTNAME, DepartmentID, DepartmentName
FROM Employees e
LEFT JOIN Department ON EmployeID = ManagerID;

SELECT EmployeID, FIRSTNAME, LASTNAME, DepartmentID, DepartmentName
FROM Employees e
INNER JOIN Department d ON EmployeID = ManagerID;

SELECT EmployeID, FIRSTNAME, LASTNAME, DepartmentID, DepartmentName
FROM Employees 
FULL JOIN Department ON EmployeID = ManagerID;

-- Creating Departments table with PRIMARY KEY and NOT NULL constraint
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) DEFAULT 'Unknown'
);

-- Creating Employees table with various integrity constraints
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,           -- Primary Key Constraint: unique and not null
    FirstName VARCHAR(50) NOT NULL,       -- Not Null Constraint: cannot be null
    LastName VARCHAR(50) NOT NULL,        -- Not Null Constraint: cannot be null
    HireDate DATE DEFAULT CURRENT_DATE,   -- Default Constraint: current date if not specified
    Salary DECIMAL(10, 2) CHECK (Salary > 0), -- Check Constraint: salary must be greater than 0
    Email VARCHAR(100) UNIQUE,             -- Unique Constraint: emails must be unique
    DepartmentID INT,                      -- Foreign Key Constraint: references Departments table
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Sample Inserts to demonstrate constraints work

-- Insert into Departments (valid insert)
INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES (1, 'Engineering', 'New York');

-- Insert into Employees (valid insert)
INSERT INTO Employees
(EmployeeID, FirstName, LastName, HireDate, Salary, Email, DepartmentID)
VALUES
(1001, 'Alice', 'Smith', '2023-01-10', 75000.00, 'alice.smith@example.com', 1);

-- Assuming the Employees table already exists and has data

-- 1. Aggregate Functions
-- a. COUNT: Count the number of employees
SELECT COUNT(*) AS TotalEmployees FROM employees;

-- b. SUM: Calculate the total salary of all employees
SELECT SUM(Salary) AS TotalSalary FROM employees;

-- c. AVG: Calculate the average salary of employees
SELECT AVG(Salary) AS AverageSalary FROM employees;

-- d. MAX: Find the highest salary among employees
SELECT MAX(Salary) AS HighestSalary FROM employees;

-- e. MIN: Find the lowest salary among employees
SELECT MIN(Salary) AS LowestSalary FROM employees;

-- 2. String Functions
-- a. CONCAT: Concatenate first and last names
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM employees;

-- b. UPPER: Convert first names to uppercase
SELECT UPPER(FirstName) AS UpperFirstName FROM employees;

-- c. LOWER: Convert last names to lowercase
SELECT LOWER(LastName) AS LowerLastName FROM employees;

-- d. LENGTH: Get the length of the first name
SELECT FirstName, LENGTH(FirstName) AS FirstNameLength FROM employees;

-- 3. Date Functions
-- a. CURRENT_DATE: Get the current date
SELECT CURRENT_DATE AS Today;

-- b. DATEDIFF: Calculate the number of days since hire date
SELECT FirstName, DATEDIFF(CURRENT_DATE, HireDate) AS DaysSinceHired FROM employees;

-- c. YEAR: Extract the year from the hire date
SELECT FirstName, YEAR(HireDate) AS HireYear FROM employees;

-- d. MONTH: Extract the month from the hire date
SELECT FirstName, MONTH(HireDate) AS HireMonth FROM employees;

-- 4. Numeric Functions
-- a. ROUND: Round the salary to the nearest whole number
SELECT FirstName, ROUND(Salary) AS RoundedSalary FROM employees;

-- b. CEIL: Get the smallest integer greater than or equal to the salary
SELECT FirstName, CEIL(Salary) AS CeilSalary FROM employees;

-- c. FLOOR: Get the largest integer less than or equal to the salary
SELECT FirstName, FLOOR(Salary) AS FloorSalary FROM employees;

-- 5. Conditional Functions
-- a. CASE: Create a salary band based on salary
SELECT FirstName, Salary,
    CASE 
        WHEN Salary < 30000 THEN 'Low'
        WHEN Salary BETWEEN 30000 AND 60000 THEN 'Medium'
        ELSE 'High'
    END AS SalaryBand
FROM employees;

-- 6. Using Functions in a WHERE Clause
-- a. Find employees whose first name starts with 'A'
SELECT * FROM employees
WHERE UPPER(FirstName) LIKE 'A%';

-- b. Find employees hired in the current year
SELECT * FROM employees
WHERE YEAR(HireDate) = YEAR(CURRENT_DATE);

-- Creating a simple view in Oracle PL/SQL to show employees with salary > 50000

CREATE OR REPLACE VIEW HighEarners AS
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE Salary > 50000;

-- Query the view to verify
-- SELECT * FROM HighEarners;

-- Creating a view to show employee full names concatenated
CREATE OR REPLACE VIEW EmployeeFullNames AS
SELECT EmployeeID, FirstName || ' ' || LastName AS FullName, DepartmentID
FROM Employees;

-- Query the view to verify
-- SELECT * FROM EmployeeFullNames;

-- Example of a Cursor in PL/SQL to fetch employees with salary > 40000 and display their info

DECLARE
    CURSOR emp_cursor IS
        SELECT EmployeeID, FirstName, LastName, Salary FROM Employees WHERE Salary > 40000;

    v_EmployeeID Employees.EmployeeID%TYPE;
    v_FirstName Employees.FirstName%TYPE;
    v_LastName Employees.LastName%TYPE;
    v_Salary Employees.Salary%TYPE;

BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_EmployeeID, v_FirstName, v_LastName, v_Salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_EmployeeID || 
                             ', Name: ' || v_FirstName || ' ' || v_LastName || 
                             ', Salary: ' || v_Salary);
    END LOOP;
    CLOSE emp_cursor;
END;
/

-- Trigger example: Automatically update LastUpdated column on salary update 

-- First, add LastUpdated column to Employees table
ALTER TABLE Employees ADD (LastUpdated DATE);

-- Create trigger to update LastUpdated when salary is updated
CREATE OR REPLACE TRIGGER trg_UpdateLastUpdated
BEFORE UPDATE OF Salary ON Employees
FOR EACH ROW
BEGIN
    :NEW.LastUpdated := SYSDATE;
END;
/






