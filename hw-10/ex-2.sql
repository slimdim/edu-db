
-- 2е задание. Задание на оконные функции. Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
 SELECT
	DISTINCT c.name,
	COUNT(p.user_id) OVER() / (
	SELECT
		COUNT(*)
	FROM
		communities) AS average_users,
	MAX(p.birthday) OVER c_window AS youngest,
	MIN(p.birthday) OVER c_window AS oldest,
	COUNT(p.user_id) OVER c_window AS total_in_group,
	SELECT
		COUNT(*)
	FROM
		profiles AS total_users,
	COUNT(p.user_id) OVER c_window / COUNT(p.user_id) OVER() * 100 AS "%%"
FROM
	(communities c
LEFT JOIN communities_users cu ON
	c.id = cu.community_id
JOIN profiles p ON
	cu.user_id = p.user_id) WINDOW c_window AS (PARTITION BY c.id);