-- Q8. Display the username of each user along with the creation date of their first posted photo 
-- and the creation date of their next posted photo.

with cte AS(
SELECT user_id,created_at,ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at) rownum
FROM photos),

-- 1. partitioned by user_id and giving rownumber based on ascending post date to extract first and second post
 
fs_posts AS(SELECT user_id,MAX(CASE WHEN rownum=1 THEN created_at ELSE NULL END) AS first_post_date,
MAX(CASE WHEN rownum=2 THEN created_at ELSE NULL END) AS second_post_date
FROM cte
GROUP BY user_id)

-- 2. grouped by user-id and extracting the first and second post date by filtering using row number(1 & 2)

SELECT username,first_post_date,second_post_date
FROM  users u
JOIN fs_posts fs ON u.id=fs.user_id;

-- 3. queried the required columns and joing the users table to find the username for each user id




