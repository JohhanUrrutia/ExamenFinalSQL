DROP TABLE IF EXISTS Preguntas;
DROP TABLE IF EXISTS Usuarios;


CREATE TABLE IF NOT EXISTS Preguntas (
	id int primary key,
	pregunta varchar(255),
	respuesta_correcta varchar
);

INSERT INTO Preguntas(id, pregunta, respuesta_correcta) VALUES
(1, '¿Cuántos dias tiene un año?', '365 dias'),
(2, '¿Después del verano que estación viene?', 'Otoño'),
(3, '¿Cuántos segundos tiene una hora?', '3600 segundos'),
(4, '¿De qué color es el plátano?', 'Amarillo'),
(5, '¿Capital de Brazil?', 'Brasilia');

CREATE TABLE IF NOT EXISTS Usuarios (
	id int primary key,
	nombre varchar(255),
	edad int
);

INSERT INTO Usuarios(id, nombre, edad) VALUES
(1, 'Juan', 22),
(2, 'Emilio', 28),
(3, 'Esteban', 31),
(4, 'Millaray', 46),
(5, 'Camila', 18);

CREATE TABLE IF NOT EXISTS Respuestas (
	id int primary key,
	respuesta varchar(255),
	usuario_id int references Usuarios(id),
	pregunta_id int references Preguntas(id)
);

INSERT INTO Respuestas(id, respuesta, usuario_id, pregunta_id) VALUES
(1, '365 dias', 1, 1),
(2, '365 dias', 2, 1),
(3, 'Otoño', 3, 2),
(4, '3800 segundos', 4, 3),
(5, 'Azul', 5, 4);

/* Cuenta la cantidad de respuestas correctas
totales por usuario (independiente de la pregunta) */

SELECT u.nombre, COUNT(p.respuesta_correcta) respuestas_correctas
FROM Preguntas p
JOIN Respuestas r
ON p.respuesta_correcta = r.respuesta
JOIN Usuarios u
ON r.usuario_id = u.id
GROUP BY u.nombre
;

/* Por cada pregunta, en la tabla preguntas, 
cuenta cuántos usuarios tuvieron la respuesta correcta.  */

SELECT p.pregunta, COUNT(u.nombre) usuarios_respuesta_correcta
FROM Preguntas p
JOIN Respuestas r
ON p.respuesta_correcta = r.respuesta
JOIN Usuarios u
ON r.usuario_id = u.id
GROUP BY p.pregunta
ORDER BY p.pregunta ASC
;

/* Implementa borrado en cascada de las respuestas al borrar 
un usuario y borrar el primer usuario para probar la implementación. */

DROP TABLE IF EXISTS Respuestas;

CREATE TABLE IF NOT EXISTS Respuestas (
	id int primary key,
	respuesta varchar(255),
	usuario_id int references Usuarios(id) ON DELETE CASCADE,
	pregunta_id int references Preguntas(id)
);

DELETE FROM Usuarios u 
WHERE u.id = 1;

SELECT * FROM Usuarios;

/* Crea una restricción que impida insertar usuarios
menores de 18 años en la base de datos */

DROP TABLE IF EXISTS Usuarios;

CREATE TABLE IF NOT EXISTS Usuarios (
	id int primary key,
	nombre varchar(255),
	edad int check (edad >= 18)
);

INSERT INTO Usuarios(id, nombre, edad) VALUES
(1, 'Juan', 15);

/* Altera la tabla existente de usuarios agregando
el campo email con la restricción de único. */

ALTER TABLE Usuarios
add column email varchar unique;

SELECT * FROM Usuarios;