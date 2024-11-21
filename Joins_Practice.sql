CREATE TABLE reviewers (
	id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL, 
    last_name VARCHAR(100) NOT NULL, 
    CONSTRAINT pk_id PRIMARY KEY(id)
);

CREATE TABLE series (
	id INT NOT NULL AUTO_INCREMENT, 
    title VARCHAR(100), 
    released_year YEAR, 
    genre VARCHAR(100), 
    CONSTRAINT pk_id PRIMARY KEY(id)
);

CREATE TABLE reviews (
	id INT NOT NULL AUTO_INCREMENT, 
    rating DECIMAL(2,1), 
    series_id INT, 
    reviewers_id INT,
    CONSTRAINT fk_series_id FOREIGN KEY(series_id) REFERENCES series(id),
    CONSTRAINT fk_reviewers_id FOREIGN KEY(reviewers_id) REFERENCES reviewers(id), 
    CONSTRAINT PK_id PRIMARY KEY(id)
);

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
INSERT INTO reviews(series_id, reviewers_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    

-- 1. Display Series Titles with Their Ratings
SELECT 
    title, rating
FROM
    series
        INNER JOIN
    reviews ON series.id = reviews.series_id;
    
-- 2. Calculate Average Rating for Each Series
SELECT 
    title, ROUND(AVG(rating), 2) AS avg_rating
FROM
    series
        INNER JOIN
    reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;
    
    
-- 3. Display Reviewers and Their Ratings
SELECT 
    first_name, last_name, rating
FROM
    reviewers
        INNER JOIN
    reviews ON reviewers.id = reviews.reviewers_id;
    
-- 4. Find Series Without Reviews 
SELECT 
    title
FROM
    series
    LEFT JOIN reviews ON series.id = reviews.series_id
WHERE
    rating IS NULL;
    
    
-- 5. Average Rating Per Genre
SELECT 
    genre, ROUND(AVG(rating), 1) AS avg_rating
FROM
    series
        INNER JOIN
    reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;

-- 6. Reviewer Activity Summary
SELECT 
    first_name,
    last_name,
    COUNT(rating) AS 'COUNT',
    IFNULL(MAX(rating), 0) AS 'MAX',
    IFNULL(MIN(rating), 0) AS 'MIN',
    IFNULL(ROUND(AVG(rating), 1), 0) AS 'AVG',
    CASE
        WHEN COUNT(rating) = 0 THEN 'INACTIVE'
        ELSE 'ACTIVE'
    END AS STATUS
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewers_id
GROUP BY first_name , last_name;


-- 7. Display Series Titles, Ratings, and Reviewer Names
SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM
    series
        INNER JOIN
    reviews ON series.id = reviews.series_id
        INNER JOIN
    reviewers ON reviewers.id = reviews.reviewers_id;
    
-- 8. Find Ratings and Reviewer Names for Drama Genre Series
SELECT 
    rating, CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM
    reviewers
        INNER JOIN
    reviews ON reviewers.id = reviews.reviewers_id
        INNER JOIN
    series ON series.id = reviews.series_id
WHERE
    genre = 'Drama';
    
    
-- 9. Find Highly Rated Series (Rating >= 4.5)
SELECT 
    title, rating
FROM
    series
        INNER JOIN
    reviews ON series.id = reviews.series_id
WHERE
    rating >= 4.5;
    
