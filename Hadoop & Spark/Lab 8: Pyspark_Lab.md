We would be use the city data in HDFS to answer below quetions

1) Format (city, store, month, revenue)
2) Average per month of the the shop (all stores combined)
3) Total revenue per city for the year
4) Average per month per city (on this 1 year data)
5) Total revenue per store on the year
6) For each month, best store (most revenue)

Step 1: Read all the file from the directory **city_revenue** on HDFS

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

1) Format (city, store, month, revenue):

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
