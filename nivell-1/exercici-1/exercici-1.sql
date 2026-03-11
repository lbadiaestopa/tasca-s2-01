SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS tasca_s2_01_n1_e1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE tasca_s2_01_n1_e1;

CREATE TABLE supplier (
    supplier_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL,
    number SMALLINT NOT NULL,
    floor TINYINT,
    door TINYINT,
    city VARCHAR(50) NOT NULL,
    postal_code MEDIUMINT,
    country VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    fax VARCHAR(20),
    nif VARCHAR(9) NOT NULL
);

CREATE TABLE brand (
    brand_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    supplier_id SMALLINT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

CREATE TABLE model (
    model_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    prescription_left DECIMAL(4,2) NOT NULL,
    prescription_right DECIMAL(4,2) NOT NULL,
    frame_style ENUM('flotant', 'pasta', 'metàl·lica') NOT NULL,
    frame_color VARCHAR(50) NOT NULL,
    left_glass_color VARCHAR(50) NOT NULL,
    right_glass_color VARCHAR(50) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    brand_id SMALLINT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

CREATE TABLE client (
    client_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    postal_code MEDIUMINT,
    phone VARCHAR(20),
    email VARCHAR(50),
    registration_date DATE NOT NULL,
    referring_client_id SMALLINT NULL,
    FOREIGN KEY (referring_client_id) REFERENCES client(client_id)
);

CREATE TABLE employee (
    employee_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE sale (
	sale_id MEDIUMINT PRIMARY KEY AUTO_INCREMENT,
	sale_date DATE NOT NULL,
    price DECIMAL(6, 2),
    client_id SMALLINT NOT NULL,
    model_id SMALLINT NOT NULL,
    employee_id SMALLINT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

INSERT INTO SUPPLIER (name, street, number, city, postal_code, country, phone, nif)
VALUES 
('Vision Plus', 'Carrer Major', 15, 'Madrid', 28001, 'Spain', '911223344', 'B87654321'),
('Optica Nova', 'Rambla', 8, 'Valencia', 46001, 'Spain', '963112233', 'B23456789');

INSERT INTO BRAND (name, supplier_id)
VALUES
('Oakley', 2),
('Persol', 2),
('Gucci', 1);

INSERT INTO MODEL (brand_id, prescription_left, prescription_right, frame_style, frame_color, left_glass_color, right_glass_color, price)
VALUES
(1, 1.0, 1.0, 'pasta', 'Black', 'Green', 'Green', 200.00),
(2, 0.75, 0.75, 'flotant', 'Brown', 'Clear', 'Clear', 180.50),
(3, 1.25, 1.25, 'metàl·lica', 'Gold', 'Blue', 'Blue', 250.00);

INSERT INTO CLIENT (name, postal_code, phone, email, registration_date, referring_client_id)
VALUES
('Anna Garcia', 08003, '600111222', 'anna@example.com', '2026-03-01', 1),
('Joan Puig', 08004, '600222333', 'joan@example.com', '2026-03-02', NULL),
('Marta Soler', 08005, '600333444', 'marta@example.com', '2026-03-03', 2);

INSERT INTO EMPLOYEE (name)
VALUES
('Carlos Perez'),
('Elena Torres');

INSERT INTO SALE (sale_date, price, client_id, model_id, employee_id)
VALUES
('2026-03-06', 200.00, 2, 1, 2),
('2026-03-07', 180.50, 3, 2, 1),
('2026-03-08', 250.00, 1, 3, 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;