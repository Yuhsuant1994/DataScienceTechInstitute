# YARN 

We tried to execute a job (execute mapreduce example code) using YARN client from our edge node.

## 1. Try to find the file

`$ find /usr -name *hadoop-mapreduce-examples*`

## 2. go to the file path

`$ cd /usr/hdp/current/hadoop-mapreduce-client`


## 3. execute the java code using yarn client

`$ yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples.jar`

here we can check the parameters

## 4. we execute the job with the parameters

`$ yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples.jar pi 10 100`

`$ Number of Maps  = 10
Samples per Map = 100`

## summary steps

*	We submit a job to Resource manager
*	Application manager save the HDFS in the Data Node (Node Manager and Data Node 2 service on the same node) 
*	Container created to run the job and execute the java code 
*	Container log would go back to the application manager store in HDFS

