-- Q10. Show the username of each user along with the number of photos they have posted 
-- and the number of photos posted by the user before them and after them, based on the creation date.

with cte AS(SELECT username,(SELECT COUNT(user_id) FROM photos WHERE user_id=u.id) num_photos
FROM users u
ORDER BY created_at)

-- 1. used correlated subquery to fetch the count of photos posted for each user 
-- 2. ordered the cte using created_at to sort the results based on joining date of user

SELECT username,num_photos,LAG(num_photos,1) OVER() user_before,LEAD(num_photos,1) OVER() user_after
FROM cte;

-- 3. used lag and lead to find the count of posts of adjacent users 

-- Alternative Method (without subquery):

with cte AS(SELECT username,count(p.user_id) num_photos,u.created_at
FROM users u
LEFT JOIN photos p ON u.id=p.user_id
GROUP BY user_id,username)
SELECT username,num_photos,LAG(num_photos,1) OVER(ORDER BY created_at) user_before,
LEAD(num_photos,1) OVER(ORDER BY created_at) user_after
FROM cte