# SQL: MSSQL
## [SQL_1_BasicQuery1](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_1_BasicQuery1.sql)
DB: WideWorldImporters ([From SQL sample database]( https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0))

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
DB: WideWorldImporters ([From SQL sample database]( https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0))

* Q7: PIVOTING ANG AGGREGATES COMPUTATION
  1. This query must extract the total sales for the period 2013-2015, the years being in columns
  2. Resultset: one row, three columns

* Q8: Identify all the orders which have not been converted into invoices 

* Q9: Date format playground

* Q10: DO WE HAVE CONSISTENCY OF PRICES BETWEEN THE UNITPRICE COLUMN IN INVOICELINES AND THE STOCKITEMS TABLE ?
  1. Extract all the StockItemID from InvoiceLines where the UnitPrice of the product is different from the StockItem table

## [SQL_3_Transaction (default and snapshot)](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_3_Transaction.sql)

DB: irissql ([see database folder](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL/DataBase))

Scenario 1: (default)
--- 
* Open 2 query at the same time
* Query 1: `Begin transaction` -> delete data
* Query 2: `Begin transaction` -> select deleted data from Query 1, or even select all -> non stop loading
* Query 1: `ROLLBACK` 
* Query 2: see the result

*During the transaction, if the data is updated, inserted or deleted, it would block other transactions to view the table*

Scenario 2: (snaspshot)
---
* Open 2 query at the same time
* Query 1: `SET TRANSACTION ISOLATION LEVEL SNAPSHOT` -> `Begin transaction` -> delete data
* Query 2: `Begin transaction` -> select deleted data from Query 1, or even select all -> we can see the result
* Query 1: `COMMIT`
* Query 2: select again the deleted data -> not be able to seen anymore

*SET TRANSACTION ISOLATION LEVEL SNAPSHOT: disabled by default in MSSQL for space preservation reason. We can change it in the database `property`->`option`->`miscellaneous`->`allow snapshot Isolation & is read committed snapshot on`*

## [SQL_4_Extract all by NOT EXISTS](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_4_Extract_all_by_NOT_EXISTS.sql)

* EXTRACT ALL THE CUSTOMERS WHO HAVE BOUGHT (been invoiced) ALL THE PRODUCTS (StockItems)

DB: WideWorldImporters ([From SQL sample data base]( https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0))

*first part of the code, no data would return, therefore we build a simple database to check if the code is correct*

DB: Sqlplayground_s19 ([see database folder](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL/DataBase))

## [SQL_5_PivotingSurveyTable](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_5_PivotingSurveyTable.sql)

DB: NOT PROVIDED 

Tables (For SQL 5 and 6)
* Answer (`QuestionID`,`SurveyID`,`UserID`,`Answer`)
* User (`UserID`,`UserName`,`UserEmail`)
* SurveyStructure (`SurveyID`,`QuestionID`,`OrdinalValue`)

Expected result table:

| UserID | SurveyID | Q1 | Q2 |
|---|---|---|---|
|X|1|1|10|
|Y|1|2|5|
|Z|3|1|50|

## [SQL_6_Programmatic_SQL](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL/SQL_6_Programmatic_SQL)

1. Query: Generate Random Users in the user table (using GUID) [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_6_Programmatic_SQL/SQL_6.1_QueryGenerateRandomUser.sql)
2. Stored Procedure: Generate Random Users [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_6_Programmatic_SQL/SQL_6.2_ProcedureGenerateRandomUser.sql)
3. Stored Procedure: Generate Random Answer [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_6_Programmatic_SQL/SQL_6.3_ProcedureGenerateRandomAnswer.sql)
4. Dynamic Generate Answer Table (reference as [SQL_5_PivotingSurveyTable](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL#sql_5_pivotingsurveytable)) [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_6_Programmatic_SQL/SQL_6.4_DynamicGenerateAnswerTable.sql)

## [SQL_7_Trigger](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL/SQL_7_Trigger)

DB: S19SQLPlayground_student ([see database folder](https://github.com/Yuhsuant1994/DataScienceTechInstitute/tree/master/SoftwareEngineering/SQL/DataBase))

* Trigger (one row at a time): StudentNumberGeneration (expected result: `year of cohort`, `last / max sequence nb in the database for this year`+1) [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_7_Trigger/SQL_7.1_TriggerOneStudentNumber.sql)
* Trigger (multiple row): ): StudentNumberGeneration (expected result: `year of cohort`, `last / max sequence nb in the database for this year`+1) [[code]](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/SQL/SQL_7_Trigger/SQL_7.2_TriggerMultiStudentNumber.sql)



