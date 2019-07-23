--DB: WideWorldImporters

/* Q1: count the number of cities (Distinct) in the table: application cities*/
SELECT count(CityName) as NumberOfCities, COUNT(DISTINCT(CityName)) as DistinctCitiesNumber
FROM [Application].Cities

/* Q2: How could we hard-code a query
which levarages two rows as a resultset? */
--SELECT SUM(t.Col1) AS Sum1, AVG(t.Col3) as Avg3, COUNT(*) as cnt
SELECT*
FROM
(
	SELECT 
			1/9.0 AS Col1,  
			CONCAT('Hello ', 'dsti', 
				' learning sql') as Col2,
			3.6 as Col3
	UNION

	SELECT 
			10 AS Col1,  
			CONCAT('this is', ' NOT (hello)', 
				' FUN') as Col2,
			35.6 as Col3
) AS t
/* COMPARING TEXT WITH EXPLICIT CASE INSENSITIVITY AND REMOVAL OF TRAILING SPACES*/
WHERE LTRIM(RTRIM(UPPER(t.Col2))) LIKE RTRIM(UPPER('%hello%'))

/* (self Join) 
Q3: BillToCustomerId materialises the following business requirement:
Send the invoice not necessarility to the address of CustomerID
but of BillToCustomer 

Let's have the following resultset:
CustomerId, CustomerName, CustomerNameToInvoice
(not numeric value of BillToCustomerID)
*/
SELECT c1.CustomerID, c1.CustomerName, c2.CustomerName as CustomerToInvoice
FROM [Sales].Customers as c1,
	[Sales].Customers as c2
WHERE c1.BillToCustomerID=c2.CustomerID


/* Q4:
	Extract all the USB food flash drive products
	(without hard-coding the price of USB food flash drive - dessert 10 drive variety pack)
	1. More or equally expensive than 
		"USB food flash drive - dessert 10 drive variety pack"
	2. Less or equally expensive than:
		"USB food flash drive - dessert 10 drive variety pack"
	3. Desired output: StockItemId, Name, UnitPrice*/

SELECT s1.StockItemID,s1.StockItemName,s1.UnitPrice
FROM [Warehouse].StockItems as s1,
	 [Warehouse].StockItems as s2
WHERE 
	s2.StockItemName='USB food flash drive - dessert 10 drive variety pack'
	AND s1.StockItemName like 'USB%' 
	AND s1.UnitPrice<=s2.UnitPrice
	AND s1.StockItemID<>s2.StockItemID
ORDER BY UnitPrice,StockItemID

/* Q5: AVERAGE INVOICE AMOUNT FOR YEAR 2015
ResultSet: One Column, One Row
*/
--average by invoice line and by invoice
SELECT
(SELECT avg(IL.Quantity * IL.UnitPrice) 
FROM [Sales].Invoices as I,
	[Sales].InvoiceLines as IL
WHERE I.InvoiceID=IL.InvoiceID
	AND YEAR(InvoiceDate)=2015)as AvgIL2015,
(SELECT (SUM(IL.Quantity * IL.UnitPrice)/COUNT(Distinct(I.InvoiceID)))
FROM [Sales].Invoices as I,
	[Sales].InvoiceLines as IL
WHERE I.InvoiceID=IL.InvoiceID
	AND YEAR(InvoiceDate)=2015) as AvgI2015

/* Q6 INSPECTING DATA FOR POSSIBLE INCONSISTENCIES 
can we find invoices where the value of BillToCustomerID
is different from the value of the same attribute in the Customers table?
*/
SELECT I.InvoiceID,I.CustomerID,C.BillToCustomerID as CustomerBill, I.BillToCustomerID as InvoiceBill
FROM [Sales].Invoices as I,
	[Sales].Customers as C
WHERE I.CustomerID=C.CustomerID
	  AND C.BillToCustomerID<>I.BillToCustomerID
--try to create inconsistence and to check again
select *
from Sales.Customers
Where CustomerID = 832

UPDATE Sales.Customers
SET BillToCustomerID=1
Where CustomerID = 832
--try again above query
--SET it back
UPDATE Sales.Customers
SET BillToCustomerID=832
Where CustomerID = 832

