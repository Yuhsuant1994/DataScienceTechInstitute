
# Map Reducer

We want to check what is the most used word in a e-book. We can either use YARN client or not.

## First try not to use the YARN Client

1. Get the document online, then put it into raw directory

`$ wget http://www.gutenberg.org/ebooks/16328.txt.utf-8`

`$ hdfs dfs -put 16328.txt.utf-8 raw/pg16328.txt`

2. Create a map python code

`$ vi map.py`

```
#!/usr/bin/env python
"""map.py"""

import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # split the line into words
    words = line.split()
    # increase counters
    for word in words:
        # write the results to STDOUT (standard output);
        # what we output here will be the input for the
        # Reduce step, i.e. the input for reducer.py
        #
        # tab-delimited; the trivial word count is 1
        print '%s\t%s' % (word, 1)
```
note: 
* to insert in vi `I` 
* to save and exit vi `Esc` then `shift`+`ZZ`, or `Ctrl`+`C`
* to delete lines `Esc`+`DD`

3. Run the map.py code and check the result

`$ chmod +x map.py` 

`$ cat pg16328.txt | /home/yu-hsuan.ting-dsti/map.py`

we can see that the result is not sorted, we need to sort it before we can perform the reduce code. (by the key)

`$ cat pg16328.txt | /home/yu-hsuan.ting-dsti/map.py | sort -k1 -n`

4. Now we create the reduce python code

`$ vi reduce.py`

```
#!/usr/bin/env python
"""reduce.py"""

from operator import itemgetter
import sys

current_word = None
current_count = 0
word = None

# input comes from STDIN
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()

    # parse the input we got from mapper.py
    word, count = line.split('\t', 1)

    # convert count (currently a string) to int
    try:
        count = int(count)
    except ValueError:
        # count was not a number, so silently
        # ignore/discard this line
        continue

    # this IF-switch only works because Hadoop sorts map output
    # by key (here: word) before it is passed to the reducer
    if current_word == word:
        current_count += count
    else:
        if current_word:
            # write result to STDOUT
            print '%s\t%s' % (current_word, current_count)
        current_count = count
        current_word = word

# do not forget to output the last word if needed!
if current_word == word:
    print '%s\t%s' % (current_word, current_count)
```

5. Run the reduce.py code and check the result

`$ chmod +x reduce.py`

`$ cat pg16328.txt | /home/yu-hsuan.ting-dsti/map.py | sort -k1 -n | /home/yu-hsuan.ting-dsti/reduce.py | sort -k2 -n`

we can then see the result is **the  2558**

## Now let's try the same code with YARN

1. run the above steps into yarn

```
$ yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar \
	-file /home/yu-hsuan.ting-dsti/map.py \
	-mapper /home/yu-hsuan.ting-dsti/map.py \
	-file /home/yu-hsuan.ting-dsti/reduce.py \
	-reducer /home/yu-hsuan.ting-dsti/reduce.py \
	-input /user/yu-hsuan.ting-dsti/raw/pg16328.txt \
	-output /user/yu-hsuan.ting-dsti/python-output    
```
2. chek the output

let's see the output file

`$ hdfs dfs -ls /user/yu-hsuan.ting-dsti/python-output`

there's a result file other then sucess

`$ hdfs dfs -cat /user/yu-hsuan.ting-dsti/python-output/part-00000 | sort -k2 -n`

the result is the same as above **the  2558**
