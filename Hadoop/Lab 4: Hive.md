LABL CSV ingestion

1.	on HDFS create a driver folder

`$ hdfs dfs -mkdir drivers `

2.	put the drivers.csv in it (in /tmp)

`$ hdfs dfs -put /tmp/drivers.csv drivers `

3.	connect to hive server

`$ beeline -u "jdbc:hive2://zoo-1.au.adaltas.cloud:2181,zoo-2.au.adaltas.cloud:2                                                                                181,zoo-3.au.adaltas.cloud:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperName                                                                                space=hiveserver2;" --showDbInPrompt=true`

4.	create external table

`$ hive`

switch to dsti database

`> use dsti;`

```
>CREATE EXTERNAL TABLE drivers_YuHsuan
(driverId INT, name STRING,   ssn INT,   location STRING,   certified STRING,   wageplan STRING)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
STORED AS textfile
LOCATION "/user/yu-hsuan.ting-dsti/drivers";
```

show if your table created successfully

`> show tables;`

