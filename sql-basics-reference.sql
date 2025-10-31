-- ============================================================================
-- SQL BASICS - COMPREHENSIVE REFERENCE GUIDE
-- A complete guide to SQL fundamentals with detailed explanations
-- Author: Tanuj Puri
-- Course: SQL Basics Tutorial
-- Last Updated: 2025
-- ============================================================================

-- ============================================================================
-- SECTION 1: BASIC DATA RETRIEVAL
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1.1 SELECT Basics
-- ----------------------------------------------------------------------------
-- The SELECT statement is used to retrieve data from a database.
-- The asterisk (*) retrieves all columns from the specified table.

-- Retrieve all columns and all rows from the movies table
SELECT * FROM movies;

-- Retrieve only specific columns (title and industry) from movies table
-- This is more efficient than SELECT * when you don't need all columns
SELECT title, industry FROM movies;

-- Retrieve title and release year columns
-- Use this approach to get only the data you need, improving query performance
SELECT title, release_year FROM movies;

-- ----------------------------------------------------------------------------
-- 1.2 WHERE Clause - Text Filtering
-- ----------------------------------------------------------------------------
-- The WHERE clause filters rows based on specified conditions.
-- Only rows that meet the condition will be returned in the result set.

-- Filter rows where the industry column exactly matches "Hollywood"
-- String comparisons in SQL are case-insensitive by default in MySQL
SELECT * FROM movies WHERE industry = "Hollywood";

-- Filter rows where the industry is "Bollywood"
SELECT * FROM movies WHERE industry = "Bollywood";

-- Find a specific movie by its exact title
-- Returns only the row(s) where title is exactly "The Godfather"
SELECT * FROM movies WHERE title = "The Godfather";

-- ----------------------------------------------------------------------------
-- LIKE Operator - Pattern Matching
-- ----------------------------------------------------------------------------
-- The LIKE operator is used for pattern matching in string columns.
-- % is a wildcard that matches any sequence of characters (including zero characters)
-- _ matches exactly one character

-- Find all movies where title starts with "THOR"
-- The % after THOR means "followed by anything"
SELECT * FROM movies WHERE title LIKE 'THOR%';

-- Find all movies that contain the word "America" anywhere in the title
-- The % before and after means "anything before and after"
-- This will match "Captain America", "America's Got Talent", etc.
SELECT * FROM movies WHERE title LIKE '%America%';

-- Find all movies with "Avenger" in the title
-- Useful for finding all Avengers movies
SELECT * FROM movies WHERE title LIKE '%Avenger%';

-- ----------------------------------------------------------------------------
-- Handling Empty and NULL Values
-- ----------------------------------------------------------------------------
-- Empty string ('') and NULL are different in SQL
-- '' is an actual value (empty text), NULL means "no value"

-- Find movies where studio is an empty string
-- This means the studio field was set to blank
SELECT * FROM movies WHERE studio = '';

-- Find movies where IMDB rating is NULL
-- NULL means the rating hasn't been set or is unknown
-- You cannot use = with NULL, you must use IS NULL
SELECT * FROM movies WHERE imdb_rating IS NULL;

-- Find movies where IMDB rating exists (is not NULL)
-- This returns all movies that have been rated
SELECT * FROM movies WHERE imdb_rating IS NOT NULL;

-- ----------------------------------------------------------------------------
-- 1.3 WHERE Clause - Numeric Filtering
-- ----------------------------------------------------------------------------
-- Numeric comparisons use standard mathematical operators
-- These work with integers, decimals, and dates

-- Find movies with IMDB rating greater than 9
-- > means strictly greater than (9.1, 9.2, etc., but not 9.0)
SELECT * FROM movies WHERE imdb_rating > 9;

-- Find movies with IMDB rating of 9 or higher
-- >= includes the value itself (9.0, 9.1, 9.2, etc.)
SELECT * FROM movies WHERE imdb_rating >= 9;

-- Find movies with IMDB rating of 5 or lower
-- Useful for finding poorly rated movies
SELECT * FROM movies WHERE imdb_rating <= 5;

-- Find movies released after 2020
-- Works with year values as numbers
SELECT * FROM movies WHERE release_year > 2020;

-- ----------------------------------------------------------------------------
-- Range Queries
-- ----------------------------------------------------------------------------
-- Range queries check if a value falls within a specified range

