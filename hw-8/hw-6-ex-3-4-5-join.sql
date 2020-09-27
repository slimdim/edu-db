-- 3е задание. Определить кто больше поставил лайков (всего) - мужчины или женщины?
 
SELECT p.gender, COUNT(*) AS num
  FROM likes l
    JOIN profiles p
      ON l.user_id = p.user_id
  GROUP BY p.gender
  ORDER BY num DESC
  LIMIT 1;

-- 4е задание. Подсчитать общее количество лайков десяти самым молодым пользователям
-- (сколько лайков получили 10 самых молодых пользователей)
   
SELECT SUM(likes_count)
  FROM (SELECT SUM(l.target_type_id = 2) AS likes_count
    FROM profiles p
      JOIN likes l
        ON p.user_id = l.target_id
    GROUP BY p.user_id 
    ORDER BY p.birthday DESC
    LIMIT 10)
AS youngers;
      
-- 5е задание. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
     

SELECT u.id, u.first_name, u.last_name, COUNT(l.user_id) + COUNT(m.from_user_id) as activity
  FROM users u
    LEFT JOIN likes l ON u.id = l.user_id
    LEFT JOIN messages m ON u.id = m.from_user_id
  GROUP BY u.id
  ORDER BY activity
  LIMIT 10;
