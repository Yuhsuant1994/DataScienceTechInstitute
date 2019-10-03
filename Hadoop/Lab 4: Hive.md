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
>CREATE EXTERNAL TABLE IF NOT EXISTS drivers_yuhsuan(
	driverId INT,
	name STRING,
	ssn STRING,
	location STRING,
	certified STRING,
	wage_plan STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
location '/user/yu-hsuan.ting-dsti/drivers'
tblproperties ("skip.header.line.count"="1");
```

show if your table created successfully

`> show tables;`

select * from drivers_yuhsuan;

