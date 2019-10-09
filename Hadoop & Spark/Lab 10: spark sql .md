Here we try to answer the questions for lab 5

1. Number of titles with duration superior than 2 hours.
2. Average duration of titles containing the string "world".
3. Average rating of titles having the genre "Comedy"
4. Average rating of titles not having the genre "Comedy"
5. Top 5 movies directed by Tarantino

## prepare data

```
%spark2.pyspark
from pyspark.sql import functions as F
```

```
url={"title_basics": "/tmp/imdb/title.basics.tsv",
    "title_rating":"/tmp/imdb/title.ratings.tsv",
    "title_crew": "/tmp/imdb/title.crew.tsv",
    "name_basics":"/tmp/imdb/name.basics.tsv"}
    
for name, url in url.items():
    globals()[name] = spark.read.load(url,
                        format="csv", 
                        sep="\t", 
                        inferSchema="true", 
                        header="true")

names=[title_basics,title_rating,title_crew,name_basics]
for i in names:
    i.show(10)
```
## Q1: Number of titles with duration superior than 2 hours.
```
count_2h=title_basics.filter(F.col('runtimeMinutes')>120)\
                    .agg(F.count('runtimeMinutes').alias('count over 2h'))
count_2h.show()
```

|count over 2h|
|-------------|
|        60446|

## Q2 Average duration of titles containing the string "world".
```
avg_duration=title_basics.filter(F.col('primaryTitle').contains("world"))\
                        .agg(F.avg('runtimeMinutes').alias('world avg duration'))
avg_duration.show()
```

|world avg duration|
|------------------|
| 43.58105263157895|



## Q3 Average rating of titles having the genre "Comedy"
```
comedy_rating=title_basics.filter(F.col('genres').contains("Comedy"))\
                .join(title_rating, (title_rating.tconst == title_basics.tconst))\
                .agg(F.avg('averageRating').alias("comedy average rating"))
comedy_rating.show()
```

|comedy average rating|
|---------------------|
|    6.970428788330588|


## Q4 Average rating of titles not having the genre "Comedy"
```
#or we can define a function
#def is_comedy(genres):
#    return('Comedy' in genres)

not_comedy_rating=title_basics.filter((F.col('genres').contains("Comedy"))!=True)\
                .join(title_rating, (title_rating.tconst == title_basics.tconst))\
                .agg(F.avg('averageRating').alias("comedy average rating"))
not_comedy_rating.show()
```
|comedy average rating|
|---------------------|
|    6.886042545766083|

## Top 5 movies directed by Quentin Tarantino
```
start_time = time.time()
a=title_crew.select(F.col('tconst'),F.explode(F.split(F.col('directors'),",")).alias("directors"))\
        .join(name_basics,name_basics.nconst == F.col('directors'))\
        .filter(F.col('primaryName')=="Quentin Tarantino")\
        .join(title_basics,title_basics.tconst==title_crew.tconst)\
        .filter(title_basics.titleType=="movie")\
        .join(title_rating,title_rating.tconst==title_crew.tconst)\
        .select(title_basics.primaryTitle, title_rating.averageRating)\
        .orderBy(title_rating.averageRating,ascending=False)
a.show(5)
end_time=time.time()
print("RunTime: "+ str(end_time-start_time))
```
optional: might be better performance:
```
start_time = time.time()
direct=name_basics.select(name_basics.nconst).filter(F.col('primaryName')=="Quentin Tarantino").collect()

#value=[r['nconst'] for r in direct]
value=direct[0]['nconst']
a=title_crew.filter(F.col('directors')==value[0])\
            .join(title_rating,title_rating.tconst==title_crew.tconst)\
            .join(title_basics,title_basics.tconst==title_crew.tconst)\
            .filter(title_basics.titleType=="movie")\
            .select(title_basics.primaryTitle, title_rating.averageRating)\
            .orderBy(title_rating.averageRating,ascending=False)

a.show(5)
end_time=time.time()
print("RunTime: "+ str(end_time-start_time))
```

|        primaryTitle|averageRating|
|--------------------|-------------|
|        Pulp Fiction|          8.9|
|Kill Bill: The Wh...|          8.8|
|    Django Unchained|          8.4|
|Inglourious Basterds|          8.3|
|      Reservoir Dogs|          8.3|


