SHOW tables;

SELECT * FROM users LIMIT 10;

DESC users;

UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

DESC profiles;

UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;

SELECT * FROM profiles LIMIT 10;

UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

UPDATE profiles SET status = NULL;

CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название статуса (уникально)",
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Справочник статусов";

INSERT INTO user_statuses (name) VALUES
 ('single'),
 ('married'),
 ('in_relationship');
 
SELECT * FROM user_statuses;

ALTER TABLE profiles RENAME COLUMN status TO user_status_id;

ALTER TABLE profiles MODIFY COLUMN user_status_id INT UNSIGNED;

UPDATE profiles SET user_status_id = FLOOR(1 + RAND() * 3);

CREATE TEMPORARY TABLE genders (name CHAR(1));

INSERT INTO genders VALUES ('m'), ('f');

SELECT * FROM genders;

UPDATE profiles SET gender = (SELECT name FROM genders ORDER BY RAND() LIMIT 1);

SHOW TABLES;

DESC messages;

SELECT * FROM messages LIMIT 10;

UPDATE messages SET updated_at = NOW() WHERE updated_at < created_at;

UPDATE messages SET from_user_id = FLOOR(1 + RAND() * 100), to_user_id = FLOOR(1 + RAND() * 100);

DESC media;

SELECT * FROM media LIMIT 10;

UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;

SELECT * FROM media_types;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

TRUNCATE media_types;

SELECT * FROM media LIMIT 10;

UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

SELECT * FROM extensions;

UPDATE media SET filename = CONCAT(
  'https://s3.aws.amazon.com/vk/',
  SUBSTRING(metadata, 1, 2),
  (SELECT last_name FROM users ORDER BY RAND() LIMIT 1),
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 5000;

UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');
  
ALTER TABLE media MODIFY COLUMN metadata JSON;

RENAME TABLE friendship TO friendships;

SELECT * FROM friendships LIMIT 10;

UPDATE friendships SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);
  
UPDATE friendships SET friend_id = friend_id + 1 WHERE user_id = friend_id;

TRUNCATE friendship_statuses;

SELECT * FROM friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');
  
UPDATE friendships SET status_id = FLOOR(1 + RAND() * 3);

SELECT * FROM communities;

SELECT * FROM communities_users;

UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);