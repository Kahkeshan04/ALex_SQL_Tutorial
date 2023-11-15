--/* INTERMEDIATE */

--Insert into EmployeeDemographics VALUES
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')


--Create Table WareHouseEmployeeDemographics 
--( EmployeeID int, FirstName varchar(50), 
--  LastName varchar(50), Age int, Gender varchar(50) )

--Insert into WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')

--Insert into EmployeeSalary VALUES
--(1010, NULL, 47000),
--(NULL, 'Salesman', 43000)


--/* JOINS - INNER, FULL/LEFT/RIGHT OUTER JOIN */
--/* A JOIN is a way to combine multiple tables into a single output */

--/* INNER JOIN - Display everything that matches eaxctly in two tables column. 
--   In the following example it matches EmployeeID of two tables */
--SELECT * FROM Alex.dbo.EmployeeDemographics
--Inner Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* FULL OUTER JOIN - Display everything that is present in two tables column. 
--   In the following example it displays the missing values of EmployeeID of two tables as NULL. 
--   That means there are values for that row in one table and missing in other table. */
--SELECT * FROM Alex.dbo.EmployeeDemographics
--Full Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* LEFT OUTER JOIN - Display everything that is present in Left table column. 
--   The first table mentioned in the qurey will be Left table and the second table will be Right table.
--   In the following example it displays the missing values of EmployeeID of Right table(EmployeeSalary) as NULL. 
--   That means there are values for that row in Left table(EmployeeDemographics) and are missing in Right table(EmployeeSalary). */
--SELECT * FROM Alex.dbo.EmployeeDemographics
--Left Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* Right Outer Join - Display everything that is present in Right table column. 
--   The first table mentioned in the qurey will be Left table and the second table will be Right table.
--   In the following example it displays the missing values of EmployeeID of Left table(EmployeeDemographics) as NULL. 
--   That means there are values for that row in Right table(EmployeeSalary) and are missing in Left table(EmployeeDemographics). */
--SELECT * FROM Alex.dbo.EmployeeDemographics
--Right Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--/* RIGHT OUTER JOIN with sepcific column names 

--   The following is not correct because we have two fields with column name EmployeeID one in each table and we have to specify which EmployeeID we want? */
--SELECT EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Right Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* The following is correct one. 
--   In the below qurey as we are using EmployeeDemographics.EmployeeID and Right Outer Join. 
--   In the result it's showing everything(all the rows) from Right table(EmployeeSalary) but as we have selected EmployeeDemographics.EmployeeID in the select statement, the missing ID's in EmployeeDemographics.EmployeeID (after comparision with EmployeeSalary.EmployeeID) will be diaplyed as NULL.
--   Example: We have 11 rows in EmployeeSalary(Right table) so the result will also have 11 rows in Right Outer Join.
--			See the ID's - 1010 which is present in the Right table (EmployeeSalary) but missing in the Left table (EmployeeDemographics).
--			As we have selected EmployeeDemographics.EmployeeID in the select statement the missing ID is displayed as NULL.*/
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Right Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--select * from EmployeeDemographics
--select * from EmployeeSalary

--/* In this as we are using EmployeeSalary.EmployeeID and Right Outer Join. 
--   In the result it's showing everything(all the rows) from Right table(EmployeeSalary) but as we have selected EmployeeSalary.EmployeeID in the select statement, the missing ID's in EmployeeDemographics.EmployeeID (after comparision) will be overpaled by EmployeeSalary.EmployeeID.
--   Example: We have 11 rows in EmployeeSalary(Right table) so the result will also have 11 rows in Right Outer Join.
--			See the ID's - 1010 which is present in the Right table (EmployeeSalary) but missing in the Left table (EmployeeDemographics).
--			As we have selected EmployeeSalary.EmployeeID in the select statement the missing ID in EmployeeDemographics.EmployeeID is overlapped with the ID of EmployeeSalary.EmployeeID.*/
--SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Right Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
 
