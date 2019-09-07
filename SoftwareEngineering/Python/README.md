# Python

[1. Concept](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/Python/Python_1_Concept.py)
* Dynamic object
* Initial Constructors 
* Class attribute vs. instance attribute
* method: list, dictionary, generator

[2.Math functions](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/Python/Python_2_math.py)
*	Quadratic solver
*	Factorial: interactive vs recursive

[3. 2DGeometry And Overload](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/Python/Python_3_2DGeometryAndOverload.py)
2DGeometry of **Point2D, StraightLine and LineSegment**, with overloading class 
*	`__init__`  (and copy constructor)
*	`__str__`
*	`__new__`
*	`__eq__`

[4. Connect Python to MSSQL server for Query](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/Python/Python_4_PythonConnectMSSQL.py)
[database to add to your MSSQL server](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/SoftwareEngineering/Python/S19SQLPlayground.bak)

This code, we tried to find the customer who has bought all the product from purchase table (there's customer, product and purchase table).

Steps:
* we connect to the MSSQL server to S19SQLPlayground Database. 
* Write query to store the data into Pandas dataframe. 
* Iterate over the 3 tables created in order to count How many purchase they have made
* Compute total product number
* Print the customerID who have brought all the product
* Calculate the method exucation time
