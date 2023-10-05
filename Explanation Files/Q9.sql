-- Q9. For each comment, show the comment text, the username of the commenter, 
-- and the comment text of the previous comment made on the same photo.

SELECT * FROM comments
LIMIT 8000;

SELECT photo_id,username,comment_text,LAG(comment_text,1) OVER(PARTITION BY photo_id ORDER BY c.created_at) prev_comm
FROM comments c
JOIN users u ON c.user_id=u.id;

-- 1. joined users table to find the username for each user id
-- 2. used lag() to find the previous comment 

-- why I used partition and order by:
-- partitioned by photo id so that only the previous comments on the same photos are shown
-- ordered by created at to sort the comments using date of post