-- Find movies with ratings between 6 and 8 using AND operator
-- Both conditions must be true (rating >= 6 AND rating <= 8)
SELECT * FROM movies WHERE imdb_rating >= 6 AND imdb_rating <= 8;

-- Same query using BETWEEN operator (more readable)
-- BETWEEN is inclusive - includes both 6 and 8
-- BETWEEN low AND high is equivalent to >= low AND <= high
SELECT * FROM movies WHERE imdb_rating BETWEEN 6 AND 8;

-- Count how many movies were released between 2015 and 2022
-- Combines COUNT aggregate function with BETWEEN
SELECT COUNT(*) FROM movies WHERE release_year BETWEEN 2015 AND 2022;

-- ----------------------------------------------------------------------------
-- Multiple Value Matching
-- ----------------------------------------------------------------------------
-- Check if a column value matches any value in a list

-- Find movies released in 2022, 2019, or 2018 using OR operator
-- Returns rows where ANY of these conditions is true
SELECT * FROM movies WHERE release_year = 2022 OR release_year = 2019 OR release_year = 2018;

-- Same query using IN operator (cleaner and more efficient)
-- IN is shorthand for multiple OR conditions
SELECT * FROM movies WHERE release_year IN (2018, 2019, 2022);

-- Find movies from Marvel Studios or Hombale Films
-- IN works with text values too
SELECT * FROM movies WHERE studio IN ("Marvel Studios", "Hombale Films");

-- ----------------------------------------------------------------------------
-- Exclusion Filters
-- ----------------------------------------------------------------------------
-- Filter out specific values you don't want

-- Find all movies that are NOT from Marvel Studios
-- != means "not equal to" (can also use <>)
SELECT * FROM movies WHERE studio != "Marvel Studios";

-- Alternative using NOT IN operator
-- Useful when excluding multiple values
SELECT * FROM movies WHERE studio NOT IN ("Marvel Studios");

-- ----------------------------------------------------------------------------
-- Complex Conditions
-- ----------------------------------------------------------------------------
-- Combine multiple conditions using AND/OR operators
-- AND requires ALL conditions to be true
-- OR requires AT LEAST ONE condition to be true

-- Find recent, highly-rated movies
-- Both conditions must be true: released after 2020 AND rating above 8
SELECT * FROM movies WHERE release_year > 2020 AND imdb_rating > 8;

-- ----------------------------------------------------------------------------
-- 1.4 DISTINCT - Unique Values
-- ----------------------------------------------------------------------------
-- DISTINCT removes duplicate values from the result set
-- Only unique values are returned

-- Get a list of all unique industries in the database
-- If "Hollywood" appears in 100 rows, it will only show once
SELECT DISTINCT industry FROM movies;

-- Get all unique studios for Bollywood movies
-- Combines DISTINCT with WHERE clause
SELECT DISTINCT studio FROM movies WHERE industry = "Bollywood";

-- Get all unique unit types from the financials table
-- Useful for understanding what units are used (Thousands, Millions, Billions)
SELECT DISTINCT unit FROM financials;

-- ----------------------------------------------------------------------------
-- 1.5 ORDER BY - Sorting Results
-- ----------------------------------------------------------------------------
-- ORDER BY sorts the result set by one or more columns
-- ASC = ascending (lowest to highest), DESC = descending (highest to lowest)

-- Sort movies by release year in ascending order (oldest first)
-- ASC is the default, so you can omit it
SELECT * FROM movies ORDER BY release_year;

-- Explicitly specify ascending order (same as above)
SELECT * FROM movies ORDER BY release_year ASC;

-- Sort movies by release year in descending order (newest first)
-- DESC must be explicitly specified
SELECT * FROM movies ORDER BY release_year DESC;

-- ----------------------------------------------------------------------------
-- Combining ORDER BY with WHERE
-- ----------------------------------------------------------------------------
-- You can filter and sort in the same query
-- The order is: WHERE filters first, then ORDER BY sorts the results

-- Get all Bollywood movies sorted by rating (lowest to highest)
SELECT * FROM movies 
WHERE industry = "Bollywood"
ORDER BY imdb_rating DESC;

-- Find all Thor movies and sort by release year
-- Shows the chronological order of Thor movies
SELECT title, release_year FROM movies 
WHERE title LIKE '%Thor%' 
ORDER BY release_year ASC;

-- ----------------------------------------------------------------------------
-- 1.6 LIMIT and OFFSET - Result Set Pagination
-- ----------------------------------------------------------------------------
-- LIMIT restricts the number of rows returned
-- OFFSET skips a specified number of rows before returning results
-- Useful for pagination and getting top N results

