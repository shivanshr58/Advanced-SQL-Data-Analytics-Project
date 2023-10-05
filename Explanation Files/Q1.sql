-- Q1. How many times does the average user post?

with cte AS(SELECT u.id,COUNT(p.user_id) num_posts
FROM users u
LEFT JOIN photos p ON u.id=p.user_id
GROUP BY u.id)

-- 1. joined users table with photos table (used left join because average for each user is asked)
-- 2. counted the number of user_ids in the photos table (to count only the photo ids that are not null)

SELECT AVG(num_posts) avg_num_posts
FROM cte;

-- 3. calculated average of count of photos posted by each user

SELECT *
FROM users;
SELECT *
FROM photos;
