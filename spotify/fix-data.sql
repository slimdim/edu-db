-- Поправляем данные

-- Обновляем временные метки по всем таблицам 
UPDATE album_tracks SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE album_types SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE albums SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE artists SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE friendship SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE labels SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE likes SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE media_types SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE plans SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE playback_history SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE target_types SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE track_artists SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE tracks SET updated_at = NOW() WHERE updated_at < created_at;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

-- Обновляем ID
UPDATE friendship SET follower_id = FLOOR(1 + RAND() * 100);
UPDATE track_artists SET artist_id = FLOOR(1 + RAND() * 20);
UPDATE album_tracks SET track_id = FLOOR(1 + RAND() * 400);

-- Исправляем случай когда user_id = follower_id
UPDATE friendship SET follower_id = follower_id + 1 WHERE user_id = follower_id;

-- Правим таблицу с медиаконтентом
-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('mp3'), ('wav');

-- Проверяем
SELECT * FROM extensions;

-- Обновляем ссылку на файл
UPDATE media SET filename = CONCAT(
  'http://s3.aws.amazon.com/spotify/',
  filename ,
  (SELECT username FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Заполняем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT username FROM users ORDER BY RAND() LIMIT 1),
  '"}'); 
 
-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Добавляю пропущенный стобец user_id для таблицы playback_history
ALTER TABLE playback_history ADD COLUMN user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя";

-- Заполняем данными
UPDATE playback_history SET user_id = FLOOR(1 + RAND() * 100);
