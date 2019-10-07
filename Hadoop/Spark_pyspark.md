## for word count

* ` %spark2.pyspark ` -on top, it would know it’s a pyspark
* sc: spark content, take would take each line as one element
```
%spark2.pyspark
rdd_book = sc.textFile('data/alice.txt')
rdd_book.take(5)
```

* take a line and split to words to array, flatMap, we don’t want array, we want each elements inside the array. If it’s Map then it’s array
```
%spark2.pyspark
rdd_words = rdd_book.flatMap(lambda line: line.split())
rdd_words.take(20)
```

* Now we transform all the word to (word,1)
```
rdd_one = rdd_words.map(lambda word: (word, 1))
rdd_one.take(20)
```

* Add them together by the reduce process
```
rdd_count = rdd_one.reduceByKey(lambda v1,v2: v1+v2)
rdd_count.take(20) 
```

* Because we want to sort by the value, so we should inverse key and value
* sort by key descending
```
rdd_count.map(lambda v: (v[1], v[0])) \
         .sortByKey(False) \
         .take(20)
```


