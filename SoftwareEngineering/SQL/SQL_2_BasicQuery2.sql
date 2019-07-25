--DB: WideWorldImporters
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

/* Q10: DO WE HAVE CONSISTENCY OF PRICES BETWEEN THE UNITPRICE COLUMN IN INVOICELINES AND THE STOCKITEMS TABLE 
Extract all the StockItemID from InvoiceLines where the UnitPrice of the product is different from the StockItem table */

SELECT DISTINCT W.StockItemID, W.StockItemName, IL.UnitPrice as InvoicePrice, W.UnitPrice as WarehousePrice	
FROM Sales.InvoiceLines as IL,
	Warehouse.StockItems as W
WHERE W.StockItemID=IL.StockItemID	
AND W.UnitPrice<>IL.UnitPrice
ORDER BY StockItemID, InvoicePrice

