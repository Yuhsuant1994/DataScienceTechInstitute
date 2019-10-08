We would be use the city data in HDFS to answer the quetions

## Prepare: Read all the file from the directory **city_revenue** on HDFS

```
%spark2.pyspark
rdd=sc.wholeTextFiles("city_revenue")
rdd.take(3)
```

we can see that the value is store as 

* key: file 
* value: row value in the file as array

```
[(u'/user/yu-hsuan.ting-dsti/city_revenue/lyon.txt', u'JAN 13\r\nFEB 12\r\nMAR 14\r\nAPR 15\r\nMAY 12\r\nJUN 15\r\nJUL 19\r\nAUG 25\r\nSEP 13\r\nOCT 11\r\nNOV 22\r\nDEC 22'), 
(u'/user/yu-hsuan.ting-dsti/city_revenue/marseilles_1.txt', u'JAN 21\r\nFEB 21\r\nMAR 21\r\nAPR 27\r\nMAY 25\r\nJUN 25\r\nJUL 21\r\nAUG 22\r\nSEP 23\r\nOCT 28\r\nNOV 24\r\nDEC 26'), 
(u'/user/yu-hsuan.ting-dsti/city_revenue/marseilles_2.txt', u'JAN 11\r\nFEB 11\r\nMAR 11\r\nAPR 17\r\nMAY 12\r\nJUN 25\r\nJUL 21\r\nAUG 22\r\nSEP 23\r\nOCT 28\r\nNOV 24\r\nDEC 26')]
```

## Q1: Format (city, store, month, revenue):

```
%spark2.pyspark
rdd_store=rdd.map(lambda v:((v[0].split("/")[-1].split(".")[0].split("_")[0],\
                            v[0].split("/")[-1].split(".")[0]),\
                            v[1].split("\r\n")))
rdd_store.take(3)
```

now the data look like:

```
[((u'lyon', u'lyon'), [u'JAN 13', u'FEB 12', u'MAR 14', u'APR 15', u'MAY 12', u'JUN 15', u'JUL 19', u'AUG 25', u'SEP 13', u'OCT 11', u'NOV 22', u'DEC 22']), 
((u'marseilles', u'marseilles_1'), [u'JAN 21', u'FEB 21', u'MAR 21', u'APR 27', u'MAY 25', u'JUN 25', u'JUL 21', u'AUG 22', u'SEP 23', u'OCT 28', u'NOV 24', u'DEC 26']), 
((u'marseilles', u'marseilles_2'), [u'JAN 11', u'FEB 11', u'MAR 11', u'APR 17', u'MAY 12', u'JUN 25', u'JUL 21', u'AUG 22', u'SEP 23', u'OCT 28', u'NOV 24', u'DEC 26'])]
```

then we can use the `flatMapValues` to transform the array into different rows (note that the flatMapValues take key pairs)

```
%spark2.pyspark
rdd_final=rdd_store.flatMapValues(lambda v: v).\
    map(lambda v: (v[0][0],v[0][1],v[1].split(" ")[0],v[1].split(" ")[1]))
rdd_final.take(3)
```
final result looks like this

```
[(u'lyon', u'lyon', u'JAN', u'13'), 
(u'lyon', u'lyon', u'FEB', u'12'), 
(u'lyon', u'lyon', u'MAR', u'14')]
```

## Q2: monthly average value from the whole shop

we have 301.583 as a result

```
rdd_month_average=rdd_final.map(lambda v: ("France",v[3])).\
                reduceByKey(lambda v1,v2: float(v1)+float(v2)).\
                map(lambda v: v[1]/12)
rdd_month_average.take(1)
```


## Q2_1: total monthly revenue of the whole shop

```
rdd_month_sum=rdd_final.map(lambda v:(v[2],v[3])).\
            reduceByKey(lambda v1,v2: int(v1)+int(v2))
rdd_month_sum.take(30)
```

result: 

```
[(u'FEB', 249), (u'AUG', 300), (u'APR', 263), (u'JUN', 362), (u'JUL', 282),(u'JAN', 270), 
(u'MAY', 292), (u'NOV', 319), (u'MAR', 228), (u'DEC', 377), (u'OCT', 345), (u'SEP', 332)]
```
# Q3: Total revenue of the city

```
rdd_city_sum=rdd_final.map(lambda v:(v[0],v[3])).\
            reduceByKey(lambda v1,v2: int(v1)+int(v2))
#rdd_city_sum.take(10)
print 'Total revenue per city per year : ' 
for k in rdd_city_sum.sortByKey("True").collect():
    print k[0] + ' : ' + str(k[1])
```
result:
```
Total revenue per city per year : 
anger : 166
lyon : 193
...
```
# Q4: Average per month per city
```
#Q4 Average per month per city
rdd_city_month=rdd_city_sum.map(lambda v: (v[0],v[1]/12.0))
#rdd_city_month.take(10)
print 'Average monthly income of the shop in each city (on a 1 year data) : '
for v in rdd_city_month.sortByKey("TRUE").collect():
    print v[0] + ' : ' + str(v[1])
```
result:
```
Average monthly income of the shop in each city (on a 1 year data) : 
anger : 13.8333333333
lyon : 16.0833333333
...
```
# Q5:Total revenue per store on the year
```
rdd_store_sum=rdd_final.map(lambda v:(v[1],v[3]))\
    .reduceByKey(lambda v1,v2: int(v1)+int(v2))
rdd_store_sum.take(10)
```
result:
```
[(u'troyes', 214), (u'lyon', 193), (u'toulouse', 177), (u'marseilles_2', 231), (u'anger', 166), 
(u'paris_3', 330), (u'paris_1', 596), (u'orlean', 196), (u'marseilles_1', 284), (u'rennes', 180)]
```
# Q6: For each month, best store (most revenue)
```
test=rdd_final.map(lambda v: (v[2],(int(v[3]),v[1])))\
    .reduceByKey(lambda v1,v2: max(v1,v2))
test.take(20)
```
or
```
test=rdd_final.map(lambda v: (v[2],(int(v[3]),v[1]))).reduceByKey(lambda v1,v2: v1 if v1[0] > v2[0] else v2)
test.take(20)
```
result:
```
[(u'FEB', (42, u'paris_2')), (u'AUG', (45, u'paris_2')), (u'APR', (57, u'paris_1')), (u'JUN', (85, u'paris_2')), 
(u'JUL', (61, u'paris_1')), (u'JAN', (51, u'paris_1')), (u'MAY', (72, u'paris_2')), (u'NOV', (64, u'paris_2')), 
(u'MAR', (44, u'paris_2')), (u'DEC', (71, u'paris_1')), (u'OCT', (68, u'paris_1')), (u'SEP', (63, u'paris_2'))]
```

# Q6.1 sort the data
```
months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC']

for month in months:
  print(month + ' best seller with ' +  str(test.lookup(month)[0][0]) + ' is ' + test.lookup(month)[0][1])
```
result
```
JAN best seller with 51 is paris_1
FEB best seller with 42 is paris_2
...
```