-- Get top 5 highest-rated Bollywood movies
-- ORDER BY DESC puts highest ratings first, LIMIT 5 returns only first 5
SELECT * FROM movies 
WHERE industry = "Bollywood"
ORDER BY imdb_rating DESC 
LIMIT 5;

-- Get the 2nd through 6th highest-rated Bollywood movies
-- OFFSET 1 skips the first row (highest rated)
-- LIMIT 5 returns the next 5 rows
-- Useful for pagination: page 1 = LIMIT 5 OFFSET 0, page 2 = LIMIT 5 OFFSET 5
SELECT * FROM movies 
WHERE industry = "Bollywood"
ORDER BY imdb_rating DESC 
LIMIT 5 OFFSET 1;

-- ============================================================================
-- SECTION 2: AGGREGATE FUNCTIONS AND GROUPING
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 2.1 COUNT, MIN, MAX, AVG
-- ----------------------------------------------------------------------------
-- Aggregate functions perform calculations on a set of values and return a single value
-- They are often used with GROUP BY to calculate statistics for groups

-- ----------------------------------------------------------------------------
-- COUNT - Counting Rows
-- ----------------------------------------------------------------------------
-- COUNT(*) counts all rows, including rows with NULL values
-- COUNT(column_name) counts only non-NULL values in that column

-- Count total number of movies in the database
SELECT COUNT(*) FROM movies;

-- Count how many Hollywood movies exist
-- Combines COUNT with WHERE clause
SELECT COUNT(*) FROM movies WHERE industry = "Hollywood";

-- Count how many Bollywood movies exist
SELECT COUNT(*) FROM movies WHERE industry = "Bollywood";

-- ----------------------------------------------------------------------------
-- MIN and MAX - Finding Minimum and Maximum Values
-- ----------------------------------------------------------------------------
-- MIN returns the smallest value, MAX returns the largest value
-- Works with numbers, dates, and even text (alphabetical order)

-- Find the lowest IMDB rating among Bollywood movies
SELECT MIN(imdb_rating) FROM movies WHERE industry = "Bollywood";

-- Find the highest IMDB rating among Bollywood movies
SELECT MAX(imdb_rating) FROM movies WHERE industry = "Bollywood";

-- Find the earliest and latest movie release years in the database
-- Using column aliases (AS) makes results more readable
SELECT 
    MIN(release_year) AS min_year, 
    MAX(release_year) AS max_year 
FROM movies;

-- ----------------------------------------------------------------------------
-- AVG - Calculating Averages
-- ----------------------------------------------------------------------------
-- AVG calculates the arithmetic mean of a numeric column
-- NULL values are ignored in the calculation

-- Calculate average IMDB rating for Marvel Studios movies
SELECT AVG(imdb_rating) FROM movies WHERE studio = "Marvel Studios";

-- Same as above but round to 2 decimal places
-- ROUND(value, decimals) makes results more readable
SELECT ROUND(AVG(imdb_rating), 2) FROM movies WHERE studio = "Marvel Studios";

-- ----------------------------------------------------------------------------
-- Combining Multiple Aggregate Functions
-- ----------------------------------------------------------------------------
-- You can use multiple aggregate functions in a single query
-- Each function operates independently on the dataset

-- Get minimum, maximum, and average rating for Marvel Studios movies
-- Using aliases makes the output columns easy to understand
SELECT 
    MIN(imdb_rating) AS min_rating, 
    MAX(imdb_rating) AS max_rating, 
    ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies 
WHERE studio = "Marvel Studios";

-- ----------------------------------------------------------------------------
-- 2.2 GROUP BY - Grouping Data
-- ----------------------------------------------------------------------------
-- GROUP BY groups rows that have the same values in specified columns
-- Aggregate functions then calculate one result per group
-- Think of it as creating categories and calculating statistics for each category

-- ----------------------------------------------------------------------------
-- Simple Grouping
-- ----------------------------------------------------------------------------

-- Count how many movies are in each industry
-- Groups all rows by industry, then counts rows in each group
-- Result: one row per industry with its count
SELECT 
    industry, 
    COUNT(industry) 
FROM movies
GROUP BY industry;

-- Count movies per studio, excluding empty studio names
-- WHERE filters before grouping (removes empty studios)
-- ORDER BY sorts the final result by count
SELECT 
    studio, 
    COUNT(studio) AS movies_count 
