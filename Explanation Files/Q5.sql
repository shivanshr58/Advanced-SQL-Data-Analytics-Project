-- 5.List the comments made on photos with their comment texts, photo URLs, and usernames of users who posted the comments.
-- Include the comment count for each photo

SELECT comment_text,image_url,c.user_id,username,photo_id
FROM comments c
JOIN photos p ON c.photo_id=p.id
JOIN users u ON c.user_id=u.id;

-- 1. joined photos to find photo url
-- 2. joined users to find username of the user who posted the comment
-- 3. used count as a window function

-- why I used the window function:
-- the window function shows the total number of comments for each photo 
-- (distributed over every record in the result)