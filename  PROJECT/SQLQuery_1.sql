--operators

--Guest Payment Information
SELECT ReservationID, AmountPaid
FROM Payments
WHERE AmountPaid IN (500, 750);

--Guest Name Search
SELECT FullName, PhoneNo
FROM Guests
WHERE FullName LIKE 'A%';

--Payments within a Range
SELECT PaymentID, ReservationID, AmountPaid
FROM Payments
WHERE AmountPaid BETWEEN 500 AND 750;

--Active Reservations
SELECT ReservationID, GuestID, RoomID
FROM Reservations
WHERE CheckOutDate IS NOT NULL;

--Ongoing Reservations from a Specific Date
SELECT ReservationID, GuestID, RoomID
FROM Reservations
WHERE CheckInDate = '2023-10-05' AND PaymentStatus = 'cancelled';


-- Available Rooms
SELECT RoomID, RoomType, PricePerNight
FROM Rooms
WHERE RoomType = 'single' OR RoomType = 'triple';

--Reservations Ordered by CheckIn Date
SELECT ReservationID, CheckInDate, CheckOutDate, GuestID
FROM Reservations
ORDER BY CheckInDate ASC;

--Payments Ordered by Amount
SELECT PaymentID, ReservationID, AmountPaid
FROM Payments
ORDER BY AmountPaid DESC;

--Unavailable Rooms
SELECT RoomID, RoomType, PricePerNight
FROM Rooms
WHERE NOT AvailabilityStatus = '1';

--2.Aggregate Functions

--Total Payments for Paid Status
SELECT SUM(AmountPaid) AS Total_Payments
FROM Payments
WHERE AmountPaid = 'Paid';

--Average Room Price
SELECT AVG(PricePerNight) AS Avg_Room_Price
FROM Rooms;

--Distance Statistics for Services
SELECT 
    MIN(ServicePrice) AS Lowest_Service_Price,
    MAX(ServiceID) AS Highest_Service_Price
FROM Services;
 

--3.Character Functions

--ASCII Value of Guest Names
SELECT GuestID, FullName, ASCII(FullName) AS ASCII_Value FROM Guests;
--Character and Unicode Functions
SELECT CHAR(74) AS Character;
SELECT NCHAR(65) AS Unicode_Character;
--Position of Character in Guest Name
SELECT GuestID, FullName, CHARINDEX('a', FullName) AS Position_In_Name FROM Guests;
--Contact Information Concatenation
SELECT CONCAT(FullName, ' - ', PhoneNo) AS Contact_Info FROM Guests;
--Guest Details Concatenation
SELECT CONCAT_WS(' | ', FullName, PhoneNo) AS Guest_Details FROM Guests;
--Start and End Location Codes for Reservations
SELECT LEFT(CheckInDate, 3) AS Start_Code FROM Reservations;
SELECT RIGHT(CheckOutDate, 3) AS End_Code FROM Reservations;
--Name Case Conversion
SELECT LOWER(FullName) AS Name_Lowercase FROM Guests;
SELECT UPPER(FullName) AS Name_Uppercase FROM Guests;
--Name Replacement
SELECT REPLACE(FullName, 'Guest', 'Client') AS Updated_Name FROM Guests;
--Pattern Index and Reversed Email
SELECT PATINDEX('%son%', FullName) AS Pattern_Index, FullName FROM Guests;
SELECT REVERSE(PhoneNo) AS Reversed_Contact FROM Guests;
--Trimming Spaces
SELECT LTRIM('     ' + FullName) AS No_Leading_Spaces FROM Guests;
SELECT RTRIM(fullName + '     ') AS No_Trailing_Spaces FROM Guests;
SELECT TRIM('     ' + FullName + '     ') AS Cleaned_Name FROM Guests;


--4. Joins

--Full Join on Rooms and Services
SELECT 
    RoomID, 
    RoomType, 
    PricePerNight AS Room_Price,
    ServiceID, 
    ServiceName, 
    PricePerNight AS Service_Price
FROM Rooms 
FULL JOIN Services s ON RoomID = s.ServiceID;

--Right Join on Payments and Guests
SELECT p.PaymentID, AmountPaid, g.GuestID, fullName
FROM Payments p
RIGHT JOIN Guests g ON GuestID = g.GuestID;

--Left Join on Reservations and Payments
SELECT r.ReservationID, r.GuestID, p.PaymentID, AmountPaid
FROM Reservations r
LEFT JOIN Payments p ON r.ReservationID = p.ReservationID;

--Inner Join on Guests and Reservations
SELECT g.GuestID, FullName, r.ReservationID, r.CheckInDate
FROM Guests g
INNER JOIN Reservations r ON g.GuestID = r.GuestID;

--5. Numeric Functions

--Cost Difference from 500 for Services
SELECT ServiceID, ServicePrice, ABS(ServicePrice - 500) AS Cost_Difference
FROM Services;
--Logarithm Base 10 of Amounts
SELECT PaymentID, AmountPaid, LOG(AmountPaid) AS Natural_Log_Amount
FROM Payments
WHERE AmountPaid > 0;
--Ceiling Cost per Service
SELECT ServiceID, ServicePrice, CEILING(ServicePrice) AS Ceiling_Cost
FROM Services;
--Floor Cost per Service
SELECT ServiceID, ServicePrice, FLOOR(ServicePrice) AS Floor_Cost
FROM Services;
--Square Root of Service Prices
SELECT ServiceID, ServicePrice, SQRT(ServicePrice) AS Sqrt_Cost
FROM Services;
--Square Root of Service Prices
SELECT PaymentID, AmountPaid, POWER(AmountPaid, 2) AS Amount_Squared
FROM Payments;
--Sign Comparison for Amounts
SELECT PaymentID, AmountPaid, SIGN(AmountPaid - 120) AS Sign_Compare_120
FROM Payments;
--Rounded Cost per Service
SELECT ServiceID, ServicePrice, ROUND(ServicePrice, 2) AS Rounded_Cost
FROM Services;
--Random Value Generation
SELECT RAND() AS Random_Value;