FROM movies 
WHERE studio != ''
GROUP BY studio
ORDER BY movies_count DESC;

-- ----------------------------------------------------------------------------
-- Grouping with Multiple Aggregates
-- ----------------------------------------------------------------------------
-- You can calculate multiple statistics for each group

-- Count movies and calculate average rating per industry
-- Shows both quantity (count) and quality (average rating) for each industry
SELECT 
    industry, 
    COUNT(industry) AS movie_count,
    ROUND(AVG(imdb_rating), 2) AS avg_rating
FROM movies
GROUP BY industry;

-- Get count and average rating per studio, sorted by rating
-- Shows which studios produce the highest-rated movies on average
SELECT 
    studio, 
    COUNT(studio) AS cnt, 
    ROUND(AVG(imdb_rating), 1) AS avg_rating 
FROM movies 
WHERE studio != ''
GROUP BY studio
ORDER BY avg_rating DESC;

-- Count how many movies were released each year
-- Useful for seeing trends over time
SELECT 
    release_year, 
    COUNT(*) AS movies_count
FROM movies
GROUP BY release_year
ORDER BY release_year DESC;

-- ----------------------------------------------------------------------------
-- 2.3 HAVING - Filtering Grouped Results
-- ----------------------------------------------------------------------------
-- HAVING filters groups after aggregation (after GROUP BY)
-- WHERE filters individual rows before grouping
-- Use HAVING when you need to filter based on aggregate function results

-- Find years where more than 2 movies were released
-- GROUP BY creates groups by year
-- HAVING filters out groups with 2 or fewer movies
-- You cannot use WHERE for this because movies_count doesn't exist until after grouping
SELECT 
    release_year, 
    COUNT(*) AS movies_count
FROM movies    
GROUP BY release_year
HAVING movies_count > 2
ORDER BY movies_count DESC;

-- IMPORTANT: SQL Execution Order
-- 1. FROM: Identify the table
-- 2. WHERE: Filter individual rows
-- 3. GROUP BY: Group the filtered rows
-- 4. HAVING: Filter the groups
-- 5. SELECT: Choose columns to display
-- 6. ORDER BY: Sort the final results
-- 7. LIMIT: Restrict number of results

-- ============================================================================
-- SECTION 3: CALCULATED COLUMNS AND EXPRESSIONS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 3.1 Basic Calculations
-- ----------------------------------------------------------------------------
-- You can perform arithmetic operations on columns to create new calculated columns
-- These calculations happen in real-time and don't modify the original data

-- Calculate profit for each movie (revenue minus budget)
-- The asterisk (*) includes all original columns plus the new calculated column
SELECT 
    *, 
    (revenue - budget) AS profit 
FROM financials;

-- Calculate both profit and profit percentage
-- Profit percentage = (profit / budget) * 100
-- Shows ROI (Return on Investment) for each movie
SELECT 
    *, 
    (revenue - budget) AS profit, 
    (revenue - budget) * 100 / budget AS profit_pct 
FROM financials;

-- ----------------------------------------------------------------------------
-- Date Calculations
-- ----------------------------------------------------------------------------
-- CURDATE() returns today's date
-- YEAR() extracts the year from a date
-- Useful for calculating ages, durations, etc.

-- Calculate each actor's current age
-- YEAR(CURDATE()) gets the current year (e.g., 2025)
-- Subtract birth_year to get age
SELECT 
    name, 
    birth_year, 
    (YEAR(CURDATE()) - birth_year) AS age
FROM actors;

-- ----------------------------------------------------------------------------
-- 3.2 IF Function - Conditional Logic
-- ----------------------------------------------------------------------------
-- IF(condition, value_if_true, value_if_false)
-- Allows simple conditional logic in your queries
-- Like an if-else statement in programming

-- Convert revenue to INR (Indian Rupees)
-- If currency is USD, multiply by 77 (exchange rate)
-- Otherwise, keep the revenue as-is (already in INR)
SELECT 
    movie_id, 
    revenue, 
    currency, 
    unit,
    IF(currency = 'USD', revenue * 77, revenue) AS revenue_inr
FROM financials;

-- ----------------------------------------------------------------------------
-- 3.3 CASE Statement - Multi-way Conditionals
-- ----------------------------------------------------------------------------
-- CASE allows multiple conditions (like if-else-if-else in programming)
-- More powerful than IF when you have multiple conditions
-- Syntax: CASE WHEN condition THEN result WHEN condition THEN result ELSE result END

