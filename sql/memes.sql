-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-05-2018 a las 11:59:18
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `memes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(2, 'WTF'),
(3, 'Animales'),
(4, 'Anime y manga'),
(5, 'Coches'),
(6, 'Comida'),
(7, 'Peliculas'),
(8, 'Horror'),
(9, 'Politica'),
(10, 'Estudios'),
(11, 'Viajes'),
(12, 'Juegos'),
(13, 'Deportes'),
(14, 'Tecnologia'),
(15, 'Familia y amigos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `autor` varchar(45) NOT NULL,
  `publicacion` varchar(45) NOT NULL,
  `texto` varchar(140) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id`, `autor`, `publicacion`, `texto`, `fecha`) VALUES
(1, 'usuario2', '1.jpg', 'Hola que tal', '2001-02-21 00:00:00'),
(2, 'usuario2', '1.jpg', 'Hola que tal', '2001-02-21 00:00:00'),
(3, 'usuario2', '1.jpg', 'gasgl2', '2001-02-22 00:00:00'),
(4, 'usuario2', '1.jpg', 'aaaaaaaaaaaaaaa', '2018-05-08 00:00:00'),
(5, 'usuario2', '1.jpg', 'aaa', '2018-05-08 00:00:00'),
(6, 'usuario2', '1.jpg', 'aaaaaaaaaaaaaaaaaaaaaaaa', '2018-05-08 00:00:00'),
(7, 'usuario2', '1.jpg', 'jeje', '2018-05-08 00:00:00'),
(8, 'usuario2', '1.jpg', 'jeje', '2018-05-08 00:00:00'),
(9, 'usuario2', '1.jpg', 'aaaaa', '2018-05-09 00:00:00'),
(10, 'usuario2', '1.jpg', 'hola david', '2018-05-09 00:00:00'),
(11, 'usuario2', '1.jpg', 'hola david', '2018-05-09 00:00:00'),
(12, 'usuario2', '1.jpg', 'hola david', '2018-05-09 00:00:00'),
(13, 'usuario2', '1.jpg', 'hola iker', '2018-05-10 00:00:00'),
(14, 'ibai', '1.jpg', 'FUNCIONA?', '2018-05-11 00:00:00'),
(15, 'ibai', '1.jpg', 'SIIIIIIIIIIIUUUUUUUUUUUUUUUUUUUUUUU', '2018-05-11 00:00:00'),
(16, 'ibai', '1.jpg', 'hmmmmmmmmmmmmmmmmmm', '2018-05-11 13:05:51'),
(17, 'ibai', '1.jpg', 'Vendo Opel Corsa', '2018-05-12 15:10:11'),
(18, 'ibai', '2.jpg', 'jajajajaajaj XDXDXDXDXD', '2018-05-13 10:23:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `esta_categorias`
--

CREATE TABLE `esta_categorias` (
  `publicacion` varchar(45) NOT NULL,
  `categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `esta_categorias`
--

INSERT INTO `esta_categorias` (`publicacion`, `categoria`) VALUES
('1.jpg', 2),
('11.png', 2),
('12.png', 10),
('13.png', 2),
('13.png', 9),
('14.png', 2),
('14.png', 12),
('14.png', 14),
('14.png', 15),
('15.jpg', 2),
('16.jpg', 15),
('4.jpg', 7),
('5.jpg', 12),
('6.jpg', 10),
('7.jpg', 9),
('8.jpg', 6),
('8.jpg', 13),
('9.jpg', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `etiquetas`
--

CREATE TABLE `etiquetas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `etiquetas`
--

INSERT INTO `etiquetas` (`id`, `nombre`) VALUES
(1, 'patxi'),
(2, 'facebook'),
(3, 'Hola Mundo'),
(4, 'nan'),
(5, 'adfih'),
(6, 'Marvel'),
(7, 'Disney'),
(8, 'Infinity War'),
(9, 'Avengers'),
(10, 'Pokemon'),
(11, ''),
(12, 'mark'),
(13, 'policia'),
(14, 'Matematicas'),
(15, 'numeros'),
(16, 'africa'),
(17, 'ropa'),
(18, 'fail'),
(19, 'amigos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mejores_publicaciones`
--

CREATE TABLE `mejores_publicaciones` (
  `publicacion` varchar(45) NOT NULL,
  `fecha_llegada` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mejores_publicaciones`
--

INSERT INTO `mejores_publicaciones` (`publicacion`, `fecha_llegada`) VALUES
('1.jpg', '2018-05-02 13:21:11'),
('12.png', '2018-05-13 11:54:02'),
('2.jpg', '2018-05-02 13:21:11'),
('3.jpg', '2018-05-13 11:54:02'),
('4.jpg', '2018-05-13 11:54:02'),
('5.jpg', '2018-05-13 11:54:02'),
('6.jpg', '2018-05-13 11:54:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE `publicaciones` (
  `id` varchar(45) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `fecha_subida` datetime NOT NULL,
  `autor` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `publicaciones`
--

INSERT INTO `publicaciones` (`id`, `titulo`, `fecha_subida`, `autor`) VALUES
('1.jpg', 'Cuando te preguntan como funciona la pagina', '2018-04-25 00:00:00', 'artola'),
('11.png', 'Cuando se te olvida la pistola en casa', '2018-05-12 15:58:08', 'artola'),
('12.png', 'Like si lo entendiste', '2018-05-12 15:58:27', 'artola'),
('13.png', '¡¡¡NADIE ME PUEDE PARAR!!!', '2018-05-12 15:58:44', 'artola'),
('14.png', 'El mejor anuncio de la historia', '2018-05-12 15:59:00', 'artola'),
('15.jpg', 'Momento muy incómodo con la ropa', '2018-05-13 11:37:54', 'ander'),
('16.jpg', '¿Por que siempre me pasan estas cosas?', '2018-05-13 11:41:46', 'ander'),
('2.jpg', 'No hay bug si el cliente no se da cuenta', '2018-05-01 00:00:00', 'artola'),
('3.jpg', 'Perdon por el spoiler :)', '2018-05-06 00:00:00', 'ander'),
('4.jpg', 'La historia de Los Vengadores contada con esta mítica escena de Toy Story', '2018-05-11 00:00:00', 'artola'),
('5.jpg', 'Tienes que lanzar la pokéball directamente y rezar', '2018-05-11 00:00:00', 'artola'),
('6.jpg', 'La adolescencia es dura', '2018-05-11 00:00:00', 'artola'),
('7.jpg', 'Todo son ventajas siendo la hija de Mark', '2018-05-11 00:00:00', 'artola'),
('8.jpg', 'Hay que compartir... o no', '2018-05-11 00:00:00', 'artola'),
('9.jpg', 'La otra cara de Los Vengadores', '2018-05-11 00:00:00', 'artola');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiene_e`
--

CREATE TABLE `tiene_e` (
  `publicacion` varchar(45) NOT NULL,
  `etiqueta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tiene_e`
--

INSERT INTO `tiene_e` (`publicacion`, `etiqueta`) VALUES
('1.jpg', 2),
('1.jpg', 3),
('11.png', 13),
('12.png', 14),
('12.png', 15),
('13.png', 16),
('14.png', 11),
('15.jpg', 17),
('16.jpg', 18),
('16.jpg', 19),
('4.jpg', 6),
('4.jpg', 7),
('4.jpg', 8),
('4.jpg', 9),
('5.jpg', 10),
('6.jpg', 11),
('7.jpg', 2),
('7.jpg', 12),
('8.jpg', 11),
('9.jpg', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `nombre` varchar(45) NOT NULL,
  `contrasena` varchar(80) DEFAULT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `rol` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`nombre`, `contrasena`, `imagen`, `rol`, `email`) VALUES
('ander', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', 'ander@sjdv.com'),
('artola', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', 'artola@zubiri.com'),
('Eneko', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', 'Eneko@gmail.com'),
('gas', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', 'aaa@gbdrg.com'),
('hola', '$2a$12$YMFnvdTAY.Oby/sGgojOruxZNvZRvFN22acEOAlUNhLLsAh7o.R1u', NULL, 'usuario', 'hola@hola.com'),
('ibai', '$2a$12$pZGVdL/xAHrlyYPyFkrOZODqJyib5yhoqvet2zfLoVXrdvwPrzpIG', NULL, 'admin', 'ibai@ibai.com'),
('jon', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', 'jaja@jajaja.com'),
('usuario2', '$2a$12$gAuDfrT3dllEqdmJShVd8u9P5.YikGXLwRC7pBEiT84EFceD9Y0PG', NULL, 'usuario', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `votar_c`
--

CREATE TABLE `votar_c` (
  `comentario` int(11) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `voto` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `votar_p`
--

CREATE TABLE `votar_p` (
  `usuario` varchar(45) NOT NULL,
  `publicacion` varchar(45) NOT NULL,
  `voto` tinyint(1) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `votar_p`
--

INSERT INTO `votar_p` (`usuario`, `publicacion`, `voto`, `fecha`) VALUES
('ander', '1.jpg', 1, '2018-05-02 00:00:00'),
('ander', '4.jpg', 1, '2018-05-12 00:00:00'),
('ander', '6.jpg', 1, '2018-05-11 00:00:00'),
('artola', '1.jpg', 1, '2018-04-25 12:00:00'),
('artola', '2.jpg', 0, '2018-04-30 00:00:00'),
('artola', '4.jpg', 1, '2018-05-11 00:00:00'),
('artola', '5.jpg', 1, '2018-05-11 00:00:00'),
('artola', '7.jpg', 1, '2018-05-09 00:00:00'),
('Eneko', '4.jpg', 1, '2018-05-04 00:00:00'),
('gas', '12.png', 1, '2018-05-10 00:00:00'),
('gas', '4.jpg', 0, '2018-05-11 00:00:00'),
('hola', '3.jpg', 0, '2018-05-11 00:00:00'),
('hola', '6.jpg', 1, '2018-05-11 00:00:00'),
('ibai', '4.jpg', 1, '2018-05-11 00:00:00'),
('usuario2', '1.jpg', 1, '2018-05-02 00:00:00'),
('usuario2', '6.jpg', 1, '2018-05-10 00:00:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_autor_comentario` (`autor`),
  ADD KEY `fk_publicacion_comentario` (`publicacion`);

--
-- Indices de la tabla `esta_categorias`
--
ALTER TABLE `esta_categorias`
  ADD PRIMARY KEY (`publicacion`,`categoria`),
  ADD KEY `fk_categorias_publicacion_c` (`categoria`);

--
-- Indices de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mejores_publicaciones`
--
ALTER TABLE `mejores_publicaciones`
  ADD PRIMARY KEY (`publicacion`);

--
-- Indices de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_autor_publicacion` (`autor`);

--
-- Indices de la tabla `tiene_e`
--
ALTER TABLE `tiene_e`
  ADD PRIMARY KEY (`publicacion`,`etiqueta`),
  ADD KEY `fk_etiqueta_publicacion_e` (`etiqueta`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`nombre`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `votar_c`
--
ALTER TABLE `votar_c`
  ADD PRIMARY KEY (`comentario`,`usuario`),
  ADD KEY `fk_votos_comentario_u` (`usuario`);

--
-- Indices de la tabla `votar_p`
--
ALTER TABLE `votar_p`
  ADD PRIMARY KEY (`usuario`,`publicacion`),
  ADD KEY `fk_votos_publicacion_p` (`publicacion`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `etiquetas`
--
ALTER TABLE `etiquetas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `fk_autor_comentario` FOREIGN KEY (`autor`) REFERENCES `usuarios` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_publicacion_comentario` FOREIGN KEY (`publicacion`) REFERENCES `publicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `esta_categorias`
--
ALTER TABLE `esta_categorias`
  ADD CONSTRAINT `fk_categorias_publicacion_c` FOREIGN KEY (`categoria`) REFERENCES `categorias` (`id`),
  ADD CONSTRAINT `fk_categorias_publicacion_p` FOREIGN KEY (`publicacion`) REFERENCES `publicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `mejores_publicaciones`
--
ALTER TABLE `mejores_publicaciones`
  ADD CONSTRAINT `fk_mejores_publicaciones` FOREIGN KEY (`publicacion`) REFERENCES `publicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `fk_autor_publicacion` FOREIGN KEY (`autor`) REFERENCES `usuarios` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tiene_e`
--
ALTER TABLE `tiene_e`
  ADD CONSTRAINT `fk_etiqueta_publicacion_e` FOREIGN KEY (`etiqueta`) REFERENCES `etiquetas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_etiqueta_publicacion_p` FOREIGN KEY (`publicacion`) REFERENCES `publicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `votar_c`
--
ALTER TABLE `votar_c`
  ADD CONSTRAINT `fk_votos_comentario_c` FOREIGN KEY (`comentario`) REFERENCES `comentarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_votos_comentario_u` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `votar_p`
--
ALTER TABLE `votar_p`
  ADD CONSTRAINT `fk_votos_publicacion_p` FOREIGN KEY (`publicacion`) REFERENCES `publicaciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_votos_publicacion_u` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`nombre`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
