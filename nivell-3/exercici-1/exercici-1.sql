SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE IF NOT EXISTS tasca_s2_01_n3_e1;
USE tasca_s2_01_n3_e1;

CREATE TABLE user (
  user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(255) NOT NULL,
  username VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(25),
  country VARCHAR(50),
  postal_code VARCHAR(20)
);

CREATE TABLE artist (
  artist_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  profile_picture VARCHAR(200)
);

CREATE TABLE album (
  album_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  artist_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  published_at DATE,
  cover_image VARCHAR(200),
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE song (
  song_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  album_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  duration SMALLINT,
  play_count INT DEFAULT 0,
  FOREIGN KEY (album_id) REFERENCES album(album_id)
);

CREATE TABLE payment_method (
  payment_method_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  method VARCHAR(20) NOT NULL
);

CREATE TABLE subscription (
  subscription_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  started_at DATE NOT NULL,
  renovation DATE,
  user_id INT NOT NULL,
  payment_method_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

CREATE TABLE payment (
  payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  date DATE NOT NULL,
  order_number INT NOT NULL,
  total SMALLINT NOT NULL,
  subscription_id INT NOT NULL,
  FOREIGN KEY (subscription_id) REFERENCES subscription(subscription_id)
);

CREATE TABLE credit_card_payment (
  payment_method_id INT NOT NULL PRIMARY KEY,
  expiration DATE NOT NULL,
  ccv SMALLINT NOT NULL,
  FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

CREATE TABLE paypal_payment (
  payment_method_id INT NOT NULL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  FOREIGN KEY (payment_method_id) REFERENCES payment_method(payment_method_id)
);

CREATE TABLE playlist (
  playlist_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  song_count SMALLINT DEFAULT 0,
  created_at DATE NOT NULL,
  removed_at DATE,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE playlist_song (
  playlist_id INT NOT NULL,
  song_id INT NOT NULL,
  added_by INT NOT NULL,
  added_at DATE NOT NULL,
  PRIMARY KEY (playlist_id, song_id),
  FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
  FOREIGN KEY (song_id) REFERENCES song(song_id),
  FOREIGN KEY (added_by) REFERENCES user(user_id)
);

CREATE TABLE user_follow_artist (
  user_id INT NOT NULL,
  artist_id INT NOT NULL,
  PRIMARY KEY (user_id, artist_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE related_artist (
  artist_id INT NOT NULL,
  related_artist_id INT NOT NULL,
  PRIMARY KEY (artist_id, related_artist_id),
  FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
  FOREIGN KEY (related_artist_id) REFERENCES artist(artist_id)
);

CREATE TABLE favourite_album (
  user_id INT NOT NULL,
  album_id INT NOT NULL,
  PRIMARY KEY (user_id, album_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (album_id) REFERENCES album(album_id)
);

CREATE TABLE favourite_song (
  user_id INT NOT NULL,
  song_id INT NOT NULL,
  PRIMARY KEY (user_id, song_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (song_id) REFERENCES song(song_id)
);

INSERT INTO user (email, password, username, date_of_birth, gender, country, postal_code) VALUES
('alice@example.com','pwd123','Alice','1990-01-01','Female','Spain','08001'),
('bob@example.com','pwd123','Bob','1985-05-12','Male','Spain','08002'),
('carol@example.com','pwd123','Carol','1992-07-20','Female','Spain','08003');

INSERT INTO artist (name, profile_picture) VALUES
('Artist A','artist_a.png'),
('Artist B','artist_b.png'),
('Artist C','artist_c.png');

INSERT INTO album (artist_id, name, published_at, cover_image) VALUES
(1,'Album 1','2020-01-01','album1.png'),
(2,'Album 2','2021-05-15','album2.png'),
(3,'Album 3','2019-09-10','album3.png');

INSERT INTO song (album_id, name, duration, play_count) VALUES
(1,'Song A1',180,10),
(1,'Song A2',200,5),
(2,'Song B1',210,15),
(3,'Song C1',190,8);

INSERT INTO payment_method (method) VALUES
('Credit Card'),
('Paypal');

INSERT INTO subscription (started_at, renovation, user_id, payment_method_id) VALUES
('2026-01-01','2027-01-01',1,1),
('2026-02-01','2027-02-01',2,2);

INSERT INTO payment (date, order_number, total, subscription_id) VALUES
('2026-01-01',1001,10,1),
('2026-02-01',1002,15,2);

INSERT INTO credit_card_payment (payment_method_id, expiration, ccv) VALUES
(1,'2028-12-31',123);

INSERT INTO paypal_payment (payment_method_id, username) VALUES
(2,'bob_paypal');

INSERT INTO playlist (name, song_count, created_at, removed_at, user_id) VALUES
('Alice Playlist',2,'2026-03-01',NULL,1),
('Bob Playlist',1,'2026-03-02',NULL,2);

INSERT INTO playlist_song (playlist_id, song_id, added_by, added_at) VALUES
(1,1,1,'2026-03-01'),
(1,2,1,'2026-03-01'),
(2,3,2,'2026-03-02');

INSERT INTO user_follow_artist (user_id, artist_id) VALUES
(1,1),
(1,2),
(2,2),
(3,3);

INSERT INTO related_artist (artist_id, related_artist_id) VALUES
(1,2),
(2,1),
(2,3);

INSERT INTO favourite_album (user_id, album_id) VALUES
(1,1),
(2,2),
(3,3);

INSERT INTO favourite_song (user_id, song_id) VALUES
(1,1),
(1,2),
(2,3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;