-- Convert all revenue values to millions for comparison
-- Different units (Thousands, Billions, Millions) need different conversions
-- ELSE clause handles values already in millions
SELECT 
    movie_id, 
    revenue, 
    currency, 
    unit,
    CASE
        WHEN unit = "Thousands" THEN revenue / 1000      -- Divide by 1000
        WHEN unit = "Billions" THEN revenue * 1000       -- Multiply by 1000
        ELSE revenue                                      -- Already in millions
    END AS revenue_mln
FROM financials;

-- Calculate profit in millions for Bollywood movies
-- Combines CASE statement with JOIN and WHERE
-- Allows fair comparison of profits regardless of original unit
SELECT 
    m.movie_id, 
    title, 
    revenue, 
    currency, 
    unit, 
    CASE 
        WHEN unit = "Thousands" THEN ROUND((revenue - budget) / 1000, 2)
        WHEN unit = "Billions" THEN ROUND((revenue - budget) * 1000, 2)
        ELSE revenue - budget
    END AS profit_mln
FROM movies m
JOIN financials f 
ON m.movie_id = f.movie_id
WHERE m.industry = "Bollywood"
ORDER BY profit_mln DESC;

-- ============================================================================
-- SECTION 4: JOINS - MULTIPLE TABLE OPERATIONS
-- ============================================================================

-- Joins combine rows from two or more tables based on a related column
-- This is how we work with normalized databases where data is split across tables
-- The related column is usually a foreign key relationship

-- ----------------------------------------------------------------------------
-- 4.1 INNER JOIN - Matching Records Only
-- ----------------------------------------------------------------------------
-- INNER JOIN returns only rows that have matching values in both tables
-- If a movie has no financial data, it won't appear in the result
-- If financial data has no matching movie, it won't appear either
-- This is the most restrictive join (intersection of two sets)

-- Get movie details along with financial information
-- Only movies that have financial records will appear
SELECT 
    m.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit 
FROM movies m
INNER JOIN financials f
ON m.movie_id = f.movie_id;

-- Using table aliases (m for movies, f for financials)
-- Aliases make queries shorter and more readable
-- SELECT f.movie_id chooses movie_id from the financials table
SELECT 
    f.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit
FROM movies m
INNER JOIN financials f
ON m.movie_id = f.movie_id;

-- Using USING keyword when column names are identical in both tables
-- USING(movie_id) is shorthand for ON m.movie_id = f.movie_id
-- Only works when the join column has the same name in both tables
SELECT 
    movie_id, 
    title, 
    revenue 
FROM movies m 
LEFT JOIN financials f
USING (movie_id);

-- ----------------------------------------------------------------------------
-- 4.2 LEFT JOIN (LEFT OUTER JOIN) - All Records from Left Table
-- ----------------------------------------------------------------------------
-- LEFT JOIN returns all rows from the left table (movies)
-- Plus matching rows from the right table (financials)
-- If no match exists, NULL values appear for the right table's columns
-- Use this when you want to keep all records from the first table

-- Get all movies with their financial data (if available)
-- Movies without financial records will still appear with NULL values for financial columns
-- "Left" table is the one mentioned after FROM (movies)
SELECT 
    m.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit 
FROM movies m
LEFT JOIN financials f
ON m.movie_id = f.movie_id;

-- ----------------------------------------------------------------------------
-- 4.3 RIGHT JOIN (RIGHT OUTER JOIN) - All Records from Right Table
-- ----------------------------------------------------------------------------
-- RIGHT JOIN returns all rows from the right table (financials)
-- Plus matching rows from the left table (movies)
-- If no match exists, NULL values appear for the left table's columns
-- Less commonly used than LEFT JOIN (you can rewrite as LEFT JOIN by swapping table order)

-- Get all financial records with their movie data (if available)
-- Financial records without matching movies will still appear
-- "Right" table is the one mentioned after JOIN (financials)
SELECT 
    f.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit 
FROM movies m
RIGHT JOIN financials f
ON m.movie_id = f.movie_id;

-- ----------------------------------------------------------------------------
-- 4.4 FULL OUTER JOIN - All Records from Both Tables
-- ----------------------------------------------------------------------------
-- FULL OUTER JOIN returns all rows from both tables
-- Matches where possible, NULL values where no match exists
-- MySQL doesn't support FULL OUTER JOIN directly
-- We simulate it using UNION of LEFT JOIN and RIGHT JOIN

