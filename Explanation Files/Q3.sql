-- 3. Find users who have liked every single photo on the site.

SELECT user_id,username
FROM likes l
JOIN users u ON l.user_id=u.id
GROUP BY user_id,username

-- 1. joined likes table with users table (to fetch the username for each user id)
-- 2. used group by and count to (calculate count of photos posted by each user)

HAVING COUNT(*)=(select COUNT(id) from photos p);

-- 3. used subquery to find the count of distinct photos on instagram
-- 4. used this subquery to filter (user like count=distinct count of photos on instagram)

-- explanation:
-- if a user has liked the same number of distinct photos as there are distinct photos on instagram,
-- it means that the user has liked each every photo on instagram


