SparkSQL dataframe
RDD: we don’t have schema, with SparkSQL we have schema
SparkSQL dataframes stores data in RDD (think of a schema on top of RDD)


## Prepare: Read all the file from the directory **city_revenue** on HDFS

```
rdd = sc.wholeTextFiles('city_revenue/')
rdd.take(2)
rdd_formatted = rdd.map(lambda v: (v[0].split("/")[-1], v[1])) \
                   .map(lambda v: (v[0].split(".txt")[0], v[1]))\
                   .flatMapValues(lambda v: v.split("\r\n")) \
                   .map(lambda v: (v[0].split("_")[0], v[0], v[1].split(" ")[0], int(v[1].split(" ")[1])))
```

## Q1: Format (city, store, month, revenue):

```
%spark2.pyspark
df = spark.createDataFrame(rdd_formatted, ('City', 'Store', 'Month', 'Income'))
df.show(3)
```

now the data look like:

```
+----------+------------+-----+------+
|      City|       Store|Month|Income|
+----------+------------+-----+------+
|      lyon|        lyon|  JAN|    13|
|      lyon|        lyon|  FEB|    12|
|      lyon|        lyon|  MAR|    14|
...
```


## Q2: monthly average value from the whole shop

we have 301.583 as a result

```
from pyspark.sql import functions as F
#df_income = df.select(df.Income)
df_income = df.select(F.col('Income'))
print("Average per month of the the shop (all stores combined):")
df_sum=df_income.agg(F.sum(df_income.Income).alias('sum'))\
                .select((F.col('sum')/12).alias('Monthly average'))
df_sum.show()
```

## Q3: Total revenue of the city

```
print("Total revenue percity")
df_city = df.select(df.City, df.Income)

df_city_sum = df_city.groupBy(F.col('City')) \
                     .agg(F.sum('Income').alias('sum_income')) \
                     .orderBy(F.col('City'))
df_city_sum.show()
```

# Q4: Average per month per city
```
print("Average per month per city: ")
df_city_avg = df_city_sum.select(F.col('city'),(F.col('sum_income')/12).alias('sum_avg'))\
                     .orderBy(F.col('City'))
df_city_avg.show()
```

# Q5:Total revenue per store on the year
```
print("Total revenue per store on the year")
df_store = df.select(df.Store, df.Income)

df_store_sum = df_store.groupBy(F.col('Store')) \
                     .agg(F.sum('Income').alias('sum_income')) \
                     .orderBy(F.col('Store'))
df_store_sum.show()
```

# Q6: For each month, best store (most revenue): with sorted
```
df_max_month = df.select(df.Month, df.Income)\
            .groupBy(F.col('Month'))\
            .agg(F.max('Income').alias('max_income'))
            
df_store=df.select(df.Month,df.Income,df.Store)

df_max_month_join=df_max_month.join(df_store,((F.col('max_income')==F.col('Income')) & (df_max_month.Month==df_store.Month)))\
                                .select(df_store.Month,F.col('Store'),F.col('max_income'))\
                                .orderBy(F.unix_timestamp(df_store.Month, "MMM"))
df_max_month_join.show()
```