-- Get all movies and all financial records
-- Shows movies without financials AND financials without movies
-- UNION removes duplicates; use UNION ALL to keep duplicates
SELECT 
    m.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit 
FROM movies m
LEFT JOIN financials f
ON m.movie_id = f.movie_id

UNION

SELECT 
    f.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit 
FROM movies m
RIGHT JOIN financials f
ON m.movie_id = f.movie_id;

-- ----------------------------------------------------------------------------
-- 4.5 CROSS JOIN - Cartesian Product
-- ----------------------------------------------------------------------------
-- CROSS JOIN returns all possible combinations of rows from both tables
-- If table1 has 10 rows and table2 has 5 rows, result has 50 rows (10 × 5)
-- Rarely used in practice, but useful for generating combinations

-- Generate all possible menu item combinations
-- Creates every combination of food item with every size variant
-- Example: If you have "Pizza" and variants "Small", "Large"
-- Result includes "Pizza - Small" and "Pizza - Large"
SELECT 
    *, 
    CONCAT(name, " - ", variant_name) AS full_name,
    (price + variant_price) AS full_price
FROM food_db.items
CROSS JOIN food_db.variants;

-- ----------------------------------------------------------------------------
-- 4.6 Joining Three or More Tables
-- ----------------------------------------------------------------------------
-- You can chain multiple joins to combine data from several tables
-- Each JOIN operates on the result of the previous joins
-- Order matters: join tables in logical sequence

-- Show each movie with all its actors (comma-separated)
-- Requires joining 3 tables: movies -> movie_actor -> actors
-- movie_actor is a junction table (many-to-many relationship)
-- GROUP_CONCAT combines multiple actor names into one string
SELECT 
    m.title, 
    GROUP_CONCAT(name SEPARATOR " | ") AS actors
FROM movies m
JOIN movie_actor ma ON m.movie_id = ma.movie_id
JOIN actors a ON a.actor_id = ma.actor_id
GROUP BY m.movie_id;

-- Show each actor with all their movies and count
-- Same three-table join but grouped by actor instead of movie
-- COUNT tells us how prolific each actor is
SELECT 
    a.name, 
    GROUP_CONCAT(m.title SEPARATOR ' | ') AS movies,
    COUNT(m.title) AS num_movies
FROM actors a
JOIN movie_actor ma ON a.actor_id = ma.actor_id
JOIN movies m ON ma.movie_id = m.movie_id
GROUP BY a.actor_id
ORDER BY num_movies DESC;

-- Join movies with languages
-- Shows what language each movie was made in
SELECT 
    m.title, 
    l.name AS language
FROM movies m 
JOIN languages l 
USING (language_id);

-- Count how many movies exist for each language
-- LEFT JOIN ensures languages with zero movies still appear
-- GROUP BY language creates one row per language
SELECT 
    l.name, 
    COUNT(m.movie_id) AS no_movies
FROM languages l
LEFT JOIN movies m 
USING (language_id)        
GROUP BY language_id
ORDER BY no_movies DESC;

-- ============================================================================
-- SECTION 5: PRACTICAL EXAMPLES AND ANALYTICS
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 5.1 Financial Analysis
-- ----------------------------------------------------------------------------
-- Real-world business queries combining multiple concepts

-- Calculate profit for all movies
-- Joins movies and financials tables to show business performance
SELECT 
    m.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit, 
    (revenue - budget) AS profit 
FROM movies m
JOIN financials f
ON m.movie_id = f.movie_id;

-- Calculate profit percentage (ROI)
-- Shows which movies were most profitable relative to their budget
-- A movie with 100% profit doubled its money
SELECT 
    m.movie_id, 
    m.title, 
    ROUND(100 * (f.revenue - f.budget) / f.budget, 2) AS profit_percentage
FROM financials AS f
JOIN movies m 
ON f.movie_id = m.movie_id
ORDER BY profit_percentage DESC;

-- Generate Hindi movie revenue report (normalized)
-- Converts all revenues to millions for fair comparison
-- Joins three tables: movies, financials, and languages
SELECT 
    title, 
    revenue, 
    currency, 
    unit, 
    CASE 
        WHEN unit = "Thousands" THEN ROUND(revenue / 1000, 2)
        WHEN unit = "Billions" THEN ROUND(revenue * 1000, 2)
        ELSE revenue 
    END AS revenue_mln
