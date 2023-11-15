/* BAISCS */

/* Creating a table */
CREATE TABLE EmployeeDemographics
(EmployeeID int, FirstName varchar(50),
LastName varchar(50), Age int, Gender varchar(50))

CREATE TABLE EmployeeSalary
(EmployeeID int, JobTitle varchar(50), Salary int)

/* Inserting the values in the respective tables */

INSERT INTO EmployeeDemographics VALUES 
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

/* To Select the table with DataBase Name through qurey */
SELECT * FROM Alex.dbo.EmployeeDemographics

/* Select Statement Top, Distinct, Count, AS, MAX, MIN, AVG */

/* To Select only Top 5 or any number of rows from table */
SELECT TOP 5 * FROM EmployeeDemographics

/* To Select only Distinct values from the table */
SELECT DISTINCT(FirstName) FROM EmployeeDemographics

/* To get the number of NON NULL values in a column with COUNT() and give the resulted column a name with AS */
SELECT COUNT(LastName) AS LastNameCount FROM EmployeeDemographics

/* To get the MAX Value of the column from a table */
SELECT MAX(Age) AS MaxAge FROM EmployeeDemographics

/* To get the MIN Value of the column from a table */
SELECT MIN(Salary) AS MINSalary FROM EmployeeSalary

/* To get the AVG Value of the column from a table */
SELECT AVG(Salary) AS AVGSalary FROM EmployeeSalary

/* What does a WHERE Statement do ?
   It helps limit the amount of data and specify what data you want to returned */

/* WHERE Statement =, <>(Not Equaltoo), <, <=, >=, >, And, Or, Like, Null, Not Null, In */

/* =, <>(Not Equaltoo), <, <=, >=, >, And, Or */

SELECT * FROM EmployeeDemographics WHERE Gender = 'Male'

SELECT * FROM EmployeeSalary WHERE JobTitle <> 'HR'

SELECT * FROM EmployeeSalary WHERE Salary > 47000

SELECT * FROM EmployeeDemographics WHERE Age >= 35

SELECT * FROM EmployeeDemographics WHERE EmployeeID < 1005

SELECT * FROM EmployeeSalary WHERE Salary <= 45000

SELECT * FROM EmployeeDemographics WHERE Age >= 35 AND Gender = 'MALE'

SELECT * FROM EmployeeSalary WHERE Salary <= 45000 OR JobTitle = 'Salesman'


/* LIKE is used to match certain case with the values of the column in the table. Here '%' is called WildCard */

/*The following show all the value from column FirstName which has M at the first place. */
SELECT * FROM EmployeeDemographics WHERE FirstName LIKE 'M%'

/*The following show all the value from column FirstName which has M at the End of the value. */
SELECT * FROM EmployeeDemographics WHERE FirstName LIKE '%M'

/*The following show all the value from column FirstName which has M at the End of the value. */
SELECT * FROM EmployeeDemographics WHERE FirstName LIKE '%M'

/*The following show all the value from column LastName which has M placed anywhere in the value. */
SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%M%'

/*The following show all the value from column LastName which match the string in the specified order. In this case the values have matched the string in order - first 's' and then 't' */
SELECT * FROM EmployeeDemographics WHERE LastName LIKE 's%t%'

/* Null, Not Null, In */

/* All the rows which has NULL as value in the column selected will be displayed */
SELECT * FROM EmployeeDemographics WHERE LastName is NULL

/* All the rows which has NOT NULL as value in the column selected will be displayed */
SELECT * FROM EmployeeDemographics WHERE LastName is NOT NULL

/* IN - it is similar to equal statement but it's multiple equal statments. In the parentheses we can mention all the values which we want to match from that column */
SELECT * FROM EmployeeDemographics WHERE FirstName IN ('Toby', 'stanley')

/* Group By, Order By */

/* Group By Statement is similar to Distinct in the Select Statement and that it's gonna show unique values in a column. The difference is if we use Distinct it will return very first values. But if we use Goup By it will roll all the unique values in one row respectively. Following is the comaprision */
SELECT DISTINCT(Gender) FROM EmployeeDemographics 

SELECT Gender FROM EmployeeDemographics GROUP BY Gender

SELECT Gender, COUNT(GENDER) AS GenderCount FROM EmployeeDemographics GROUP BY Gender

SELECT Gender, Age, COUNT(GENDER) FROM EmployeeDemographics GROUP BY Gender, Age

/* The following Statment is in worng format, we cannot put COUNT(Gender) in the Gourp By that's because the COUNT(Gender) is actually a derived field/column. It's derived based on the Gender column, so it's not a real column that's in the table but it's the one we're creating */
SELECT Gender, Age FROM EmployeeDemographics GROUP BY Gender, Age, COUNT(GENDER)

/* Order By - By default it will ASC(small to large) to make it desc(large to small) add DESC to the end */
SELECT * FROM EmployeeDemographics 
ORDER BY Age DESC

/* ORDER BY with multiple column. The following has Age as DESC and Gender as ASC. Observe the Age 32&30 for clarity */ 
SELECT * FROM EmployeeDemographics 
ORDER BY Age DESC, Gender 

/* Combination of both GROUP BY & ORDER BY */
SELECT Gender, COUNT(GENDER) AS GenderCount 
FROM EmployeeDemographics 
WHERE Age > 31
GROUP BY Gender
ORDER BY GenderCount

/* Selecting column by number. In the table EmployeeDemographics there are 5 columns, all the columns will have number in order. In the following statement as Age is at 4th place in the table, we used 4 & repesctively 5 for Gender. */
SELECT * FROM EmployeeDemographics 
ORDER BY 4 DESC, 5

/* Note: these number will not work for SELECT Statment. The following is a worng statement */
SELECT 4 FROM EmployeeDemographics 


select * from EmployeeDemographics
select * from EmployeeSalary
