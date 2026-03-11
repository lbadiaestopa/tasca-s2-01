SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE DATABASE IF NOT EXISTS tasca_s2_01_n3_e1;
USE tasca_s2_01_n3_e1;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('man','woman','other','prefer_not_to_say'),
    country VARCHAR(50),
    postal_code VARCHAR(20)
);

CREATE TABLE channel (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    created_at DATE NOT NULL,
    user_id INT UNIQUE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE user_channel_subscription (
    user_id INT NOT NULL,
    channel_id INT NOT NULL,
    subscribed_at DATETIME NOT NULL,
    PRIMARY KEY(user_id, channel_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (channel_id) REFERENCES channel(channel_id)
);

CREATE TABLE video (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    file_size INT NOT NULL,
    file_name VARCHAR(100) NOT NULL,
    duration TIME NOT NULL,
    thumbnail VARCHAR(100),
    view_count INT NOT NULL DEFAULT 0,
    visibility ENUM('public','private','hidden') NOT NULL,
    published_at DATETIME NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE video_rating (
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    reaction_type ENUM('like','dislike') NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY(user_id, video_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE video_tag (
    tag_id INT NOT NULL,
    video_id INT NOT NULL,
    PRIMARY KEY(tag_id, video_id),
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE comment (
    comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(500) NOT NULL,
    created_at DATETIME NOT NULL,
    user_id INT NOT NULL,
    video_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE playlist (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL,
    visibility VARCHAR(10) NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE comment_rating (
    user_id INT NOT NULL,
    comment_id BIGINT NOT NULL,
    reaction_type ENUM('like','dislike') NOT NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY(user_id, comment_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id)
);

CREATE TABLE playlist_video (
    playlist_id INT NOT NULL,
    video_id INT NOT NULL,
    PRIMARY KEY(playlist_id, video_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

INSERT INTO user (email, password, username, date_of_birth, gender, country, postal_code) VALUES
('alice@example.com','pass1','alice', '1995-01-15','woman','Spain','08001'),
('bob@example.com','pass2','bob', '1990-06-22','man','Spain','08002'),
('carol@example.com','pass3','carol', '1988-03-12','woman','France','75001'),
('dave@example.com','pass4','dave', '1992-11-05','man','USA','10001');

INSERT INTO channel (name, description, created_at, user_id) VALUES
('Alice Vlogs','Canal de vlogs i tutorials','2022-01-01',1),
('Bob Gaming','Gameplay i streams','2021-06-15',2),
('Carol Cooking','Receptes fàcils i ràpides','2022-03-20',3);

INSERT INTO user_channel_subscription (user_id, channel_id, subscribed_at) VALUES
(1,2,'2023-01-10 09:00:00'),
(2,1,'2023-01-11 10:00:00'),
(3,1,'2023-03-01 12:00:00'),
(4,3,'2023-03-06 15:00:00');

INSERT INTO video (title, description, file_size, file_name, duration, thumbnail, view_count, visibility, published_at, user_id) VALUES
('Vlog 1','Primer vlog','1024','vlog1.mp4','00:10:00','thumb1.jpg',120,'public','2023-01-10 10:00:00',1),
('Gaming Session','Partida divertida','2048','game1.mp4','01:20:00','thumb2.jpg',450,'public','2023-02-12 15:30:00',2),
('Recepta Pasta','Com fer pasta','512','pasta.mp4','00:15:00','thumb3.jpg',300,'public','2023-03-05 09:00:00',3),
('Vlog 2','Segon vlog','1024','vlog2.mp4','00:12:00','thumb4.jpg',80,'private','2023-01-15 12:00:00',1);

INSERT INTO video_rating (user_id, video_id, reaction_type, created_at) VALUES
(1,2,'like','2023-02-13 10:00:00'),
(2,1,'like','2023-01-11 11:00:00'),
(3,1,'dislike','2023-01-12 14:00:00'),
(4,3,'like','2023-03-06 08:00:00');

INSERT INTO tag (name) VALUES
('Vlog'),('Gaming'),('Cooking'),('Tutorial');

INSERT INTO video_tag (tag_id, video_id) VALUES
(1,1),(1,4),(2,2),(3,3),(4,1),(4,4);

INSERT INTO comment (text, created_at, user_id, video_id) VALUES
('Molt bo!','2023-01-10 11:00:00',2,1),
('Molt divertit!','2023-02-12 16:00:00',1,2),
('Bon vídeo','2023-03-05 10:00:00',4,3),
('Espero més tutorials','2023-01-15 13:00:00',3,4);

INSERT INTO playlist (name, created_at, visibility, user_id) VALUES
('Favorites','2023-01-20 09:00:00','public',1),
('Gaming Hits','2023-02-20 10:00:00','private',2),
('Recipes','2023-03-10 11:00:00','public',3);

INSERT INTO comment_rating (user_id, comment_id, reaction_type, created_at) VALUES
(1,1,'like','2023-01-10 12:00:00'),
(2,2,'like','2023-02-12 17:00:00'),
(3,3,'like','2023-03-05 11:00:00'),
(4,4,'dislike','2023-01-15 14:00:00');

INSERT INTO playlist_video (playlist_id, video_id) VALUES
(1,1),(1,4),(2,2),(3,3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;