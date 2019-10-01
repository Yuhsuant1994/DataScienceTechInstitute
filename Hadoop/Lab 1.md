## 1. Create a directory called raw inside your HDFS home directory.

`hdfs dfs -mkdir raw`

## 2. Download the most frequently downloaded e-book 

(in Plain Text UTF-8) from Project Gutenberg. and put it inside the directory.

* 2.1 download the file to the edge node

either use the file system Like **File Zilla**

or command from edge `wget Pride_and_Prejudict.txt http://www.gutenberg.org/files/1342/1342-0.txt` or `curl -0 Pride_and_Prejudict.txt http://www.gutenberg.org/files/1342/1342-0.txt`

check if the file is downloaded `ls <-lah>`

* 2.2 Put the file from the edge to directory and rename it:

`hdfs dfs -put  Pride_and_Prejudict.txt   raw/` 

## 3. Copy the file inside your HDFS hom directory to input.txt

`hdfs dfs -cp raw/Pride_and_Prejudict.txt .` + `hdfs dfs -mv Pride_and_Prejudict.txt input.txt`

or

`hdfs dfs -cp raw/Pride_and_Prejudict.txt ./input.txt`


(note: that `-put` is from the edge to the HDFS and `-cp` is the HDFS copy internally)

## 4. Read the input.txt

`hdfs dfs -cat input.txt`

## 5. Remove the (-f is force, -R recursive)

`hdfs dfs -rm -skipTrash input.txt `

## 6. List my home directory 

`hdfs dfs -ls `

## 7. Retrieve the file from the raw directory from HDFS to the local filesystem and rename it local.txt.

`hdfs dfs -get raw/Pride_and_Prejudict.txt local.txt`

or

`hdfs dfs -cat  raw/Pride_and_Prejudict.txt > local2.txt`



