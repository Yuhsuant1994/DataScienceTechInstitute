# Hadoop lab

## [Lab 1: HDFS](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%201:%20HDFS.md)

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

## [Lab 2: YARN](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%202:%20YARN%20.md)

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

## [Lab 3: Map-Reducer](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%203:%20Map-Reducer%20.md)

We want to check what is the most used word in a e-book.

- With only python code
- Use YARN client to execute the job

## [Lab 4: Hive table (from CSV file)](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%204:%20Hive%20table%20(from%20CSV).md)

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

