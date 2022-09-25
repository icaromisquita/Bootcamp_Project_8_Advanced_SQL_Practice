USE imdb_ijs;

/******
The Big Picture
******/

-- How many actors are there in the actors table?
select count(*) from actors a ;

-- How many directors are there in the directors table?
SELECT COUNT(*) 
FROM directors;

-- How many movies are there in the movies table?
SELECT
    COUNT(DISTINCT id) as movies_count
FROM 
    movies;
    
/******
Exploring the Movies
******/

-- From what year are the oldest and the newest 
-- movies? What are the names of those movies?
(SELECT name, year
FROM movies
ORDER BY year ASC
LIMIT 1)

UNION ALL

(SELECT name, year
FROM movies
ORDER BY year DESC
LIMIT 1);
-- other option
SELECT name, year
FROM movies
WHERE year = (SELECT MAX(year) FROM movies)
	OR year = (SELECT MIN(year) FROM movies);


-- What movies have the highest and the lowest ranks?
SELECT 
    name, `rank`
FROM
    movies
WHERE
    (`rank` = (SELECT MAX(`rank`) FROM movies) OR 
    `rank` = (SELECT MIN(`rank`) FROM movies))
ORDER BY `rank` DESC;


-- What is the most common movie title?
select name, count(name) from movies
group by name having count(name) > 1
order by count(name) desc limit 1;


/******
Understanding the Database
******/

-- Are there movies with multiple directors?
select movie_id, count(*) as quantity 
from movies_directors 
group by movie_id 
order by quantity desc;

-- SELECT movie_id, COUNT(director_id)
-- FROM movies_directors
-- GROUP BY movie_id
-- HAVING COUNT(director_id) > 1
-- ORDER BY 2 DESC;

-- What is the movie with the most directors?
-- Why do you think it has so many?
select * from movies where id=382052;

-- SELECT m.name, COUNT(md.director_id)
-- FROM movies_directors md
-- JOIN movies m
-- 	ON md.movie_id = m.id
-- GROUP BY movie_id
-- HAVING COUNT(director_id) > 1
-- ORDER BY 2 DESC;


-- On average, how many actors are listed by movie?
-- select avg(n_actors)
-- from (
-- 	select movie_id, count(distinct(actor_id)) as n_actors 
-- 	from roles
-- 	group by movie_id) as movies_n_actors;
-- another option
-- WITH actors_per_movie AS (
-- 	SELECT movie_id, COUNT(actor_id) AS no_actors
-- 	FROM roles
-- 	GROUP BY movie_id)
-- SELECT AVG(no_actors)
-- FROM actors_per_movie;
-- 11.4303
select avg(count)
from
    (select count(*) as count, movie_id 
    from roles
    group by movie_id) as counts;
   
   
-- Are there movies with more than one “genre”?
select movie_id, count(genre) from movies_genres
group by movie_id
order by count(genre) desc;

/******
Looking for specific movies
******/

-- Can you find the movie called “Pulp Fiction”?
	-- Who directed it?
SELECT name, first_name, last_name
FROM movies mov
JOIN movies_directors mov_dir ON mov.id = mov_dir.movie_id
JOIN directors dir ON dir.id = mov_dir.director_id
WHERE name IN ("Pulp Fiction", "Dolce Vita");

	-- Which actors where casted on it?
SELECT m.name, a.first_name, a.last_name
FROM actors a
JOIN roles r
	ON a.id = r.actor_id
JOIN movies m
	ON r.movie_id = m.id
WHERE m.name IN ("Pulp Fiction", "Dolce Vita");


-- When was the movie “Titanic” by James Cameron released?
SELECT m.name, m.year, d.first_name, d.last_name
FROM movies m
JOIN movies_directors md
    ON md.movie_id = m.id
JOIN directors d
    ON d.id = md.director_id
WHERE m.name = "Titanic" AND d.last_name = "Cameron";


/******
Actors and directors
******/

-- Who is the actor that acted more times as “Himself”?
SELECT first_name, last_name, COUNT(*) AS howmuch
FROM actors act
JOIN roles rol ON act.id = rol.actor_id
WHERE role = "himself"
GROUP BY last_name, first_name
ORDER BY howmuch DESC LIMIT 1;


-- What is the most common name for actors? 
select first_name, count(*) from actors
group by first_name
order by count(*) desc
limit 1;

WITH concat_names as (
	SELECT concat(first_name,' ',last_name) fullname
	from actors)
