-- ============================================================
CREATE DATABASE IF NOT EXISTS VibeVault;
USE VibeVault;


-- 1. Users
CREATE TABLE Users (
    user_id     BIGINT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    subscription_type ENUM('free', 'premium', 'family') NOT NULL,
    country     VARCHAR(100),
    city        VARCHAR(100)
);

-- 2. Artists
CREATE TABLE Artists (
    artist_id   BIGINT PRIMARY KEY AUTO_INCREMENT,
    stage_name  VARCHAR(255) NOT NULL UNIQUE,
    first_name  VARCHAR(100),
    last_name   VARCHAR(100)
);

-- 3. Songs
CREATE TABLE Songs (
    song_id             BIGINT PRIMARY KEY AUTO_INCREMENT,
    title               VARCHAR(255) NOT NULL,
    duration_seconds    INT NOT NULL,
    release_date        DATE,
    primary_artist_id   BIGINT NOT NULL,
    FOREIGN KEY (primary_artist_id) REFERENCES Artists(artist_id)
);

-- 4. Albums
CREATE TABLE Albums (
    album_id    BIGINT PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(255) NOT NULL,
    release_date DATE,
    artist_id   BIGINT NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

-- 5. Playlists
CREATE TABLE Playlists (
    playlist_id     BIGINT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(255) NOT NULL,
    privacy_setting ENUM('public', 'private') DEFAULT 'public',
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id         BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 6. Listening_Sessions
CREATE TABLE Listening_Sessions (
    session_id          BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id             BIGINT NOT NULL,
    song_id             BIGINT NOT NULL,
    played_at           DATETIME DEFAULT CURRENT_TIMESTAMP,
    device_type         ENUM('mobile', 'desktop', 'tablet', 'smart_tv'),
    duration_seconds    INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);


-- 7. Album_Songs
CREATE TABLE Album_Songs (
    album_id BIGINT NOT NULL,
    song_id  BIGINT NOT NULL,
    track_number INT,
    PRIMARY KEY (album_id, song_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (song_id)  REFERENCES Songs(song_id)
);

-- 8. Song_Features (featured artists on a song)
CREATE TABLE Song_Features (
    song_id     BIGINT NOT NULL,
    artist_id   BIGINT NOT NULL,
    PRIMARY KEY (song_id, artist_id),
    FOREIGN KEY (song_id)   REFERENCES Songs(song_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

-- 9. User_Follows_Artist
CREATE TABLE User_Follows_Artist (
    user_id     BIGINT NOT NULL,
    artist_id   BIGINT NOT NULL,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, artist_id),
    FOREIGN KEY (user_id)   REFERENCES Users(user_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

-- 10. Playlist_Songs
CREATE TABLE Playlist_Songs (
    playlist_id BIGINT NOT NULL,
    song_id     BIGINT NOT NULL,
    position    INT,
    added_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id),
    FOREIGN KEY (song_id)     REFERENCES Songs(song_id)
);

-- 11. User_Follows_Playlist
CREATE TABLE User_Follows_Playlist (
    user_id     BIGINT NOT NULL,
    playlist_id BIGINT NOT NULL,
    followed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, playlist_id),
    FOREIGN KEY (user_id)     REFERENCES Users(user_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id)
);

-- 12. Artist_Genre
CREATE TABLE Artist_Genre (
    artist_id BIGINT NOT NULL,
    genre     VARCHAR(100) NOT NULL,
    PRIMARY KEY (artist_id, genre),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);


-- 13. Song_Formats
CREATE TABLE Song_Formats (
    song_id BIGINT NOT NULL,
    format  ENUM('MP3', 'FLAC', 'WAV', 'AAC') NOT NULL,
    PRIMARY KEY (song_id, format),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);

-- 14. Artist_Social_Links
CREATE TABLE Artist_Social_Links (
    artist_id BIGINT NOT NULL,
    platform  VARCHAR(100) NOT NULL,
    url       VARCHAR(500),
    PRIMARY KEY (artist_id, platform),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

-- 15. User_Devices
CREATE TABLE User_Devices (
    device_id   BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id     BIGINT NOT NULL,
    device_name VARCHAR(255),
    device_type ENUM('mobile', 'desktop', 'tablet', 'smart_tv'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- Users
INSERT INTO Users (first_name, last_name, email, subscription_type, country, city) VALUES
('Alice',    'Johnson', 'alice@example.com',    'premium', 'USA',       'New York'),
('Bob',      'Smith',   'bob@example.com',      'free',    'India',     'Delhi'),
('Charlie',  'Brown',   'charlie@example.com',  'family',  'UK',        'London'),
('David',    'Miller',  'david@example.com',    'premium', 'Canada',    'Toronto'),
('Emma',     'Wilson',  'emma@example.com',     'free',    'Australia', 'Sydney'),
('Frank',    'Taylor',  'frank@example.com',    'premium', 'Germany',   'Berlin'),
('Grace',    'Thomas',  'grace@example.com',    'family',  'France',    'Paris'),
('Henry',    'Clark',   'henry@example.com',    'free',    'USA',       'Chicago'),
('Isabella', 'Lewis',   'isabella@example.com', 'premium', 'Brazil',    'Rio'),
('Jack',     'Walker',  'jack@example.com',     'family',  'Italy',     'Rome'),
('Karen',    'Hall',    'karen@example.com',    'free',    'India',     'Mumbai'),
('Liam',     'Allen',   'liam@example.com',     'premium', 'Ireland',   'Dublin'),
('Mia',      'Young',   'mia@example.com',      'premium', 'Spain',     'Madrid'),
('Noah',     'King',    'noah@example.com',     'free',    'USA',       'Los Angeles'),
('Olivia',   'Scott',   'olivia@example.com',   'family',  'Australia', 'Melbourne');

-- Artists
INSERT INTO Artists (stage_name, first_name, last_name) VALUES
('Drake',          'Aubrey',  'Graham'),
('Adele',          'Adele',   'Adkins'),
('Ed Sheeran',     'Ed',      'Sheeran'),
('Taylor Swift',   'Taylor',  'Swift'),
('BTS',            'Bangtan', 'Boys'),
('The Weeknd',     'Abel',    'Tesfaye'),
('Dua Lipa',       'Dua',     'Lipa'),
('Shawn Mendes',   'Shawn',   'Mendes'),
('Coldplay',       'Chris',   'Martin'),
('Billie Eilish',  'Billie',  'Eilish'),
('Bruno Mars',     'Bruno',   'Hernandez'),
('Katy Perry',     'Katy',    'Hudson'),
('Imagine Dragons','Dan',     'Reynolds'),
('Selena Gomez',   'Selena',  'Gomez'),
('Justin Bieber',  'Justin',  'Bieber');

-- Songs
INSERT INTO Songs (title, duration_seconds, release_date, primary_artist_id) VALUES
('Gods Plan',          198, '2018-01-19', 1),
('Hello',              295, '2015-10-23', 2),
('Shape of You',       234, '2017-01-06', 3),
('Love Story',         235, '2008-09-15', 4),
('Dynamite',           199, '2020-08-21', 5),
('Blinding Lights',    200, '2019-11-29', 6),
('Levitating',         203, '2020-03-27', 7),
('Senorita',           191, '2019-06-21', 8),
('Yellow',             270, '2000-07-17', 9),
('Bad Guy',            194, '2019-03-29', 10),
('Uptown Funk',        270, '2014-11-10', 11),
('Roar',               220, '2013-08-10', 12),
('Believer',           204, '2017-02-01', 13),
('Lose You To Love Me',205, '2019-10-23', 14),
('Peaches',            198, '2021-03-19', 15);

-- Albums
INSERT INTO Albums (title, release_date, artist_id) VALUES
('Scorpion',        '2018-06-29', 1),
('25',              '2015-11-20', 2),
('Divide',          '2017-03-03', 3),
('Fearless',        '2008-11-11', 4),
('BE',              '2020-11-20', 5),
('After Hours',     '2020-03-20', 6),
('Future Nostalgia','2020-03-27', 7),
('Shawn Mendes',    '2018-05-25', 8),
('Parachutes',      '2000-07-10', 9),
('When We All Fall Asleep', '2019-03-29', 10),
('24K Magic',       '2016-11-18', 11),
('Prism',           '2013-10-18', 12),
('Evolve',          '2017-06-23', 13),
('Rare',            '2020-01-10', 14),
('Justice',         '2021-03-19', 15);

-- Album_Songs
INSERT INTO Album_Songs (album_id, song_id, track_number) VALUES
(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),
(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),
(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1);

-- Song_Features
INSERT INTO Song_Features (song_id, artist_id) VALUES
(1,15),(3,14),(5,12),(7,11),(9,8),
(11,6),(13,4),(2,3),(4,2),(6,1);

-- Artist_Genre
INSERT INTO Artist_Genre (artist_id, genre) VALUES
(1,'Hip-Hop'),(2,'Pop'),(3,'Pop'),(4,'Country'),(5,'K-Pop'),
(6,'R&B'),(7,'Pop'),(8,'Pop'),(9,'Rock'),(10,'Indie'),
(11,'Funk'),(12,'Pop'),(13,'Rock'),(14,'Pop'),(15,'Pop');

-- Artist_Social_Links
INSERT INTO Artist_Social_Links (artist_id, platform, url) VALUES
(1,'Instagram','insta.com/drake'),(2,'Twitter','twitter.com/adele'),
(3,'YouTube','youtube.com/edsheeran'),(4,'Instagram','insta.com/taylorswift'),
(5,'Weverse','weverse.io/bts'),(6,'Twitter','twitter.com/theweeknd'),
(7,'Instagram','insta.com/dualipa'),(8,'Twitter','twitter.com/shawnmendes'),
(9,'YouTube','youtube.com/coldplay'),(10,'Instagram','insta.com/billieeilish');

-- Song_Formats
INSERT INTO Song_Formats (song_id, format) VALUES
(1,'MP3'),(2,'FLAC'),(3,'WAV'),(4,'AAC'),(5,'MP3'),
(6,'MP3'),(7,'FLAC'),(8,'MP3'),(9,'WAV'),(10,'AAC'),
(11,'MP3'),(12,'FLAC'),(13,'MP3'),(14,'WAV'),(15,'AAC');

-- User_Devices
INSERT INTO User_Devices (user_id, device_name, device_type) VALUES
(1,'iPhone 13','mobile'),(2,'Samsung S21','mobile'),(3,'MacBook Pro','desktop'),
(4,'iPad Air','tablet'),(5,'Windows PC','desktop'),(6,'OnePlus 9','mobile'),
(7,'Sony Xperia','mobile'),(8,'Dell XPS','desktop'),(9,'Google Pixel 6','mobile'),
(10,'Samsung Tab S7','tablet'),(11,'HP Envy','desktop'),(12,'iPhone 14','mobile'),
(13,'Asus ROG','desktop'),(14,'iPad Pro','tablet'),(15,'Lenovo ThinkPad','desktop');

-- Playlists
INSERT INTO Playlists (name, privacy_setting, user_id) VALUES
('Morning Vibes',   'public',  1),
('Workout Mix',     'public',  2),
('Late Night',      'private', 3),
('Road Trip',       'public',  4),
('Study Mode',      'private', 5),
('Party Hits',      'public',  6),
('Chill Out',       'public',  7),
('Top Charts',      'public',  8),
('Throwbacks',      'private', 9),
('New Releases',    'public',  10);

-- Playlist_Songs
INSERT INTO Playlist_Songs (playlist_id, song_id, position) VALUES
(1,1,1),(1,6,2),(1,7,3),
(2,5,1),(2,11,2),(2,13,3),
(3,2,1),(3,9,2),(3,4,3),
(4,3,1),(4,8,2),(4,15,3),
(5,10,1),(5,14,2),(5,12,3),
(6,6,1),(6,1,2),(6,5,3),
(7,9,1),(7,7,2),(7,2,3),
(8,3,1),(8,10,2),(8,6,3),
(9,4,1),(9,11,2),(9,13,3),
(10,15,1),(10,8,2),(10,14,3);

-- User_Follows_Artist
INSERT INTO User_Follows_Artist (user_id, artist_id) VALUES
(1,1),(1,6),(2,3),(2,7),(3,2),(3,4),(4,5),(4,10),
(5,9),(6,11),(7,2),(8,6),(9,13),(10,15),(11,4),(12,7),
(13,1),(14,3),(15,8);

-- User_Follows_Playlist
INSERT INTO User_Follows_Playlist (user_id, playlist_id) VALUES
(2,1),(3,2),(4,3),(5,4),(6,5),
(7,6),(8,7),(9,8),(10,9),(1,10);

-- Listening_Sessions
INSERT INTO Listening_Sessions (user_id, song_id, played_at, device_type, duration_seconds) VALUES
(1,1, '2026-01-01 08:00:00','mobile',  198),
(1,6, '2026-01-01 08:05:00','mobile',  200),
(2,3, '2026-01-02 10:00:00','desktop', 234),
(3,2, '2026-01-02 11:00:00','tablet',  295),
(4,5, '2026-01-03 09:00:00','mobile',  199),
(5,10,'2026-01-03 14:00:00','desktop', 194),
(6,11,'2026-01-04 07:30:00','mobile',  270),
(7,7, '2026-01-04 20:00:00','tablet',  203),
(8,9, '2026-01-05 16:00:00','desktop', 270),
(9,13,'2026-01-05 18:00:00','mobile',  204),
(10,4,'2026-01-06 09:00:00','mobile',  235),
(11,8,'2026-01-06 21:00:00','desktop', 191),
(12,15,'2026-01-07 12:00:00','mobile', 198),
(13,12,'2026-01-07 15:00:00','tablet', 220),
(14,14,'2026-01-08 10:00:00','desktop',205),
(15,1,'2026-01-08 11:00:00','mobile',  198),
(1,3, '2026-01-09 08:00:00','mobile',  234),
(2,6, '2026-01-09 09:00:00','desktop', 200),
(3,7, '2026-01-10 10:00:00','tablet',  203),
(4,2, '2026-01-10 11:00:00','mobile',  295),
(5,11,'2026-01-11 14:00:00','desktop', 270),
(6,5, '2026-01-11 15:00:00','mobile',  199),
(7,10,'2026-01-12 20:00:00','tablet',  194),
(8,4, '2026-01-12 21:00:00','desktop', 235),
(9,8, '2026-01-13 09:00:00','mobile',  191),
(10,6,'2026-01-13 10:00:00','mobile',  200),
(11,1,'2026-01-14 07:30:00','desktop', 198),
(12,9,'2026-01-14 08:00:00','mobile',  270),
(13,3,'2026-01-15 16:00:00','tablet',  234),
(14,7,'2026-01-15 17:00:00','desktop', 203);


-- Q1: Top 5 most streamed songs
SELECT s.title, a.stage_name AS artist,
       COUNT(*) AS total_streams
FROM Listening_Sessions ls
JOIN Songs s ON ls.song_id = s.song_id
JOIN Artists a ON s.primary_artist_id = a.artist_id
GROUP BY s.song_id, s.title, a.stage_name
ORDER BY total_streams DESC
LIMIT 5;

-- Q2: Streams by subscription type
SELECT u.subscription_type,
       COUNT(*) AS total_streams,
       ROUND(AVG(ls.duration_seconds), 2) AS avg_session_duration
FROM Listening_Sessions ls
JOIN Users u ON ls.user_id = u.user_id
GROUP BY u.subscription_type
ORDER BY total_streams DESC;

-- Q3: Most followed artists
SELECT a.stage_name,
       COUNT(*) AS followers
FROM User_Follows_Artist ufa
JOIN Artists a ON ufa.artist_id = a.artist_id
GROUP BY a.artist_id, a.stage_name
ORDER BY followers DESC
LIMIT 5;

-- Q4: Streams by device type
SELECT device_type,
       COUNT(*) AS total_streams
FROM Listening_Sessions
GROUP BY device_type
ORDER BY total_streams DESC;

-- Q5: Users with most listening time (top 5)
SELECT CONCAT(u.first_name, ' ', u.last_name) AS user_name,
       u.subscription_type,
       SUM(ls.duration_seconds) AS total_seconds_listened
FROM Listening_Sessions ls
JOIN Users u ON ls.user_id = u.user_id
GROUP BY ls.user_id, u.first_name, u.last_name, u.subscription_type
ORDER BY total_seconds_listened DESC
LIMIT 5;

-- Q6: Songs never streamed
SELECT s.title, a.stage_name AS artist
FROM Songs s
JOIN Artists a ON s.primary_artist_id = a.artist_id
LEFT JOIN Listening_Sessions ls ON s.song_id = ls.song_id
WHERE ls.session_id IS NULL;

-- Q7: Average song duration by genre
SELECT ag.genre,
       ROUND(AVG(s.duration_seconds), 2) AS avg_duration_seconds
FROM Songs s
JOIN Artists a ON s.primary_artist_id = a.artist_id
JOIN Artist_Genre ag ON a.artist_id = ag.artist_id
GROUP BY ag.genre
ORDER BY avg_duration_seconds DESC;

-- Q8: Streams per country
SELECT u.country,
       COUNT(*) AS total_streams
FROM Listening_Sessions ls
JOIN Users u ON ls.user_id = u.user_id
GROUP BY u.country
ORDER BY total_streams DESC;

-- Q9: Artists with no streams
SELECT a.stage_name
FROM Artists a
LEFT JOIN Songs s ON a.artist_id = s.primary_artist_id
LEFT JOIN Listening_Sessions ls ON s.song_id = ls.song_id
WHERE ls.session_id IS NULL;

-- Q10: Premium vs free user stream share
SELECT u.subscription_type,
       COUNT(*) AS streams,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Listening_Sessions), 2) AS percentage
FROM Listening_Sessions ls
JOIN Users u ON ls.user_id = u.user_id
GROUP BY u.subscription_type;


-- View: Premium users only
CREATE VIEW vw_premium_users AS
SELECT user_id, CONCAT(first_name,' ',last_name) AS full_name,
       email, country, city
FROM Users
WHERE subscription_type = 'premium';

-- View: Song with artist name
CREATE VIEW vw_song_details AS
SELECT s.song_id, s.title, s.duration_seconds, s.release_date,
       a.stage_name AS artist
FROM Songs s
JOIN Artists a ON s.primary_artist_id = a.artist_id;


CREATE INDEX idx_song_title      ON Songs(title);
CREATE INDEX idx_artist_stage    ON Artists(stage_name);
CREATE INDEX idx_session_user    ON Listening_Sessions(user_id);
CREATE INDEX idx_session_song    ON Listening_Sessions(song_id);
CREATE INDEX idx_user_email      ON Users(email);