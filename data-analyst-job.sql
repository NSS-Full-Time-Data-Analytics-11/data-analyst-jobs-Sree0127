SELECT *
FROM data_analyst_jobs;
--Answer: 1793 rows

--Q1)How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;
--Answer:1793

--Q2)Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT company
FROM data_analyst_jobs
LIMIT 1 OFFSET 9;

--Q3)How many postings are in Tennessee? 
SELECT COUNT(*) AS Postings_Tennessee
FROM data_analyst_jobs
WHERE location = 'TN';
--Answer: 21

--How many are there in either Tennessee or Kentucky?
SELECT COUNT(*) AS Posting_TennesseeORKentucky
FROM data_analyst_jobs
WHERE location IN ('TN' , 'KY');
--Answer: 27

--Q4)How many postings in Tennessee have a star rating above 4?
SELECT location,star_rating,COUNT(*) AS Postingsrating4
FROM data_analyst_jobs
WHERE location='TN' AND star_rating>4
GROUP BY location,star_raTING;

--Q5)How many postings in the dataset have a review count between 500 and 1000?
SELECT review_count
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--Q6)Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state;
--Which state shows the highest average rating?
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY avg_rating DESC
LIMIT 1;

--Q7)Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT title AS job_title
FROM data_analyst_jobs;

--How many are there?
SELECT COUNT(DISTINCT title) AS unique_title
FROM data_analyst_jobs;
--Answer: 881

--Q8)How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title) AS Unique_JobTitle
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer: 230

--Q9)Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations.

SELECT company,AVG(star_rating)
FROM data_analyst_jobs
GROUP BY company 
HAVING SUM(review_count)> 5000;

-- How many companies are there with more that 5000 reviews across all locations?
SELECT company, SUM(review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000;

--Q10)Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS Average_Start_Rating, SUM(review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY Average_Start_Rating DESC;

-- What is that rating?

SELECT company, AVG(star_rating) AS Average_Start_Rating, SUM(review_count)
FROM data_analyst_jobs
GROUP BY company
HAVING SUM(review_count) > 5000
ORDER BY Average_Start_Rating DESC
LIMIT 1;
--Answer: Google company has the highest star rating 
--        Rating is 4.3

--Q11)Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';

--How many different job titles are there?
SELECT COUNT(DISTINCT title) AS Diff_title
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%';
--Answer: different job titles are 754

--Q12)How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT COUNT(DISTINCT title) AS NOT_AnalystORAnalitics
FROM data_analyst_jobs
--WHERE title NOT LIKE ('%Analyst%' OR '%Analitics');
WHERE title NOT LIKE '%Analyst%' OR title NOT LIKE '%Analitics';
--Answer: Count is 881

--BONUS:
--You want to understand which jobs requiring SQL are hard to fill.
SELECT title,skill,days_since_posting,review_count,location
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%' OR CAST(review_count AS VARCHAR) = 'SQL';

-- Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
SELECT skill,days_since_posting,company, COUNT(*) AS NumberOfJobs
FROM data_analyst_jobs
WHERE skill LIKE '%SQL' AND days_since_posting >21)
GROUP BY company;
--Disregard any postings where the domain is NULL.
SELECT days_since_posting, COUNT(*)
FROM data_analyst_jobs
WHERE days_since_posting IS NOT NULL
GROUP BY days_since_posting;
--Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
SELECT days_since_posting, COUNT(*) AS greater_jobs
FROM data_analyst_jobs
WHERE days_since_posting IS NOT NULL
GROUP BY days_since_posting
ORDER BY greater_jobs DESC;
--Which three industries are in the top 4 on this list? 
SELECT days_since_posting, COUNT(*) AS greater_jobs
FROM data_analyst_jobs
WHERE days_since_posting IS NOT NULL
GROUP BY days_since_posting
ORDER BY greater_jobs DESC
LIMIT 4;
--How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT days_since_posting, COUNT(*) AS morethan_3weeks
FROM data_analyst_jobs
WHERE days_since_posting IS NOT NULL
GROUP BY days_since_posting
ORDER BY greater_jobs DESC
LIMIT 4 AND IF DATED(CURRENT_DATE,days_since_posting)>21
GROUP BY morethan_3weeks;