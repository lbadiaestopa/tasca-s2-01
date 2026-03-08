CREATE DATABASE IF NOT EXISTS tasca_s2_01_n2_e1;
USE tasca_s2_01_n2_e1;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(50),
    password VARCHAR(255),
    username VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(25),
    country VARCHAR(50),
    postal_code VARCHAR(20)
);

CREATE TABLE channel (
    channel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(500),
    created_at DATE,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE video (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(500),
    file_size INT,
    file_name VARCHAR(100),
    duration TIME,
    thumbnail VARCHAR(100),
    view_count INT,
    visibility VARCHAR(10),
    published_at DATETIME,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE video_rating (
    user_id INT,
    video_id INT,
    reaction_type VARCHAR(10),
    created_at DATETIME,
    PRIMARY KEY(user_id, video_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE video_tag (
    tag_id INT,
    video_id INT,
    PRIMARY KEY(tag_id, video_id),
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE comment (
    comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(500),
    created_at DATETIME,
    user_id INT,
    video_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

CREATE TABLE playlist (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    created_at DATETIME,
    visibility VARCHAR(10),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE comment_rating (
    user_id INT,
    comment_id BIGINT,
    reaction_type VARCHAR(10),
    created_at DATETIME,
    PRIMARY KEY(user_id, comment_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id)
);

CREATE TABLE playlist_video (
    playlist_id INT,
    video_id INT,
    PRIMARY KEY(playlist_id, video_id),
    FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id),
    FOREIGN KEY (video_id) REFERENCES video(video_id)
);

INSERT INTO user (email, password, username, date_of_birth, gender, country, postal_code) VALUES
('alice@example.com','pass1','alice', '1995-01-15','Female','Spain','08001'),
('bob@example.com','pass2','bob', '1990-06-22','Male','Spain','08002'),
('carol@example.com','pass3','carol', '1988-03-12','Female','France','75001'),
('dave@example.com','pass4','dave', '1992-11-05','Male','USA','10001');

INSERT INTO channel (name, description, created_at, user_id) VALUES
('Alice Vlogs','Canal de vlogs i tutorials','2022-01-01',1),
('Bob Gaming','Gameplay i streams','2021-06-15',2),
('Carol Cooking','Receptes fàcils i ràpides','2022-03-20',3);

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