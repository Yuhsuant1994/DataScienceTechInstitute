# Hadoop lab

## [Lab 1: HDFS](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop%20%26%20Spark/Lab%201:%20HDFS.md)

* Download the most frequently downloaded e-book (in Plain Text UTF-8) from Project Gutenberg.
* Create a directory called raw inside your HDFS home directory.
* Put the downloaded e-book inside this directory. 
* Create a copy directly inside your HDFS home directory.
* Rename the copy inside your HDFS home directory to input.txt.
* Read directly from HDFS the input.txt file.
* Remove this file (careful with this command).
* List your HDFS home directory.
* Retrieve the fule from the raw directory from HDFS to the local filesystem and rename it local.txt.

```
HDFS main component:

* NameNode
* DataNode
```

## [Lab 2: YARN](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop%20%26%20Spark/Lab%202:%20YARN%20.md)

We tried to execute a job (execute mapreduce example code) using YARN client from our edge node.

```
YARN main components:

1. Client: submits jobs to Resource Manager
2. Resource Manager (RM): resource assignment
  * Scheduler: support plug in such as capacity Scheduler
  * Application manager:
3. Node Manager (NM): monitor resource usage, log management, responsible for creating the container process and start it on the request of Application Master
4. Application Master (AM):  (it is a special container) 
  * Negotiating resources with the resource manager.
  * Request the container from the node manager
  * Once the application start it sends the health report to the resource manager from time to time
5. Container:
```

## [Lab 3: Map-Reducer](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop%20%26%20Spark/Lab%203:%20Map-Reducer%20.md)

We want to check what is the most used word in a e-book.

- With only python code
- Use YARN client to execute the job

## [Lab 4: Hive table (from CSV file)](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop%20%26%20Spark/Lab%204:%20Hive%20table%20(from%20CSV).md)

* connect to hive
* create an external table from a local directory
* create an internal table using hive sql to extract data from external table

## [Lab 5: Hive query](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%205:%20Hive%20query.md)

using [IMDB](https://www.imdb.com/interfaces/) data to query

1) Number of titles with duration superior than 2 hours.
2) Average duration of titles containing the string "world".
3) Average rating of titles having the genre "Comedy"
4) Average rating of titles not having the genre "Comedy"
5) Top 5 movies directed by Tarantino

### to kill the application

if we made some mistake in our query want to stop the application we can check what is running.

`yarn app -list`

we can see the application like application_157000...2_23, select the one you want to kill

`yarn app -kill application_157000...2_0176`

## Lab 6: HBase

Random access (like ram) column store system

CAP theorem (a data base is at most 2 of the 3)
*	Consistant **-Hbase** (wait for sync)
*	Availability (get the result before sync)
*	Partition tolerant **-Hbase**

Schema:

1. Write data: 

 * client writes **WAL** to HDFS 
 * It would go to the MemStore (Region server in memory) 
 * Then it would be flash to HDFS HFile

2. Insert Data: put in the table on row key

3. Read Data

 * client would read the data 
 * RS fetch the data from HFile 
 * Then it would return to the client with optimization. (when we fetch the data from the block, the region server would take the block and put it in RAM block cache because it assum you would query around the same data very soon)

4. 4 kinds of file generated: 

* **WAL:** store the modified data (to HDFS)
* **Memstore:** before storing to HDFS
* **HFile:** Finally file store to HDFS
* **Block Cache:** when reading the data, it would also store a copy to ram

5. HBase Compontent:

* HBase master: create table, region assignment
* Region servers: answering the query to the client, can split the region when it's too big. 
* ZooKeeper: for high availability (have to be odd number generally 3 to vote for who is the active master with all the standby master)

6. Query HBase

* HBase Shell
* Apache Phoneix (OLTP)-> allows ACID transaction
* Hive (OLAP)

7. example query

* `create 'dsti_rating', 'opinion', 'metadata'` : table name + columns family
* `put 'dsti_rating', '<rowkey>','opinion:vote','8','metadata:tsonst','t23'` : how to set up row key. it has to be unique and should be related to your frequent query, so it is usefull when it store in **Block cache**. For example: tconst+vote+username (t748xavier, t749victor, t749mary)
* `put 'dsti_rating', '<rowkey>','opinion:vote','9','metadata:tsonst','t23'`: to update just to put and use the same rowkey

## [Lab 7: Pyspark_WordCount](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop%20%26%20Spark/Lab%205:%20Hive%20query.md)

Performing word count as in lab 3 using pyspark

## [Lab 8: Pyspark_Lab]

We would be use the city data in HDFS to answer below quetions

1) Format (city, store, month, revenue)
2) Average per month of the the shop (all stores combined)
3) Total revenue per city for the year
4) Average per month per city (on this 1 year data)
5) Total revenue per store on the year
6) For each month, best store (most revenue)
