# Hive Query 

table information: https://www.imdb.com/interfaces/

`> show tables;`-- to see all the tables

IMDB Queries: 

1) Number of titles with duration superior than 2 hours.

`> SELECT COUNT(*) FROM imdb_title_basics WHERE runtimeminutes > 120;`

2) Average duration of titles containing the string "world".

`> SELECT AVG(runtimeminutes) FROM imdb_title_basics WHERE primaryTitle LIKE "%world%";`

3) Average rating of titles having the genre "Comedy"

```
>SELECT AVG(averagerating) FROM imdb_title_ratings
JOIN imdb_title_basics ON imdb_title_ratings.tconst = imdb_title_basics.tconst
WHERE array_contains(imdb_title_basics.genres, "Comedy");
```


4) Average rating of titles not having the genre "Comedy"

```
>SELECT AVG(averagerating) FROM imdb_title_ratings
JOIN imdb_title_basics ON imdb_title_ratings.tconst = imdb_title_basics.tconst
WHERE NOT array_contains(imdb_title_basics.genres, "Comedy");
```


Bonus:
5) Top 5 movies directed by Tarantino
