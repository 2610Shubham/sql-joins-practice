# SQL Joins Practice Solutions

This repository contains a set of SQL queries designed to practice and understand different types of joins using a mock database schema. The schema includes three tables: `reviewers`, `series`, and `reviews`. Various real-world scenarios are solved using SQL queries, such as finding ratings, calculating averages, identifying inactive users, and more.

## Schema Overview

### Tables

- **`reviewers`**: Holds information about the reviewers.  
  **Columns**: `id`, `first_name`, `last_name`.

- **`series`**: Stores details of TV series.  
  **Columns**: `id`, `title`, `released_year`, `genre`.

- **`reviews`**: Links reviewers and series with a rating.  
  **Columns**: `id`, `rating`, `series_id`, `reviewers_id`.

### Relationships

- `reviews.series_id` → References `series.id`.  
- `reviews.reviewers_id` → References `reviewers.id`.

## SQL Questions and Solutions

### 1. Display Series Titles with Their Ratings
```sql
SELECT 
    title, rating
FROM
    series
    INNER JOIN reviews ON series.id = reviews.series_id;
```

### 2. Calculate Average Rating for Each Series
```sql
SELECT 
    title, ROUND(AVG(rating), 2) AS avg_rating
FROM
    series
    INNER JOIN reviews ON series.id = reviews.series_id
GROUP BY title
ORDER BY avg_rating;
```

### 3. Display Reviewers and Their Ratings
```sql
SELECT 
    first_name, last_name, rating
FROM
    reviewers
    INNER JOIN reviews ON reviewers.id = reviews.reviewers_id;
```

### 4. Find Series Without Reviews
```sql
SELECT 
    title
FROM
    series
    LEFT JOIN reviews ON series.id = reviews.series_id
WHERE
    rating IS NULL;
```


### 5. Average Rating Per Genre
```sql
SELECT 
    genre, ROUND(AVG(rating), 1) AS avg_rating
FROM
    series
    INNER JOIN reviews ON series.id = reviews.series_id
GROUP BY genre
ORDER BY avg_rating;

```


### 6. Reviewer Activity Summary
```sql
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
    LEFT JOIN reviews ON reviewers.id = reviews.reviewers_id
GROUP BY first_name , last_name;
```


### 7. Display Series Titles, Ratings, and Reviewer Names
```sql
SELECT 
    title,
    rating,
    CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM
    series
    INNER JOIN reviews ON series.id = reviews.series_id
    INNER JOIN reviewers ON reviewers.id = reviews.reviewers_id;
```


### 8. Find Ratings and Reviewer Names for Drama Genre Series
```sql
SELECT 
    rating, CONCAT(first_name, ' ', last_name) AS 'reviewer'
FROM
    reviewers
    INNER JOIN reviews ON reviewers.id = reviews.reviewers_id
    INNER JOIN series ON series.id = reviews.series_id
WHERE
    genre = 'Drama';
```


### 9. Find Highly Rated Series (Rating >= 4.5)
```sql
SELECT 
    title, rating
FROM
    series
    INNER JOIN reviews ON series.id = reviews.series_id
WHERE
    rating >= 4.5;
```
