-- 1. How many times does the average user post?

with cte AS(SELECT u.id,COUNT(p.user_id) num_posts
FROM users u
LEFT JOIN photos p ON u.id=p.user_id
GROUP BY u.id)
SELECT AVG(num_posts) avg_num_posts
FROM cte;


-- 2. Find the top 5 most used hashtags.

SELECT pt.tag_id,t.tag_name
FROM photo_tags pt
JOIN tags t ON pt.tag_id=t.id
GROUP BY tag_id,t.tag_name
ORDER BY count(*) DESC
LIMIT 5;

-- 3. Find users who have liked every single photo on the site.

SELECT user_id,username
FROM likes
JOIN users ON likes.user_id=users.id
GROUP BY user_id
HAVING COUNT(*)=(select COUNT(id) from photos p);

-- 4.Retrieve a list of users along with their usernames and the rank of their account creation,
--  ordered by the creation date in ascending order.

SELECT id,username, RANK() OVER (ORDER BY created_at) 'rank'
FROM users;

-- 5.List the comments made on photos with their comment texts, photo URLs, and usernames of users who posted the comments.
-- Include the comment count for each photo

SELECT comment_text,image_url,username,COUNT(photo_id) OVER (PARTITION BY photo_id) AS comment_count
FROM comments c
JOIN photos p ON c.photo_id=p.id
JOIN users u ON c.user_id=u.id;

-- 6. For each tag, show the tag name and the number of photos associated with that tag.
-- Rank the tags by the number of photos in descending order.

SELECT id,tag_name,(SELECT COUNT(tag_id) FROM photo_tags WHERE tag_id=tags.id) num_used,
RANK() OVER(ORDER BY (SELECT COUNT(tag_id) FROM photo_tags WHERE tag_id=tags.id) DESC) AS 'rank'
FROM tags;

-- 7.List the usernames of users who have posted photos along with the count of photos they have posted.
-- Rank them by the number of photos in descending order.

SELECT username,(SELECT COUNT(user_id) FROM photos WHERE user_id=u.id) num_photos,
RANK() OVER(ORDER BY (SELECT COUNT(user_id) FROM photos WHERE user_id=u.id) DESC) 'rank'
FROM users u
WHERE EXISTS(
SELECT user_id FROM photos WHERE user_id=u.id);

-- 8. Display the username of each user along with the creation date of their first posted photo 
-- and the creation date of their next posted photo.

with cte AS(
SELECT user_id,created_at,ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY created_at) rownum
FROM photos),
fs_posts AS(SELECT user_id,MAX(CASE WHEN rownum=1 THEN created_at ELSE NULL END) AS first_post_date,
MAX(CASE WHEN rownum=2 THEN created_at ELSE NULL END) AS second_post_date
FROM cte
GROUP BY user_id)
SELECT username,first_post_date,second_post_date
FROM  users u
JOIN fs_posts fs ON u.id=fs.user_id;

-- 9. For each comment, show the comment text, the username of the commenter, 
-- and the comment text of the previous comment made on the same photo.

SELECT photo_id,username,comment_text,LAG(comment_text,1) OVER(PARTITION BY photo_id ORDER BY c.created_at) prev_comm
FROM comments c
JOIN users u ON c.user_id=u.id;

-- 10. Show the username of each user along with the number of photos they have posted 
-- and the number of photos posted by the user before them and after them, based on the creation date.

with cte AS(SELECT username,(SELECT COUNT(user_id) FROM photos WHERE user_id=u.id) num_photos,created_at
FROM users u)
SELECT username,num_photos,LAG(num_photos,1) OVER(ORDER BY created_at) user_before,LEAD(num_photos,1) OVER(ORDER BY created_at) user_after
FROM cte;

-- cte is ordered by created_at
