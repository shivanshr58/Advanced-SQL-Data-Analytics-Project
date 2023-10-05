-- 6. For each tag, show the tag name and the number of photos associated with that tag.
-- Rank the tags by the number of photos in descending order.

SELECT id,tag_name, num_used,(-- @subquery--),
RANK() OVER(ORDER BY (-- @subquery--
) DESC) AS 'rank'
FROM tags;

-- 1. used the following correlated subquery (to find the count the number of photos associated with a tag):

(SELECT COUNT(tag_id) FROM photo_tags WHERE tag_id=tags.id)

-- 2. used the same subquery at the place of @subquery to rank the tags based on their count (in descending order)