--/* LEFT OUTER JOIN with sepcific column names
   
--   In the below qurey as we are using EmployeeDemographics.EmployeeID and Left Outer Join. 
--   In the result it's showing everything(all the rows) from Left table(EmployeeDemographics) but as we have selected EmployeeDemographics.EmployeeID in the select statement, the missing ID's in EmployeeSalary.EmployeeID (after comparision) will be overpaled by EmployeeDemographics.EmployeeID.
--   Example: We have 12 rows in EmployeeDemographics(Left table) so the result will also have 12 rows in Left Outer Join.
--			See the ID's - 1011 which is present in the Left table (EmployeeDemographics) but missing in the Left table (EmployeeSalary).
--			As we have selected EmployeeDemographics.EmployeeID in the select statement the missing ID in EmployeeSalary.EmployeeID is overlapped with the ID of EmployeeDemographics.EmployeeID.
--			And the other columns of the EmployeeSalary table with missing values are dispalyed as NULL.*/
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Left Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--select * from EmployeeDemographics
--select * from EmployeeSalary

--/* In the below qurey as we are using EmployeeSalary.EmployeeID and Left Outer Join. 
--   In the result it's showing everything(all the rows) from Left table(EmployeeDemographics) but as we have selected EmployeeSalary.EmployeeID in the select statement, the missing ID's in EmployeeSalary.EmployeeID (after comparision with EmployeeDemographics.EmployeeID) will be diaplyed as NULL.
--   Example: We have 12 rows in EmployeeDemographics(Left table) so the result will also have 12 rows in Left Outer Join.
--			See the ID's - 1011 which is present in the Left table (EmployeeDemographics) but missing in the Right table (EmployeeSalary).
--			As we have selected EmployeeSalary.EmployeeID in the select statement the missing ID and the other columns of the EmployeeSalary table with missing values are displayed as NULL.*/
--SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Left Outer Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* INNER JOIN with sepcific column

--   In the below qurey as we are using EmployeeSalary.EmployeeID and Inner Join. 
--   In the result it's showing everything - all the rows which has common values.
--   Example: We have 9 rows in EmployeeDemographics(Left table) with the same values as EmployeeSalary(Right table), hence it dispalyed all those rows.
--     Here as we have compared EmployeeID's of both table so the values from both EmployeeID's will be only compared.*/
--SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Inner Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--/* In the below qurey as we are using EmployeeDemographics.EmployeeID and Inner Join.
--   It's same as above no change */
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM Alex.dbo.EmployeeDemographics
--Inner Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--/* SUMMARY:
--	In the query we have compared EmployeeID's so in the 

--		- Right Outer Join with EmployeeDemographics.EmployeeID (Left table) the values from the Right table Column (i.e., EmployeeSalary table) will be picked and compared to Left table (EmployeeDemographics) and all the missing values in all the columns of EmployeeDemographics table (Left table) will be displayed as NULL.

--		- Right Outer Join with EmployeeSalary.EmployeeID (Right table) the values from the Right table Column (i.e., EmployeeSalary table) will be picked and compared to Left table (EmployeeDemographics)and all the missing values in all the columns of EmployeeDemographics table (Left table) will be overlaped with the values of Right table (EmployeeSalary).

--		- Left Outer Join with EmployeeDemographics.EmployeeID (Left table) the values from the Left table Column (i.e., EmployeeDemographics table) will be picked and compared to Right table (EmployeeSalary) and all the missing values in all the columns of EmployeeSalary table (Right table) will be overlaped with the values of Right table (EmployeeSalary).

--		- Left Outer Join with EmployeeSalary.EmployeeID (Right table) the values from the Left table Column (i.e., EmployeeDemographics table) will be picked and compared to Right table (EmployeeSalary) and all the missing values in all the columns of EmployeeSalary table (Right table) will be displayed as NULL.

--		- Inner Join with EmployeeSalary.EmployeeID (Right table) OR EmployeeDemographics.EmployeeID (Left table) the values all columns of both table will be dispalyed if the EmployeeID's are present in both table.
--*/


--/* USE CASE:

--1- Robert California is pressuring Micheal Scott to meet his quarterly quota and Michael Scott is almost there he needs like a thousand more dollars and he come up with the genius idea to deduct pay for the highest paid employee at his branch bedides himself 
--*/
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
--FROM Alex.dbo.EmployeeDemographics 
--Inner Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE FirstName <> 'Michael'
--ORDER BY Salary DESC

