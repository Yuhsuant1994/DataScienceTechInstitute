# YARN 

We tried to execute a job (execute mapreduce example code) using YARN client from our edge node.

## 1. Try to find the file
`find / -name *hadoop-mapreduce-examples*`

`cd <path>`

`yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples.jar`

see the parameters

`yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-mapreduce-examples.jar pi 10 100`