--CA3


--CA3


--PL/SQL Commands
--Anonymous Block
DECLARE @message NVARCHAR(100);
SET @message = 'Hello, T-SQL!';
PRINT @message;

--Control Structures
DECLARE @count INT = 0;
DECLARE @i INT;

SET @i = 1;

WHILE @i <= 10
BEGIN
    SET @count = @count + @i;
    SET @i = @i + 1;
END

PRINT 'Total: ' + CAST(@count AS NVARCHAR(10));

--

DECLARE @staffid INT, 
        @FullName NVARCHAR(50), 
        @salary DECIMAL(18, 2);  -- Assuming salary is a decimal type

DECLARE staff_Cursor 
CURSOR FOR     -- Step 1: Declare the cursor
SELECT StaffID, FullName, salary
FROM Staff
WHERE Role = 'Manager';

OPEN staff_Cursor;    -- Step 2: Open the cursor

FETCH NEXT FROM staff_Cursor INTO    -- Step 3: Fetch the first row
@staffid, @FullName, @salary;

WHILE @@FETCH_STATUS = 0    -- Step 4: Loop through the cursor and process each row
BEGIN
    PRINT 'Staff ID: ' + CAST(@staffid AS NVARCHAR(10)) +
          ', Name: ' + @FullName + 
          ', Salary: ' + CAST(@salary AS NVARCHAR(20));  -- Cast salary to NVARCHAR for concatenation
          
    FETCH NEXT FROM staff_Cursor INTO @staffid, @FullName, @salary;  -- Fetch the next row
END

CLOSE staff_Cursor; -- Step 5: Close the cursor
DEALLOCATE staff_Cursor;   -- Step 6: Deallocate the cursor


---
DECLARE @ServiceID INT,
        @usageDate NVARCHAR(50),
        @TotalCost NVARCHAR(100);

DECLARE service_Cursor CURSOR FOR
SELECT ServiceID, usageDate, TotalCost
FROM ServiceUsage
WHERE ServiceID = 20;  -- Assuming ServiceID is an INT, no quotes needed

OPEN service_Cursor;

FETCH NEXT FROM service_Cursor INTO @ServiceID, @usageDate, @TotalCost;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Service ID: ' + CAST(@ServiceID AS NVARCHAR(10)) +
          ', Usage Date: ' + @usageDate +
          ', Total Cost: ' + @TotalCost;

    FETCH NEXT FROM service_Cursor INTO @ServiceID, @usageDate, @TotalCost;
END

CLOSE service_Cursor;
DEALLOCATE service_Cursor;



--cursors
--Implicit Cursors
DECLARE @fullname VARCHAR(100);

SELECT @fullname = 'RITIKA SHARMA'
FROM Staff
WHERE StaffID = 101; -- Implicit cursor

PRINT 'Employee Name: ' + @fullname;

---
DECLARE @GuestID INT = 1;  -- Assuming we are looking for GuestID 1
DECLARE @FullName VARCHAR(100);
DECLARE @Phoneno VARCHAR(100);

SELECT @FullName = FullName, @Phoneno = PhoneNo
FROM Guests
WHERE GuestID = @GuestID;  -- Implicit cursor

PRINT 'Guest Name: ' + @FullName + ' Phone NO: ' + @Phoneno;

--
DECLARE @RoomID INT = 101;  -- Assuming we are looking for RoomID 101
DECLARE @RoomType VARCHAR(50);
DECLARE @Pricepernight DECIMAL(10, 2);

SELECT @RoomType = RoomType, @Pricepernight = PricePerNight
FROM Rooms
WHERE RoomID = @RoomID;  -- Implicit cursor

PRINT 'Room Type: ' + @RoomType + ', Price: ' + CAST(@Pricepernight AS VARCHAR(10));


--triggers

CREATE TRIGGER AfterPaymentInsert
ON Payments
AFTER INSERT
AS
BEGIN
    UPDATE Reservations
    SET PaymentStatus = 'Paid'
    WHERE ReservationID IN (SELECT ReservationID FROM inserted);
END;

--
CREATE TRIGGER AfterReservationInsert
ON Reservations
AFTER INSERT
AS
BEGIN
    UPDATE Rooms
    SET AvailabilityStatus = '1'
    WHERE RoomID IN (SELECT RoomID FROM inserted);
END;


--

CREATE TRIGGER LogPaymentUpdates
AFTER UPDATE ON Payments
FOR EACH ROW
BEGIN
    INSERT INTO PaymentLog (PaymentID, OldAmountPaid, NewAmountPaid, ChangeDate)
    VALUES (NEW.PaymentID, OLD.AmountPaid, NEW.AmountPaid, NOW());
END;

--views
CREATE VIEW ActiveReservationsView AS
SELECT 
    r.ReservationID,
    g.Name AS GuestName,
    rm.RoomType,
    r.CheckInDate,
    r.CheckOutDate,
    r.TotalAmount,
    r.PaymentStatus
FROM 
    Reservations r
INNER JOIN 
    Guests g ON r.GuestID = g.GuestID
INNER JOIN 
    Rooms rm ON r.RoomID = rm.RoomID
WHERE 
    r.CheckOutDate IS NULL;  -- Only active reservations


--view syntax
--CREATE VIEW view_name AS
--SELECT column1, column2, ...
--FROM table_name
--WHERE condition;





--extra

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










