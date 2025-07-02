create database netflix_proejct;
use netflix_proejct;
select * from proejcet;
-- 1. Count the number of Movies vs TV Shows
SELECT type, COUNT(*) AS count
FROM proejcet
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows
SELECT type, rating, COUNT(*) AS count
FROM proejcet
GROUP BY type, rating
ORDER BY type, count DESC;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT * 
FROM proejcet
WHERE type = 'Movie' AND release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix
SELECT country, COUNT(*) AS total
FROM proejcet
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
LIMIT 5;

-- 5. Identify the longest movie (based on duration in minutes)
SELECT title, duration
FROM proejcet
WHERE type = 'Movie' AND duration LIKE '%min'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;

-- 6. Find content added in the last 5 years
SELECT * 
FROM proejcet
WHERE date_added IS NOT NULL
  AND YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) >= YEAR(CURDATE()) - 5;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'
SELECT * 
FROM proejcet
WHERE director = 'Rajiv Chilaka';

-- 8. List all TV shows with more than 5 seasons
SELECT * 
FROM proejcet
WHERE type = 'TV Show'
  AND duration LIKE '%Seasons'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;

-- 9. Count the number of content items in each genre
SELECT listed_in, COUNT(*) AS count
FROM proejcet
GROUP BY listed_in
ORDER BY count DESC;

-- 10. Find each year and the average number of content releases in India. Return top 5 years
SELECT release_year, COUNT(*) AS total
FROM proejcet
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;

-- 11. List all movies that are documentaries
SELECT * 
FROM proejcet
WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%';

-- 12. Find all content without a director
SELECT * 
FROM proejcet
WHERE director IS NULL OR TRIM(director) = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years
SELECT COUNT(*) AS count
FROM proejcet
WHERE type = 'Movie'
  AND cast LIKE '%Salman Khan%'
  AND release_year >= YEAR(CURDATE()) - 10;

-- 14. Find top 10 actors who have appeared in the highest number of movies produced in India
-- (simple version: using the 'cast' column directly)
SELECT cast, COUNT(*) AS appearances
FROM proejcet
WHERE type = 'Movie' AND country LIKE '%India%' AND cast IS NOT NULL
GROUP BY cast
ORDER BY appearances DESC
LIMIT 10;

-- 15. Categorize content as 'Bad' if description contains 'kill' or 'violence', otherwise 'Good'
SELECT 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' OR LOWER(description) LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS content_label,
    COUNT(*) AS total
FROM proejcet
GROUP BY content_label;
