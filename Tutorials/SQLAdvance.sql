/* ADVANCE */

/* CTE (COMMON TABLE EXPRESSION) - It's like a function in programming language where you can write code in a set of bracket and give it a name and use it later anywhere.
  The SELECT statement where the CTE will be called should be right after the CTE table. 
  It will not work any else or in between of other queries.
  It is not stored anywhere, it is only created in memory rathen than a tempdb file like a temp table would be but in general a CTE acts very much like a subqurey.
  It is also called WITH Statement as it starts with WITH.*/

WITH CTE_Employee AS 
( SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) T_Gender,
AVG(Salary) OVER (PARTITION BY Gender) Avg_Sal
FROM Alex..EmployeeDemographics Demo
JOIN Alex..EmployeeSalary Sal
ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000' )

SELECT * FROM CTE_Employee

/* Following will not work because it can be excuted along with the CTE table due to the SELECT Statement in between */ 
SELECT FirstName, Avg_Sal FROM CTE_Employee

/* TEMP TABLE - You can call it multiple time unlike CTE. */

CREATE TABLE #temp_Employee 
( EmployeeID int, JobTitle varchar(100), Salary int )

Select * From #temp_employee

Insert into #temp_employee values (
'1001', 'HR', '45000'
)


/* Selecting all the data from one table and inserting it into other table */
Insert into #temp_employee 
SELECT * From Alex..EmployeeSalary

Select * From #temp_employee



/* Can add below line when you want to run everything mulitple time.
   So if the table EXISTS it will get DELETE and then new table will be created, due to which we can see creation and insertion of the table without any error. */
DROP TABLE IF EXISTS #temp_employee3


Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

/* The following qurey insert the values which are obtained after the excution of the SELECT statement.
   This helps in saving us from rewriting the SELECT Statement repeatedly, we can just use the TEMP TABLE NAME whenever whereever we want the result of the SELECT Statment or perfrom more operation on the result of the TEMP TABLE, which help in better understanding and reducing the long Quries.*/
Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM Alex..EmployeeDemographics emp
JOIN Alex..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee3

SELECT AvgAge * AvgSalary
from #temp_employee3

/* STRING FUNCTIONS - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER */


CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

/* TRIM - It is use to remove extra spaces from any side of the value */
SELECT EmployeeID, TRIM(EmployeeID) Trim_ID FROM EmployeeErrors

/* RTRIM - It is use to remove extra spaces from Right side of the value */
SELECT EmployeeID, RTRIM(EmployeeID) RTrim_ID FROM EmployeeErrors

/* LTRIM - It is use to remove extra spaces from Left side of the value */
SELECT EmployeeID, LTRIM(EmployeeID) LTrim_ID FROM EmployeeErrors

/* REPLACE - It's a function with 3 parameters, 
				1st - the name of the column, 
				2nd - the value which we want to replace, 
				3rd - the value with which we want to replace the string. */

SELECT LastName, REPLACE(LastName,'- Fired', '') LastNameFixed FROM EmployeeErrors

/* SUBSTRING */

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

/* UPPER & lower */

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors


/* STORED PROCEDURES - These are like function in programming, which we can execute again and again */

/* YOUTUBE CODE */

CREATE PROCEDURE Proc_Demo
AS
SELECT * FROM EmployeeDemographics

/* Excute the following to get the output */
EXEC Proc_Demo

/* GITHUB CODE */

/* When the CREATE PROCEDURE is at the top of the code just the way it is in GITHUB its not working properly, after EXEC is executed the output displays multiple table.*/
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee 
(JobTitle varchar(100), EmployeesPerJob int,
  AvgAge int, AvgSalary int)

Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM Alex..EmployeeDemographics emp
JOIN Alex..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

EXEC Temp_Employee

GO;

CREATE PROCEDURE Temp_Employee1
AS
--DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee1 
(JobTitle varchar(100), EmployeesPerJob int,
  AvgAge int, AvgSalary int)

Insert into #temp_employee1
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM Alex..EmployeeDemographics emp
JOIN Alex..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee1

EXEC Temp_Employee1

GO;


/* The following way is working properly */
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee 
( JobTitle varchar(100), EmployeesPerJob int,
  AvgAge int, AvgSalary int )

Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM Alex..EmployeeDemographics emp
JOIN Alex..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

CREATE PROCEDURE Temp_Employee
AS
Select * 
From #temp_employee


EXEC Temp_Employee

GO;



CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 
( JobTitle varchar(100), EmployeesPerJob int, 
  AvgAge int, AvgSalary int )


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM Alex..EmployeeDemographics emp
JOIN Alex..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- make sure to change this in this script from original above
group by JobTitle

Select * 
From #temp_employee3
GO;


exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'





