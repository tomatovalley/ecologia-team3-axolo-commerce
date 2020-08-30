CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) NOT NULL
);

INSERT INTO `categories` (`name`) VALUES
('Papel'),
('Carton'),
('Aluminio');



CREATE TABLE `manufacturing_categories`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category` INT NOT NULL
);
INSERT INTO manufacturing_categories(category) VALUES('Papel');

CREATE TABLE `manufacturers`(
    `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT NOT NULL,
    `id_category` INT NOT NULL REFERENCES manufacturing_categories(id),
    `city` TEXT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `picture` LONGTEXT NOT NULL,
    `lat` DOUBLE NULL,
    `lng` DOUBLE NULL
);
INSERT INTO manufacturers(title, description, id_category, city, phone, lat, lng)
VALUES(
    'Manufacturador de productos de papel',
    'Manufacturación de productos utilizando papel reciclado',
    1,
    'Culiacán',
    '6671234567',
    24.797733,
    -107.387154
);


CREATE TABLE `products` (
  `pid` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(1000) NOT NULL,
  `details` longtext NOT NULL,
  `uuid` binary(16) NOT NULL,
  `id_category` int(11) NOT NULL REFERENCES categories(id),
  `id_manufacturer` INT NOT NULL REFERENCES manufacturers(id), 
  `price` int(11) NOT NULL,
  `picture` longtext NOT NULL
);

INSERT INTO products (uuid, title, details, id_manufacturer, id_category, price, picture) VALUES
(UUID(), 'Block de hojas blancas', 'Lorem Ipsum ', 1, 1, 120, '12.jpg'),
(UUID(), 'Libreta de doble hoja', 'Lorem Ipsum ', 1, 1, 139, '13.jpg'),
(UUID(), 'Block de carpetas', 'Lorem Ipsum.', 1, 1, 99, '14.jpg'),
(UUID(), 'Cajas armables de carton', 'Lorem Ipsum ', 1, 1, 219, '15.jpg'),
(UUID(), 'Block de cajas de carton', 'Lorem Ipsum ', 1, 1, 120, '12.jpg'),
(UUID(), 'Termos de aluminio', 'Lorem Ipsum', 1, 1, 219, '15.jpg');

CREATE TABLE `traceability`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_product` CHAR(36) NOT NULL ,
    `id_parent` INT NULL REFERENCES product(id),
    `observation` TEXT NULL,
    UNIQUE(id_product, id_parent)
);