-- 3е задание. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
  (SELECT
    gender FROM profiles p WHERE p.user_id = l.user_id) AS gender,
    COUNT(*) AS num
  FROM likes l
  GROUP BY gender
  ORDER BY num DESC
  LIMIT 1;

-- 4е задание. Подсчитать общее количество лайков десяти самым молодым пользователям
-- (сколько лайков получили 10 самых молодых пользователей)
   
SELECT COUNT(*) FROM likes l
  WHERE l.target_type_id = 2
    AND l.target_id IN
      (SELECT * FROM
        (SELECT p.user_id FROM profiles p ORDER BY p.birthday DESC LIMIT 10)
      AS youngers);
      
-- 5е задание. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
     
SELECT 
  u.id, u.first_name, u.last_name,
	(SELECT COUNT(*) FROM likes l WHERE l.user_id = u.id) + 
	(SELECT COUNT(*) FROM messages m WHERE m.from_user_id = u.id) AS activity 
  FROM users u
  ORDER BY activity
  LIMIT 10;