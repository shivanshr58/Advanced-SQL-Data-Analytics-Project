-- 4.Retrieve a list of users along with their usernames and the rank of their account creation,
--  ordered by the creation date in ascending order.

SELECT id,username, RANK() OVER (ORDER BY created_at) 'rank'
FROM users;

-- used rank based on creation date