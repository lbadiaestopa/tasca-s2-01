SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP DATABASE IF EXISTS tasca_s2_01_n1_e2;
CREATE DATABASE tasca_s2_01_n1_e2
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE tasca_s2_01_n1_e2;

CREATE TABLE client (
    client_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    postal_code MEDIUMINT NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE shop (
    shop_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    postal_code MEDIUMINT NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);

CREATE TABLE employee (
    employee_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    job_role VARCHAR(50) NOT NULL,
    shop_id SMALLINT NOT NULL,
    FOREIGN KEY (shop_id) REFERENCES shop(shop_id)
);

CREATE TABLE pizza_type (
    pizza_type_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE product (
    product_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    image VARCHAR(100),
    price DECIMAL(6,2) NOT NULL,
    pizza_type_id SMALLINT,
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_type(pizza_type_id)
);

CREATE TABLE `order` (
    order_id MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    date DATETIME NOT NULL,
    delivery_method VARCHAR(50) NOT NULL,
    price DECIMAL(6,2),
    delivery_datetime DATETIME,
    client_id SMALLINT NOT NULL,
    shop_id SMALLINT NOT NULL,
    employee_id SMALLINT,
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (shop_id) REFERENCES shop(shop_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE order_quantity (
    order_id MEDIUMINT NOT NULL,
    product_id SMALLINT NOT NULL,
    quantity TINYINT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO client (name, surname, address, postal_code, city, province, phone)
VALUES
('Joan', 'Garcia', 'Carrer Major 10', 8001, 'Barcelona', 'Barcelona', '600123456'),
('Anna', 'Martinez', 'Carrer Nou 25', 8002, 'Barcelona', 'Barcelona', '600654321');

INSERT INTO shop (address, postal_code, city, province)
VALUES
('Avinguda Diagonal 100', 8005, 'Barcelona', 'Barcelona'),
('Gran Via 200', 8006, 'Barcelona', 'Barcelona');

INSERT INTO employee (name, surname, nif, phone, job_role, shop_id)
VALUES
('Marc', 'Lopez', '12345678A', '600111111', 'cook', 1),
('Laura', 'Perez', '87654321B', '600222222', 'delivery', 1),
('David', 'Sanchez', '45678912C', '600333333', 'cook', 2);

INSERT INTO pizza_type (name)
VALUES
('Classic'),
('Special');

INSERT INTO product (name, description, image, price, pizza_type_id)
VALUES
('Margherita', 'Pizza', 'margherita.jpg', 8.50, 1),
('Pepperoni', 'Pizza', 'pepperoni.jpg', 9.50, 2),
('Cheeseburger', 'Hamburguesa', 'burger.jpg', 7.00, NULL),
('Cola', 'Beguda', 'cola.jpg', 2.00, NULL);

INSERT INTO `order` (date, delivery_method, price, delivery_datetime, client_id, shop_id, employee_id)
VALUES
('2026-03-07 20:00:00', 'delivery', 19.50, '2026-03-07 20:30:00', 1, 1, 2),
('2026-03-07 21:00:00', 'pickup', 9.50, NULL, 2, 1, NULL);

INSERT INTO order_quantity (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;