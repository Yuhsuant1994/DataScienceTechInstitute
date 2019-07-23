# SQL
## [SQL_1_BasicQuery1](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_1_BasicQuery1.sql)
DB: WideWorldImporters ([From SQL sample data base]( https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0))

* Q1: count the number of cities (Distinct) in the table: application cities

* Q2: How could we hard-code a query which levarages two rows as a resultset? 

* Q3: (self Join) BillToCustomerId materialises the following business requirement
  1. Send the invoice not necessarility to the address of CustomerID but of BillToCustomer
  2. Resultset: CustomerId, CustomerName, CustomerNameToInvoice (not numeric value of BillToCustomerID)

* Q4:	Extract all the USB food flash drive products
	1. More or equally expensive than 
		"USB food flash drive - dessert 10 drive variety pack"
	2. Less or equally expensive than:
		"USB food flash drive - dessert 10 drive variety pack"
	3. Resultset: StockItemId, Name, UnitPrice

* Q5: AVERAGE INVOICE AMOUNT FOR YEAR 2015 
  1. ResultSet: One Column, One Row

* Q6: INSPECTING DATA FOR POSSIBLE INCONSISTENCIES, can we find invoices where the value of BillToCustomerID is different from the value of the same attribute in the Customers table?

## [SQL_2_BasicQuery2](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_2_BasicQuery2.sql)
DB: WideWorldImporters ([From SQL sample data base]( https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0))

* Q7: PIVOTING ANG AGGREGATES COMPUTATION
  1. This query must extract the total sales for the period 2013-2015, the years being in columns
  2. Resultset: one row, three columns

* Q8: Identify all the orders which have not been converted into invoices 

* Q9: Date format playground

* Q10: DO WE HAVE CONSISTENCY OF PRICES BETWEEN THE UNITPRICE COLUMN IN INVOICELINES AND THE STOCKITEMS TABLE ?
  1. Extract all the StockItemID from InvoiceLines where the UnitPrice of the product is different from the StockItem table
