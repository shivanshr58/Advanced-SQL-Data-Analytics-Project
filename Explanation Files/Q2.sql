-- 2. Find the top 5 most used hashtags.

SELECT pt.tag_id,t.tag_name
FROM photo_tags pt
JOIN tags t ON pt.tag_id=t.id
GROUP BY tag_id,t.tag_name
ORDER BY count(*) DESC
LIMIT 5;

-- joined photo tags table with tags table to get the name of each tag
-- grouped and counted the number of times a tag was used
-- ordered in descending order and selected top 5