SELECT fullname, COUNT(fullname)
FROM concat_names
GROUP BY 1
ORDER BY 2 DESC;
/* # fullname, COUNT(fullname)
Shauna MacDonald, 7 */

/******
Analysing genders
******/

-- How many actors are male and how many are female?
-- Answer the questions above both in absolute and relative terms
SELECT gender , COUNT(gender) 
FROM actors
GROUP BY 1 WITH ROLLUP;

SELECT gender , 100 *COUNT(gender)/(SELECT COUNT(*) FROM actors) FROM actors
GROUP BY 1;


/******
Movies across time
******/

-- How many of the movies were released after the year 2000?
select count(*) from movies where year> 2000;

-- How many of the movies where released between the years 1990 and 2000?
SELECT COUNT(*) 
FROM  movies
WHERE year BETWEEN 1990 AND 2000;

-- Which are the 3 years with the most movies? How many movies were produced on those years?
SELECT year, COUNT(*) AS howmuch FROM movies
GROUP BY year
ORDER BY howmuch DESC 
LIMIT 3;

-- What are the top 5 movie genres?
SELECT 
    genre, COUNT(*) qty
FROM
    movies_genres
GROUP BY genre
ORDER BY qty DESC
LIMIT 5;

-- What are the top 5 movie genres before 1920?
SELECT genre, count(movie_id)
from movies_genres mg
JOIN movies m
    ON m.id = mg.movie_id
WHERE m.year < 1920
group by genre
order by count(movie_id) desc
limit 5;

-- What is the evolution of the top movie genres across
-- all the decades of the 20th century?
-- option 1: 
with genre_count_per_decade as (
	select rank() over (partition by decade order by movies_per_genre desc) ranking, genre, decade
from (SELECT 
    genre,
    FLOOR(m.year / 10) * 10 AS decade,
    COUNT(genre) AS movies_per_genre
FROM
    movies_genres mg
        JOIN
    movies m ON m.id = mg.movie_id
GROUP BY decade , genre) as a
)
select genre, decade
FROM genre_count_per_decade
WHERE ranking = 1;

-- option 2: 
-- select *, count(*) as count, (year-1900) div 10 * 10 as decade
-- from movies
-- join movies_genres
-- on movies.id = movies_genres.movie_id
-- where year between 1900 and 1999
-- group by decade, genre
-- order by decade;


/******
Putting it all together: names, genders, and time
******/

-- Has the most common name for actors changed over time?
-- Get the most common actor name for each decade in the XX century.
SELECT 
    decade, 
    first_name, 
    number_name
FROM 
    (SELECT 
        (ROUND(m.year/10,0)%10)+1  AS 'decade', 
        first_name,
        COUNT(first_name) AS number_name 
    FROM actors AS a
        JOIN roles AS r
            ON a.id = r.actor_id
        JOIN movies AS m
            ON r.movie_id=m.id
    WHERE m.year BETWEEN 1900 AND 1999
    GROUP BY 1,2
    ORDER BY 1,3 DESC) AS decade_genre
GROUP BY 1
HAVING number_name = MAX(number_name);
/* # decade, name, totals
1890, Petr, 26
1900, Florence, 180
1910, Harry, 1662
1920, Charles, 1009
1930, Harry, 2161
1940, George, 2128
1950, John, 2027
1960, John, 1823
1970, John, 2657
1980, John, 3855
1990, Michael, 5929
2000, Michael, 3914 */



-- How many movies had a majority of females among their cast?
-- Answer the question both in absolute and relative terms.

SELECT COUNT(movie_title)
FROM (select
  r.movie_id as movie_title,
  count(case when a.gender='M' then 1 end) as male_count,
  count(case when a.gender='F' then 1 end) as female_count
from roles r
JOIN actors a
    ON r.actor_id = a.id
GROUP BY r.movie_id) sub
WHERE female_count > male_count;
-- 50666 movies with more female actors than male (absolute)

SELECT
(SELECT COUNT(movie_title)
FROM (select
  r.movie_id as movie_title,
  count(case when a.gender='M' then 1 end) as male_count,
  count(case when a.gender='F' then 1 end) as female_count
from roles r
JOIN actors a
    ON r.actor_id = a.id
GROUP BY r.movie_id) sub
WHERE female_count > male_count)
/
(SELECT COUNT(DISTINCT(movie_id))
FROM roles)
-- 0.1687 17% of movies have more female actors than males (relative)