/*Q7: PIVOTING ANG AGGREGATES COMPUTATION
This query must extract the total sales for the period
2013-2015, the years being in columns
resultset: one row, three columns
*/
--way 1
SELECT
	(SELECT SUM(IL.Quantity * IL.UnitPrice) 
	FROM [Sales].Invoices as I,
		[Sales].InvoiceLines as IL
	WHERE I.InvoiceID=IL.InvoiceID
		AND YEAR(InvoiceDate)=2013)as 'Sales 2013',
	(SELECT SUM(IL.Quantity * IL.UnitPrice) 
	FROM [Sales].Invoices as I,
		[Sales].InvoiceLines as IL
	WHERE I.InvoiceID=IL.InvoiceID
		AND YEAR(InvoiceDate)=2014)as 'Sales 2014',
	(SELECT SUM(IL.Quantity * IL.UnitPrice) 
	FROM [Sales].Invoices as I,
		[Sales].InvoiceLines as IL
	WHERE I.InvoiceID=IL.InvoiceID
		AND YEAR(InvoiceDate)=2015)as 'Sales 2015',
	

--way 2: like this we can do more calculations
SELECT	SUM(t.Sales2013) As Sales2013,
		SUM(t.Sales2014) As Sales2014,
		SUM(t.Sales2015) As Sales2015,
		AVG(t.Sales2013 + t.Sales2014 + t.Sales2015) as AvgSales,
		STDEV(t.Sales2013 + t.Sales2014 + t.Sales2015) as StDevSales 
FROM
(
	SELECT 
		SUM(il.UnitPrice * il.Quantity) as Sales2013,
		0 as Sales2014,
		0 as Sales2015
	FROM
		Sales.Invoices as i,
		Sales.InvoiceLines as il
	WHERE
		i.InvoiceID = il.InvoiceID
		AND YEAR(i.InvoiceDate) = 2013

	UNION

	SELECT 
	
		0 as Sales2013, 
		SUM(il.UnitPrice * il.Quantity) as Sales2014,
		0 as Sales2015
	FROM
		Sales.Invoices as i,
		Sales.InvoiceLines as il
	WHERE
		i.InvoiceID = il.InvoiceID
		AND YEAR(i.InvoiceDate) = 2014

	UNION

	SELECT 
	
		0 as Sales2013,
		0 as Sales2014,
		SUM(il.UnitPrice * il.Quantity) as Sales2015
	FROM
		Sales.Invoices as i,
		Sales.InvoiceLines as il
	WHERE
		i.InvoiceID = il.InvoiceID
		AND YEAR(i.InvoiceDate) = 2015
) as t

/*Q8: Identify all the orders which have not been converted into invoices*/
--Way 1: Not exist
SELECT  * 
FROM [Sales].Orders as o
WHERE NOT EXISTS
(
	SELECT *
	FROM [Sales].Invoices as I
	WHERE o.OrderID=I.OrderID
)

--Way 2: 
/*in SQL Join equivalent
A LEFT JOIN B      =     A LEFT OUTER JOIN B
A RIGHT JOIN B     =     A RIGHT OUTER JOIN B
A FULL JOIN B      =     A FULL OUTER JOIN B
A INNER JOIN B     =     A JOIN B*/
SELECT o.*
FROM [Sales].Orders as o
	Left OUTER Join [Sales].Invoices as i
	On o.OrderID=i.OrderID
WHERE i.OrderID IS NULL
	 

/*Q9: date format
-- CAREFUL WITH DATE COMPARISON USING STRING
-- EVEN WITH THE CORRECT FORMAT*/
SELECT *
FROM Sales.Customers
WHERE
	AccountOpenedDate >= '2013-01-01' 
	AND AccountOpenedDate <= '2013-02-01'

-- ISO SQL (YEAR, MONTH, DAY)
SELECT *
FROM Sales.Customers
WHERE
	YEAR(AccountOpenedDate) = 2013
	AND MONTH(AccountOpenedDate) = 1

--Using MSSQL convert function

DECLARE @UKDateFormat int;
SET @UKDateFormat=103;

SELECT*
FROM Sales.Customers
WHERE AccountOpenedDate Between convert(date, '01/01/2013', @UKDateFormat)
		AND convert(date, '01/02/2013', @UKDateFormat)

SELECT DATEDIFF(month, '2004-12-31 23:59:59.9999999', '2006-01-01 00:00:00.0000000');
SELECT CONVERT(date, '28/05/2019', 103)