--/* 2- Kevin Malone who is an accountant thinks that he may have made a mistake when looking at the average salary for out salesmen now Angela Martin is very good at SQL and so what she is gonna do is she want to go in and calculate the average salary for our salesmen */

--SELECT JobTitle, AVG(Salary) AS AvgSalary
--FROM Alex.dbo.EmployeeDemographics 
--Inner Join Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'
--GROUP BY JobTitle

--/* UNION, UNION ALL */

--/*The following query with two tables having same number of columns and their types is showing NULL in the missing places. 
--  We cannot overlap all the columns in JOINS. 
--  That can be done with the help of UNION */
--select * from alex.dbo.employeeDemographics
--full outer join alex.dbo.warehouseemployeedemographics
--on employeedemographics.employeeid = warehouseemployeedemographics.employeeid

--/* UNION - Combines two tables, overlap all the missing values from both table with the values present the other table.
--   This UNION displayes only uniques values from both the tables.*/

--SELECT * FROM Alex.dbo.EmployeeDemographics
--UNION
--SELECT * FROM Alex.dbo.WareHouseEmployeeDemographics

--/* UNION ALL- Combines two tables, overlap all the missing values from both table with the values present the other table.
--   If we want to display all the values along with duplicate values then we have to use UNION ALL */
--SELECT * FROM Alex.dbo.EmployeeDemographics
--UNION ALL
--SELECT * FROM Alex.dbo.WareHouseEmployeeDemographics

--/* UNION & UNION ALL - Can combine all the column with the same type. 
--   Here type of the column and number of the column in both table matters. */

--SELECT EmployeeID, FirstName, Age FROM Alex.dbo.EmployeeDemographics
--UNION
--SELECT * FROM Alex.dbo.EmployeeSalary

--/* CASE STATEMENT */

--SELECT FirstName, LastName, Age, 
--CASE
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Baby'
--END AS Category
--FROM Alex.dbo.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age

--/* The order of the conditions are important in CASE STATEMENTS.
--   When the first condition is met it skips all the below condition even though the condition is satisfied.
--   In the following qurey Stanley is still displayed as Old because the first condition (Age > 30) is statisfied and hence the other condition (Age = 38) is skipped even though it is true.*/
--SELECT FirstName, LastName, Age, 
--CASE
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age = 38 THEN 'Stanley'
--	ELSE 'Baby'
--END AS Category
--FROM Alex.dbo.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age


--/* In the following query the category of Stanley is change*/
--SELECT FirstName, LastName, Age, 
--CASE	
--	WHEN Age = 38 THEN 'Stanley'
--	WHEN Age > 30 THEN 'Old'
--	ELSE 'Baby'
--END AS Category
--FROM Alex.dbo.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age


--/* USE CASE:

--We had a fantastic year, this year selling paper and corporate has allowed Michael Scott to give out a yearly raise to every single employee, but not every employee is gonna get the same raise because the salesman are genuinely the people who made us our money and they're gonna get the biggest raises and other people really aren't gonna get into that big of a raise */

--/* JOIN = INNER JOIN */
--SELECT FirstName, LastName, JobTitle, Salary,
--CASE
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary*.10)
--	WHEN JobTitle = 'Accountant' THEN Salary + (Salary*.07)
--	WHEN JobTitle = 'Supplier Relations' THEN Salary + (Salary*.04)
--	ELSE Salary + (Salary*.02)
--END AS RaisedSalary
--FROM Alex.dbo.EmployeeDemographics
--JOIN Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--/* HAVING CLAUSE */

--/* The following query display error because we cannot use the aggregate function (COUNT Function) with the WHERE Statement, We need to use a HAVING CLAUSE */
--SELECT JobTitle, COUNT(JobTitle)
--FROM Alex.dbo.EmployeeDemographics
--JOIN Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE COUNT(JobTitle) > 1
--GROUP BY JobTitle

--/* HAVING CLAUSE is completely depended on the GROUP BY Statement, hence GROUP BY needs to be right above HAVING CLAUSE */
--SELECT JobTitle, COUNT(JobTitle)
--FROM Alex.dbo.EmployeeDemographics
--JOIN Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--HAVING COUNT(JobTitle) > 1
--GROUP BY JobTitle


