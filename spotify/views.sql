-- Представление для отображение альбома-трэка
CREATE OR REPLACE
VIEW albums_tracks AS
SELECT
	a.name AS album_name,
	t.name AS track_name
FROM
	album_tracks at2
JOIN albums a ON
	at2.album_id = a.id
JOIN tracks t ON
	at2.track_id = t.id
ORDER BY
	a.name;
	
-- Представление для отображение исполнитель-альбома-трэка
CREATE OR REPLACE
VIEW artists_albums_tracks AS
SELECT
	a2.name AS artist_name,
	a.name AS album_name,
	t.name AS track_name
FROM
	album_tracks at2
JOIN albums a ON
	at2.album_id = a.id
JOIN tracks t ON
	at2.track_id = t.id
JOIN artists a2 ON
	a.artist_id = a2.id
ORDER BY
	a2.name,
	a.name;
	
-- Представление для отображение лэйбл-альбом
CREATE OR REPLACE
VIEW labels_albums AS
SELECT
	l.name AS label_name,
	a.name AS album_name
FROM albums a 
JOIN labels l ON
	a.label_id = l.id
ORDER BY
	l.name;