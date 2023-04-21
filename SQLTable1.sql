DROP TABLE IF EXISTS peliculas;
DROP TABLE IF EXISTS tags;

CREATE TABLE IF NOT EXISTS tags (
	id int primary key,
	tag varchar(32)
);

CREATE TABLE IF NOT EXISTS peliculas (
	id int primary key,
	nombre varchar(255),
	anno int
);

INSERT INTO peliculas(id, nombre, anno) VALUES
(1, 'E.T', 1982),
(2, 'Scary Movie', 2000),
(3, 'Stranger Things', 2016),
(4, 'Super Mario Bros', 2023),
(5, 'Barbie', 2023);

INSERT INTO tags(id, tag) VALUES
(1, 'Aventura'),
(2, 'Suspenso'),
(3, 'Comedia'),
(4, 'Terror'),
(5, 'Acción');

CREATE TABLE IF NOT EXISTS peliculas_tags (
	pelicula_id int references peliculas(id),
	tag_id int references tags(id)
);

INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

/* Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0. */

SELECT p.nombre, COUNT (t.tag) cantidad_tags
FROM tags t
JOIN peliculas_tags pt
ON t.id = pt.tag_id
JOIN peliculas p
ON p.id = pt.pelicula_id
GROUP BY p.nombre
;