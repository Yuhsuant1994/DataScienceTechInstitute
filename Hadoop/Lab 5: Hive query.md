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

5) Top 5 movies directed by Tarantino

```
SELECT basic.primarytitle, rating.averagerating 
FROM 
    (SELECT * FROM imdb_title_crew 
    LATERAL VIEW explode(director) exp as ndir) as crew
    JOIN imdb_name_basics as name ON crew.ndir=name.nconst
    JOIN imdb_title_ratings as rating on rating.tconst=crew.tconst   
    JOIN imdb_title_basics as basic on basic.tconst=crew.tconst
WHERE 
    name.primaryname="Quentin Tarantino"
    AND basic.titletype="movie"
ORDER BY rating.averagerating DESC
LIMIT 5;
```

|         basic.primarytitle          | rating.averagerating  |
|-------------------------------------|-----------------------|
| Pulp Fiction                        | 8.9                   |
| Kill Bill: The Whole Bloody Affair  | 8.8                   |
| Django Unchained                    | 8.4                   |
| Reservoir Dogs                      | 8.3                   |
| Inglourious Basterds                | 8.3                   |