--SELECT JobTitle, COUNT(JobTitle)
--FROM Alex.dbo.EmployeeDemographics
--JOIN Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 1

--SELECT JobTitle, AVG(Salary)
--FROM Alex.dbo.EmployeeDemographics
--JOIN Alex.dbo.EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) > 45000


--SELECT * FROM Alex.dbo.WareHouseEmployeeDemographics

--/* UPDATE */

--UPDATE Alex.dbo.EmployeeDemographics
--SET EmployeeID = 1012
--WHERE FirstName = 'Holly' AND LastName = 'Flax'
 
-- /* Multiple UPDATES at a time */

--UPDATE Alex.dbo.EmployeeDemographics
--SET Age = 31, Gender = 'Female'
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--/* DELETE - Once Deleted cannot retrive */

--DELETE FROM Alex.dbo.EmployeeSalary
--WHERE EmployeeID = 1010

--/* ALIASING - It is temporarily changing the column name or the table name in your script and it's not really gonna impact your output at all.
--  It is really usefull for the readability of your script.
--  It is important to give an ALIAS which can show what kind of work that column or table is doing for easy understanding.
--  Giving irrelavant ALIAS as 'a', 'x', etc will confuse both, the other person viewing it and the future you.*/

--/* ALIASING Column Name */

--SELECT FirstName AS FName 
--FROM Alex.dbo.EmployeeDemographics

--/* Even with just space it will be same as with AS */
--SELECT FirstName FName 
--FROM Alex.dbo.EmployeeDemographics

--/* The ALIAS name cannot have space in between */
--SELECT FirstName + ' ' + LastName Full Name 
--FROM Alex.dbo.EmployeeDemographics

--SELECT FirstName + ' ' + LastName Full_Name 
--FROM Alex.dbo.EmployeeDemographics

--/* ALIASING Table Name */

--SELECT Demo.FirstName FName, Sal.JobTitle 
--FROM Alex.dbo.EmployeeDemographics AS Demo
--JOIN Alex.dbo.EmployeeSalary AS Sal 
--ON Demo.EmployeeID = Sal.EmployeeID

--/* LEFT JOIN is basically LEFT INNER JOIN */

--SELECT Demo.EmployeeID, Sal.JobTitle, Ware.Age
--FROM Alex.dbo.EmployeeDemographics AS Demo
--LEFT JOIN Alex.dbo.EmployeeSalary AS Sal
--ON Demo.EmployeeID = Sal.EmployeeID
--LEFT JOIN Alex.dbo.WareHouseEmployeeDemographics AS Ware
--ON Ware.Age = Demo.Age

--/* PARTITION BY - It is often compared to GROUP BY Statement.
--   The GROUP BY Statement is a little bit different.
--   It is going to reduce the number of rows in our output by actually rolling them up and then calculating the sums or averages for each group.
--   Where as PARTITION BY actually divides the result set into partitions and changes how the window function is calculated and so the PARTITION BY doesn't actually reduce the number of rows returned in our output.*/

--/* In the following query it shows how many females are working inculding 'Pam' and same for rest of the employees.
--   There are 2 more female ('Angela','Meredith') working along with 'Pam', so the output is 3. */
--SELECT FirstName, LastName, Gender, COUNT(Gender) OVER (PARTITION BY Gender) Total_Gender, Salary
--FROM Alex..EmployeeDemographics Demo
--JOIN Alex..EmployeeSalary Sal
--ON Demo.EmployeeID = Sal.EmployeeID

--/* Trying the get the same output as above with GROUP BY. */

--SELECT FirstName, LastName, Gender, COUNT(Gender) TGender, Salary
--FROM Alex..EmployeeDemographics Demo
--JOIN Alex..EmployeeSalary Sal
--ON Demo.EmployeeID = Sal.EmployeeID
--GROUP BY FirstName, LastName, Gender, Salary

--SELECT Gender, COUNT(Gender) TGender
--FROM Alex..EmployeeDemographics Demo
--JOIN Alex..EmployeeSalary Sal
--ON Demo.EmployeeID = Sal.EmployeeID
--GROUP BY Gender