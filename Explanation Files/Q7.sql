-- 7.List the usernames of users who have posted photos along with the count of photos they have posted.
-- Rank them by the number of photos in descending order.

SELECT username,() num_photos,-- @subquery
RANK() OVER(ORDER BY (-- @subquery
) DESC) 'rank'
FROM users u
WHERE EXISTS(
SELECT user_id FROM photos WHERE user_id=u.id);

-- 1. used the following subquery(to find the count of photos posted for each user )

SELECT COUNT(user_id) FROM photos WHERE user_id=u.id

-- 2. used the same subquery in place of @subquery (to rank the users based on descending count)
-- 3. filtered the result using exists (to only show the results for users who have posted)


-- Alternative Method (without subquery):

SELECT username,count(*) num_photos,RANK () OVER(ORDER BY count(*) DESC) ranking
FROM photos p
JOIN users u ON p.user_id=u.id
GROUP BY user_id,username

