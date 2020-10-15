-- 10 Самых "любимых" трэков
 SELECT
	l.target_id,
	t.name,
	COUNT(target_id) AS total_likes
FROM
	likes l
JOIN tracks t ON
	l.target_id = t.id
WHERE
	l.target_type_id = 3
GROUP BY
	l.target_id
ORDER BY
	total_likes DESC LIMIT 10;

-- Рейтинг "любимых" треков артиста
SELECT
	t.name AS track_name,
	a2.name AS artist_name,
	COUNT(l.target_id) as total_likes
FROM
	likes l
JOIN tracks t ON
	l.target_id = t.id
JOIN track_artists ta ON
	l.target_id = ta.track_id
JOIN artists a2 ON
	ta.artist_id = a2.id
WHERE
	l.target_type_id = 3 AND ta.is_main_artist = 1 AND a2.id = 3 GROUP BY l.target_id ORDER BY total_likes DESC;

SELECT SUM(likes_total) FROM  
  (SELECT 
    (SELECT COUNT(*) FROM playback_history ph WHERE ph.user_id = p.user_id) AS likes_total  
    FROM profiles p
    ORDER BY p.birthday 
    DESC LIMIT 10) AS user_listens
;  

-- Сколько треков прослушали 10 самых молодых пользователей
SELECT
	(SELECT u.username FROM users u WHERE u.id = p.user_id) AS user_name,
	p.birthday,
	(SELECT COUNT(*)
	FROM playback_history ph
	WHERE ph.user_id = p.user_id) AS listen_totals
FROM
	profiles p
ORDER BY
	p.birthday DESC
LIMIT 10;

-- Рейтинг прослушивания треков
SELECT
	t.name,
	COUNT(ph.track_id) AS totat_listens
FROM
	playback_history ph
JOIN tracks t ON
	ph.track_id = t.id
GROUP BY
	ph.track_id;

-- Сколько места занимают файлы в разрезе типов
 SELECT
	media_types.name,
	SUM(media.size) AS total_by_type,
	(SELECT SUM(size)
	FROM media) AS total_size,
	SUM(media.size)/(SELECT SUM(size) FROM media) * 100 AS "%%"
FROM
	media
JOIN media_types ON
	media.media_type_id = media_types.id
GROUP BY
	media.media_type_id;