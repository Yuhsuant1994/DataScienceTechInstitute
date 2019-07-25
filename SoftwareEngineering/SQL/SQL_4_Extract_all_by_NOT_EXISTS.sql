/* EXTRACT ALL THE CUSTOMERS WHO HAVE BOUGHT (been invoiced) ALL THE PRODUCTS (StockItems) */

/* PART 1
DB: WideWorldImporters*/
SELECT * --C.CustomerID, C.CustomerName 
FROM Sales.Customers as C
WHERE NOT EXISTS(
	SELECT *
	FROM Warehouse.StockItems as S
	WHERE NOT EXISTS(
		SELECT *
		FROM Sales.InvoiceLines as IL
			,Sales.Invoices as I
		WHERE I.InvoiceID=IL.InvoiceID
			AND S.StockItemID=IL.StockItemID
			AND C.CustomerID=I.CustomerID)
			)

/* PART 2
DB: Sqlplayground_s19*/
SELECT * --C.CustomerID, C.CustomerName 
FROM Customer as C
WHERE NOT EXISTS(
	SELECT *
	FROM Product as PR
	WHERE NOT EXISTS(
		SELECT *
		FROM Purchase as PU
		WHERE C.CustomerId=PU.CustomerId
		AND PR.ProductId=PU.ProductId)
			)