FROM movies m
JOIN financials f ON m.movie_id = f.movie_id
JOIN languages l ON m.language_id = l.language_id
WHERE l.name = "Hindi"
ORDER BY revenue_mln DESC;

-- ----------------------------------------------------------------------------
-- 5.2 Industry-Specific Queries
-- ----------------------------------------------------------------------------
-- Analyzing specific segments of the data

-- Analyze Bollywood movie profitability
-- Focuses on one industry for targeted analysis
SELECT 
    m.movie_id, 
    title, 
    budget, 
    revenue, 
    currency, 
    unit, 
    (revenue - budget) AS profit 
FROM movies m
JOIN financials f
ON m.movie_id = f.movie_id
WHERE m.industry = "Bollywood";

-- Quick count of Hollywood movies
-- Simple metric for database statistics
SELECT COUNT(*) FROM movies WHERE industry = "Hollywood";

-- ----------------------------------------------------------------------------
-- 5.3 Studio and Release Year Analysis
-- ----------------------------------------------------------------------------
-- Tracking production companies and trends over time

-- List all Marvel Studios movies with release years
-- Useful for analyzing a studio's output
SELECT title, release_year 
FROM movies 
WHERE studio = "Marvel Studios";

-- Find productive years (more than 2 releases)
-- Identifies peak years in the film industry
-- HAVING filters groups after counting
SELECT 
    release_year, 
    COUNT(*) AS movies_count
FROM movies    
GROUP BY release_year
HAVING movies_count > 2
ORDER BY movies_count DESC;

-- ============================================================================
-- NOTES AND BEST PRACTICES
-- ============================================================================

-- SQL EXECUTION ORDER (Important to remember!):
-- 1. FROM - Identify the source table(s)
-- 2. JOIN - Combine tables if needed
-- 3. WHERE - Filter individual rows
-- 4. GROUP BY - Group rows into categories
-- 5. HAVING - Filter groups
-- 6. SELECT - Choose columns to display
-- 7. ORDER BY - Sort the results
-- 8. LIMIT/OFFSET - Restrict number of results

-- WHERE vs HAVING:
-- - WHERE filters rows BEFORE grouping (operates on individual records)
-- - HAVING filters groups AFTER grouping (operates on aggregated results)
-- - Use WHERE when filtering on column values
-- - Use HAVING when filtering on aggregate functions (COUNT, AVG, etc.)

-- JOIN TYPES SUMMARY:
-- - INNER JOIN: Only matching rows from both tables (intersection)
-- - LEFT JOIN: All rows from left table + matching rows from right table
-- - RIGHT JOIN: All rows from right table + matching rows from left table
-- - FULL OUTER JOIN: All rows from both tables (union)
-- - CROSS JOIN: All possible combinations (Cartesian product)

-- TABLE ALIASES:
-- - Use short, meaningful aliases (m for movies, f for financials)
-- - Makes queries more readable and easier to type
-- - Required when column names exist in multiple tables

-- NULL HANDLING:
-- - Use IS NULL / IS NOT NULL (not = NULL)
-- - NULL means "unknown" or "not applicable"
-- - Empty string ('') is different from NULL
-- - Aggregate functions (except COUNT(*)) ignore NULL values

-- STRING FILTERING:
-- - Use != '' to exclude empty strings
-- - Use LIKE with % for pattern matching
-- - % matches any sequence of characters (including none)
-- - _ matches exactly one character

-- PERFORMANCE TIPS:
-- - Use DISTINCT sparingly (it can be expensive on large datasets)
-- - Select only columns you need (avoid SELECT * in production)
-- - Use indexes on columns frequently used in WHERE and JOIN clauses
-- - Filter early (WHERE) before grouping for better performance

-- READABILITY:
-- - Use ROUND(value, decimals) for cleaner numeric output
-- - Use meaningful column aliases (AS keyword)
-- - Format queries with indentation and line breaks
-- - Comment complex queries to explain business logic

-- AGGREGATE FUNCTIONS:
-- - COUNT(*): Counts all rows including NULL
-- - COUNT(column): Counts only non-NULL values
-- - AVG, SUM: Ignore NULL values
-- - MIN, MAX: Work with numbers, dates, and text
-- - GROUP_CONCAT: Combines multiple rows into one delimited string

-- ============================================================================
```
