CREATE DATABASE spotify;

USE spotify;

-- Создаём таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  username VARCHAR(100) NOT NULL COMMENT "Имя пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи"; 

-- Таблица профилей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "Ссылка на пользователя", 
  gender VARCHAR(1) NOT NULL COMMENT "Пол",
  birthday DATE COMMENT "Дата рождения",
  photo_id INT UNSIGNED COMMENT "Ссылка на фотографию пользователя",
  plan_id INT UNSIGNED NOT NULL COMMENT "Ссылка на план пользователя",
  country VARCHAR(2) COMMENT "Страна проживания в формате ISO 3166-1 alpha-2",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Профили";

-- Таблица дружбы
DROP TABLE IF EXISTS friendship;
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя инициатора",
  follower_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя для подписки",
  requested_at DATETIME DEFAULT NOW() COMMENT "Время подписки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",  
  PRIMARY KEY (user_id, follower_id) COMMENT "Составной первичный ключ"
) COMMENT "Таблица дружбы";

-- Таблица планов подписки
DROP TABLE IF EXISTS plans;
CREATE TABLE plans (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(100) NOT NULL COMMENT "Название тарифного плана", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Подписки";

-- Таблица медиафайлов
DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  filename VARCHAR(255) NOT NULL COMMENT "Путь к файлу",
  size INT NOT NULL COMMENT "Размер файла",
  metadata JSON COMMENT "Метаданные файла",
  media_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип контента",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Медиафайлы";

-- Таблица типов медиафайлов
DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы медиафайлов";

-- Таблица исполнителей
DROP TABLE IF EXISTS artists;
CREATE TABLE artists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL COMMENT "Имя исполнителя или название группы",
  about TEXT COMMENT "Информация об исполнителе/группе",
  photo_id INT UNSIGNED COMMENT "Ссылка на фотографию исполнителя/группы",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Исполнители";

-- Таблица альбомов
DROP TABLE IF EXISTS albums;
CREATE TABLE albums (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL COMMENT "Название альбома",
  album_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип альбома",
  photo_id INT UNSIGNED COMMENT "Ссылка на обложку альбома",
  release_date DATETIME NOT NULL COMMENT "Дата релиза",
  label_id INT UNSIGNED NOT NULL COMMENT "Ссылка на лэйбл",
  artist_id INT UNSIGNED NOT NULL COMMENT "Ссылка на исполнителя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Альбомы";

-- Таблица лэйблов
DROP TABLE IF EXISTS labels;
CREATE TABLE labels (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL COMMENT "Название лэйбла",
  copyright VARCHAR(255) NOT NULL COMMENT "Текст копирайта",
  logo_id INT UNSIGNED COMMENT "Ссылка на логотип лэйбла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Лэйблы";

-- Таблица типов альбомов (альбом, сингл, EP и т.д.)
DROP TABLE IF EXISTS album_types;
CREATE TABLE album_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Название типа",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Типы альбомов";

-- Таблица композиций
DROP TABLE IF EXISTS tracks;
CREATE TABLE tracks (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL COMMENT "Название трэка",
  media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на файл",
  explicit BOOLEAN NOT NULL COMMENT "Содержание ненормативной лексики",
  duration INT UNSIGNED NOT NULL COMMENT "Продолжительность трэка в мс",
  tempo INT UNSIGNED NOT NULL COMMENT "Темп трэка уд/мин (bpm)",
  loudness INT UNSIGNED NOT NULL COMMENT "Максимальная громкость трэка в дб", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Композиции/песни/трэки";

-- Таблица трэк-исполнитель. У одного трэка может быть несколько авторов
DROP TABLE IF EXISTS track_artists;
CREATE TABLE track_artists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  track_id INT UNSIGNED NOT NULL COMMENT "Ссылка на трэк",
  artist_id INT UNSIGNED NOT NULL COMMENT "Ссылка на исполнителя",
  is_main_artist BOOLEAN NOT NULL COMMENT "Признак основного исполнителя",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица связи трэка с автором";

-- Таблица альбом-трэки
DROP TABLE IF EXISTS album_tracks;
CREATE TABLE album_tracks (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  album_id INT UNSIGNED NOT NULL COMMENT "Ссылка на альбом",
  track_id INT UNSIGNED NOT NULL COMMENT "Ссылка на трэк",
  disk_number INT UNSIGNED NOT NULL COMMENT "Порядковый номер диска в альбоме, чаще всего 1",
  track_number INT UNSIGNED NOT NULL COMMENT "Порядковый номер трэка на диске или в альбоме",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица связи альбома с трэками";

-- Таблица истории воспроизведения
DROP TABLE IF EXISTS playback_history;
CREATE TABLE playback_history (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  track_id INT UNSIGNED NOT NULL COMMENT "Ссылка на трэк",
  previous_track_id INT UNSIGNED NOT NULL COMMENT "Ссылка на предыдущий трэк",
  track_playback_progress INT UNSIGNED NOT NULL COMMENT "Процент прослушивания композиции",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица истории воспроизведения";

-- Таблица любимых трэков/альбомов/исполнителей
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  target_id INT UNSIGNED NOT NULL COMMENT "Ссылка на объект",
  target_type_id INT UNSIGNED NOT NULL COMMENT "Ссылка на тип объекта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица любимых трэков/альбомов/исполнителей";

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "Ссылка на тип объекта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица типов лайков";