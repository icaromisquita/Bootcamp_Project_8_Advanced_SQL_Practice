USE imdb_ijs;

# How many actors are there in the actors table?
SELECT COUNT(id)
FROM actors;

# How many directors are there in the directors table?
SELECT COUNT(id)
FROM directors;

# How many movies are there in the movies table?
SELECT COUNT(id)
FROM movies;
		#Exploring the Movies
# From what year are the oldest and the newest movies? What are the names of those movies?
SELECT * FROM movies
WHERE year = (SELECT MIN(year) FROM movies)
        OR year = (SELECT MAX(year) FROM movies);
# OR
(SELECT name, year
FROM movies
ORDER BY year ASC
LIMIT 1)
UNION ALL
(SELECT name, year
FROM movies
ORDER BY year DESC
LIMIT 1);        

# What movies have the highest and the lowest ranks?
SELECT * FROM movies
WHERE 'rank' = (SELECT MIN('rank') FROM movies) 
    OR 'rank' = (SELECT MAX('rank') FROM movies)
ORDER BY 'rank' DESC;
# OR
SELECT 
    name, `rank`
FROM
    movies
WHERE
    (`rank` = (SELECT MAX(`rank`) FROM movies) OR `rank` = (SELECT MIN(`rank`) FROM movies))
ORDER BY `rank` DESC;

# What is the most common movie title?
select name, count(name) from movies
group by name having count(name) > 1
order by count(name) desc limit 1;

		# Understanding the Database
# Are there movies with multiple directors?
select movie_id, count(*) as quantity 
from movies_directors 
group by movie_id 
order by quantity desc;
	-- OR 
SELECT * ,count(md.director_id) AS "number of directors"
FROM movies AS m
JOIN movies_directors AS md
ON  m.id = md.movie_id
group by m.id
HAVING count(md.director_id) > 1
order by count(md.director_id) desc;

# What is the movie with the most directors? Why do you think it has so many?
SELECT
    name, movie_id, COUNT(director_id) as nr_directors
FROM 
    movies_directors
JOIN 
    movies ON movies_directors.movie_id=movies.id
GROUP BY 
    movie_id
ORDER BY
    nr_directors DESC
LIMIT 1;

# On average, how many actors are listed by movie?
select avg(n_actors)
from
(select movie_id, count(distinct(actor_id)) as n_actors 
from roles
group by movie_id) as movies_n_actors;
	-- OR

# Are there movies with more than one “genre”?
SELECT *
FROM movies_genres
LEFT JOIN movies ON movies_genres.movie_id=movies.id
GROUP BY name;

#Can you find the movie called “Pulp Fiction”?
SELECT *
FROM movies
WHERE name = "Pulp Fiction";

	#Who directed it?
SELECT  movies.name AS Film, directors.first_name, directors.last_name
FROM movies_directors
JOIN movies ON movies.id = movies_directors.movie_id
JOIN directors ON movies_directors.director_id = directors.id
WHERE movies.name = "Pulp Fiction";

	#Which actors where casted on it?
SELECT *
FROM movies
JOIN roles ON movies.id = roles.movie_id
JOIN actors ON roles.actor_id = actors.id
WHERE movies.name = "Pulp Fiction";
    
#Can you find the movie called “La Dolce Vita”?
SELECT *
FROM movies
WHERE name LIKE "La D% V%";
	#Who directed it?
	#Which actors where casted on it?
    
#When was the movie “Titanic” by James Cameron released?
#Hint: there are many movies named “Titanic”. We want the one directed by James Cameron.
#Hint 2: the name “James Cameron” is stored with a weird character on it.  
SELECT m.name, m.year, d.first_name, d.last_name
FROM movies m
JOIN movies_directors md
    ON md.movie_id = m.id
JOIN directors d
    ON d.id = md.director_id
WHERE m.name = "Titanic" AND d.last_name = "Cameron";  

	-- Actors and Directors
    
# Who is the actor that acted more times as “Himself”?
SELECT first_name, last_name, COUNT(*) AS howmuch
FROM actors AS act
JOIN roles AS rol ON act.id = rol.actor_id
WHERE role = "himself"
GROUP BY last_name, first_name
ORDER BY howmuch DESC LIMIT 1;

# What is the most common name for actors? And for directors?
select first_name, count(*) from actors
group by first_name
order by count(*) desc
LIMIT 1;

	-- Analysing Genders

# How many actors are male and how many are female?
SELECT gender , COUNT(gender) FROM actors
GROUP BY 1 WITH ROLLUP;

	-- OR
SELECT 
    nr_male, 
    nr_female, 
    (nr_male / (nr_male + nr_female)) AS percentage_male, 
    (nr_female / (nr_male + nr_female)) AS percentage_female
FROM ((SELECT COUNT(id) AS nr_male
    FROM actors
    WHERE gender = "M") AS nr_male,
    (SELECT COUNT(id) AS nr_female
    FROM actors
    WHERE gender = "F") AS nr_female);    

# What percentage of actors are female, and what percentage are male?
SELECT gender , 100 *COUNT(gender)/(SELECT COUNT(*) FROM actors) FROM actors
GROUP BY 1;

	-- Movies across time
    
# How many of the movies were released after the year 2000?
SELECT  COUNT(name) As NEWMovies 
FROM movies
WHERE year > 2000;

# How many of the movies where released between the years 1990 and 2000?
SELECT  COUNT(name) As 90Movies 
FROM movies
WHERE year BETWEEN 1990 and 2000;

# Which are the 3 years with the most movies? How many movies were produced on those years?
SELECT year, COUNT(*) AS howmuch FROM movies
GROUP BY year
ORDER BY howmuch DESC LIMIT 3;
# What are the top 5 movie genres?

	# What are the top 5 movie genres before 1920?
SELECT 
    genre, COUNT(*) qty
FROM
    movies_genres
GROUP BY genre
ORDER BY qty DESC
LIMIT 5;
	# What is the evolution of the top movie genres across all the decades of the 20th century?
/*
SELECT genre, count(movie_id)
from movies_genres mg
JOIN movies m
    ON m.id = mg.movie_id
WHERE m.year < 1920
group by genre
order by count(movie_id) desc
limit 5;
	-- OR
select *, count(*) as count, (year-1900) div 10 * 10 as decade
from movies
join movies_genres
on movies.id = movies_genres.movie_id
where year between 1900 and 1999
group by decade, genre
order by decade; 
*/  
	-- Putting it all together: names, genders and time
# Has the most common name for actors changed over time?
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

# Get the most common actor name for each decade in the XX century.

# Re-do the analysis on most common names, splitted for males and females.
# How many movies had a majority of females among their cast?
# What percentage of the total movies had a majority female cast?
