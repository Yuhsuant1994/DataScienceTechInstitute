import pandas as pd
import revoscalepy as revoscale 
import time
#used as DB Connection framework, in MSSQL Python env

def DoInMemoryDivision_SQLPlayground():
    start_time=time.time()
    #define the strings for connection
    conn_str = 'Driver=SQL Server;Server=<your server>;Database=S19SQLPlayground;Trusted_Connection=True;'
    customer_query='''SELECT * FROM dbo.Customer;'''
    product_query='''SELECT * FROM dbo.Product;'''
    purchase_query='''SELECT * FROM dbo.Purchase;'''

    #try connection and write query to build the dataframe
    connected=True
    try:
        cu_data_source = revoscale.RxSqlServerData(sql_query=customer_query,connection_string=conn_str)
        pr_data_source = revoscale.RxSqlServerData(sql_query=product_query,connection_string=conn_str)
        pu_data_source = revoscale.RxSqlServerData(sql_query=purchase_query,connection_string=conn_str)
        revoscale.RxInSqlServer(connection_string=conn_str, num_tasks=1, auto_cleanup=False)
        customer_data = pd.DataFrame(revoscale.rx_import(cu_data_source))
        product_data = pd.DataFrame(revoscale.rx_import(pr_data_source))
        purchase_data = pd.DataFrame(revoscale.rx_import(pu_data_source))
    except:
        print("Cannot connect to DataBase and create the data table, existing...")
        connected=False
    if connected==False:
        exit(0)

    #iterate 3 tables, either add a new entry to the custExistence dictionary or update the count
    custExistence={}
    for cu_index, cu_row in customer_data.iterrows():
        for pr_index, pr_row in product_data.iterrows():
            for pu_index, pu_row in purchase_data.iterrows():
                if pu_row["CustomerId"] == cu_row["CustomerId"] and pu_row["ProductId"] == pr_row["ProductId"]:
                    currentcustomer=pu_row["CustomerId"]
                    if currentcustomer in custExistence:
                        custExistence[currentcustomer]+=1
                    else:
                        custExistence[currentcustomer]=1
    #print(custExistence)

    #Count all the product (count the row)
    nbProducts=product_data.shape[0]
    #print(nbProducts)

    #print out the customer who has bought all the products
    for customerid in custExistence:
        if custExistence[customerid]==nbProducts:
            print("CustomerId : "+str(customerid))

    end_time=time.time()
    print("This took "+str(end_time-start_time)+" s")

                    

DoInMemoryDivision_SQLPlayground()
