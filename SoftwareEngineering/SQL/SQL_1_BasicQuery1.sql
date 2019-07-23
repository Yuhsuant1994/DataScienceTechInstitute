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
