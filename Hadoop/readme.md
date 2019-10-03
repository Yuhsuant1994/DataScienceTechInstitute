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

HDFS main component:

* NameNode
* DataNode

## [Lab 2: YARN](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%202:%20YARN%20.md)

We tried to execute a job (execute mapreduce example code) using YARN client from our edge node.

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

## [Lab 3: Map-Reducer](https://github.com/Yuhsuant1994/DataScienceTechInstitute/blob/master/Hadoop/Lab%203:%20Map-Reducer%20.md)

We want to check what is the most used word in a e-book.

- With only python code
- Use YARN client to execute the job
