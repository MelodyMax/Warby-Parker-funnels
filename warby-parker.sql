 SELECT *
 FROM survey
 LIMIT 10;

 SELECT question, COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY question;

--  100%
--  0.95%
--  0.8%
--  0.95%
--  0.747922%

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

-- SAME AS THE ONE BELOW

SELECT *
FROM quiz
LEFT JOIN home_try_on
  ON home_try_on.user_id = quiz.user_id
LEFT JOIN purchase 
  ON purchase.user_id = home_try_on.user_id
LIMIT 10;

-- JOINING THE 3 TABLES
-- CHOOSING SPECIFIC COLUMNS AND ASSIGNING A NEW NAME
-- SHOWING HOW MANY PAIRS OF GLASSES THEY WANT TO TRY ON AND PURCHASE

SELECT DISTINCT q.user_id, 
   h.user_id IS NOT NULL AS is_home_try_on, 
   h.number_of_pairs,
   p.user_id IS NOT NULL AS is_purchase
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON h.user_id = q.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = h.user_id
LIMIT 10;

-- PUT THE CODE ABOVE IN A WITH STATEMENT

WITH funnels AS (
SELECT DISTINCT q.user_id, 
   h.user_id IS NOT NULL AS is_home_try_on, 
   h.number_of_pairs,
   p.user_id IS NOT NULL AS is_purchase
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
  ON h.user_id = q.user_id
LEFT JOIN purchase AS 'p'
  ON p.user_id = h.user_id)

-- PEOPLE TRYING ON AND PURCHASING 

SELECT COUNT(*) AS 'number_of_users',
  SUM(is_home_try_on) AS 'number_of_try_on',
  SUM(is_purchase) AS 'number_of_purchase',
 1.0 *SUM(is_home_try_on) / COUNT(user_id) AS 'user_to_try_on',
  1.0 *SUM(is_purchase) / SUM(is_home_try_on) AS 'try_on_to_purchase'
FROM funnels;

SELECT style, COUNT(DISTINCT user_id)
FROM quiz
GROUP BY style
ORDER BY COUNT(DISTINCT user_id) DESC;

-- MOST COMMON TYPES OF PURCHASE MADE

SELECT style, COUNT(DISTINCT user_id)
FROM purchase
WHERE style = 'Women''s Styles'
ORDER BY COUNT(DISTINCT user_id) DESC;

SELECT style, COUNT(DISTINCT user_id)
FROM purchase
WHERE style = 'Men''s Styles'
ORDER BY COUNT(DISTINCT user_id) DESC;
