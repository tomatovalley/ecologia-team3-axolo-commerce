CREATE TABLE `manufacturadores`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(255) NOT NULL,
    `ciudad` TEXT NULL,
    `descripcion` TEXT NULL,
    `categoria` INT NOT NULL,
    `lat` DOUBLE NULL,
    `lng` DOUBLE NULL
);

ALTER TABLE
    `manufacturadores` ADD PRIMARY KEY `manufacturadores_id_primary`(`id`);
ALTER TABLE
    `manufacturadores` ADD UNIQUE `manufacturadores_nombre_unique`(`nombre`);

CREATE TABLE `categorias_manufactura`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `categoria` INT NOT NULL
);

ALTER TABLE
    `categorias_manufactura` ADD PRIMARY KEY `categorias_manufactura_id_primary`(`id`);


CREATE TABLE `rastreabilidad`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `producto` CHAR(36) NOT NULL,
    `padre` INT NULL,
    `observacion` TEXT NOT NULL
);

ALTER TABLE
    `rastreabilidad` ADD PRIMARY KEY `rastreabilidad_id_primary`(`id`);

CREATE TABLE `producto`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` binary(16) NOT NULL,
    `nombre`VARCHAR(32) NOT NULL,
    `manufacturador` INT NOT NULL,
    `categoria` INT NOT NULL,
    `descripcion` TEXT NULL,
    `precio` DOUBLE NOT NULL,
    `imagen` longtext NOT NULL
);



ALTER TABLE
    `producto` ADD PRIMARY KEY `producto_id_primary`(`id`);

CREATE TABLE `categorias_producto`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `nombre` TEXT NOT NULL
);

ALTER TABLE
    `categorias_producto` ADD PRIMARY KEY `categorias_producto_id_primary`(`id`);
ALTER TABLE
    `manufacturadores` ADD CONSTRAINT `manufacturadores_categoria_foreign` FOREIGN KEY(`categoria`) REFERENCES `categorias_manufactura`(`id`);
ALTER TABLE
    `rastreabilidad` ADD CONSTRAINT `rastreabilidad_padre_foreign` FOREIGN KEY(`padre`) REFERENCES `rastreabilidad`(`id`);
ALTER TABLE
    `producto` ADD CONSTRAINT `producto_categoria_foreign` FOREIGN KEY(`categoria`) REFERENCES `categorias_producto`(`id`);
ALTER TABLE
    `producto` ADD CONSTRAINT `producto_manufacturador_foreign` FOREIGN KEY(`manufacturador`) REFERENCES `manufacturadores`(`id`);


INSERT INTO `categorias_producto` (`id`, `name`) VALUES
('Papel'),
('Carton'),
('Aluminio');
/*
CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `content` longtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `pages` (`id`, `slug`, `title`, `content`) VALUES
(1, 'about', 'About Us', '<p>eCommerce is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\n\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>'),
(2, 'contact', 'Contact Us', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d58911.87500168799!2d88.39522544634136!3d22.65407989591108!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39f89e6c605d82ff%3A0x1f6779d05c4879ee!2sDum+Dum%2C+Kolkata%2C+West+Bengal!5e0!3m2!1sen!2sin!4v1524345317520" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>\n\n<address>\n<strong>Dumdum, Kolkata</strong><br>\nWest Bengal, INDIA<br>\nPin: 700030<br>\n<abbr title="Phone">Phone:</abbr> +91 9647 5724 19<br>\n<abbr title="Email">Email:</abbr> sendmail2krrish@gmail.com\n</address>');





CREATE TABLE `producto`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `uuid` CHAR(36) NOT NULL,
    `nombre`VARCHAR(32) NOT NULL,
    `manufacturador` INT NOT NULL,
    `categoria` INT NOT NULL,
    `descripcion` TEXT NULL,
    `precio` DOUBLE NOT NULL,
    `imagen` longtext NOT NULL
);


INSERT INTO `products` (`id`    , `uuid`, `nombre`, `manufacturador`, `categoria`, `descripcion`,`precio`,`imagen`) VALUES
(1, 1, 'Block de hojas blancas', 'Lorem Ipsum ', 120, '12.jpg'),
	(2, 2, 'Libreta de doble hoja', 'Lorem Ipsum ', 139, '13.jpg'),
(3, 2, 'Block de carpetas', 'Lorem Ipsum.', 99, '14.jpg'),
(4, 3, 'Cajas armables de carton', 'Lorem Ipsum ', 219, '15.jpg'),
(5, 1, 'Block de cajas de carton', 'Lorem Ipsum ', 120, '12.jpg'),
(6, 3, 'Termos de aluminio', 'Lorem Ipsum', 219, '15.jpg');

*/

-- --------------------------------------------------------