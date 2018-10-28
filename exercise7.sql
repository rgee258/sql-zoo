# 1. 1962 movies

SELECT id, title
 FROM movie
 WHERE yr=1962;

# 2. When was Citizen Kane released?

SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

# 3. Star Trek movies

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%';

# 4. id for actor Glenn Close

SELECT id
FROM actor
WHERE name = 'Glenn Close';

# 5. id for Casablanca

SELECT id
FROM actor
WHERE name = 'Glenn Close';

# 6. Cast list for Casablanca

SELECT name
FROM casting JOIN actor ON casting.actorid = actor.id
WHERE casting.movieid = 11768;

# 7. Alien cast list

SELECT name
FROM casting JOIN actor ON casting.actorid = actor.id
JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Alien';

# 8. Harrison Ford movies

SELECT title
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

# 9. Harrison Ford as a supporting actor

SELECT title
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
AND casting.ord <> 1;

# 10. Lead actors in 1982 movies

SELECT movie.title, actor.name
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962
AND casting.ord = 1;

# 11. Busy years for John Travolta

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

# 12. Lead actor in Julie Andrews movies

SELECT movie.title, actor.name
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE casting.movieid IN
(SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))
AND casting.ord = 1;

# 13. Actors with leading roles

SELECT actor.name
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(movie.id) >= 30;

# 14.

SELECT movie.title, COUNT(actor.id)
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY COUNT(actor.id) DESC, title;

# 15.

SELECT actor.name
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name <> 'Art Garfunkel'
AND casting.movieid IN
(SELECT movie.id
FROM casting JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Art Garfunkel');