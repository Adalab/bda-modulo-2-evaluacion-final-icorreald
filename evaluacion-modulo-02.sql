##########################
-- EVALUACIÓN MODULO 02 --
##########################

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title
FROM film
;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT title
FROM film
WHERE rating LIKE 'PG-13'
;
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT `title`, `description`
FROM film
WHERE `description` LIKE '%_amazing_%'
;

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT `title`
FROM film
WHERE `length` > 120
; 
-- 5. Recupera los nombres de todos los actores.
SELECT `first_name` AS Nombre, `last_name` AS Apellido
FROM actor
;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT `first_name` AS Nombre, `last_name` AS Apellido
FROM actor
WHERE `last_name` LIKE 'Gibson'
;

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT `first_name`
FROM actor
WHERE `actor_id` BETWEEN 10 AND 20
;

-- 8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT `title` 
FROM film
WHERE `rating` NOT LIKE 'R' OR 'PG-13'
;

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.
SELECT `rating`, COUNT(`rating`) AS `numero_peliculas`
FROM film
GROUP BY `rating`
;

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente
	-- muestra el ID del cliente, su nombre y apellido junto con 
    -- la cantidad de películas alquiladas.

SELECT C.customer_id AS ID, C.first_name AS nombre, C.last_name AS apellido, COUNT(R.customer_id) AS numero_alquileres
FROM customer AS C
INNER JOIN rental AS R
ON C.customer_id = R.customer_id
GROUP BY R.customer_id
ORDER BY C.customer_id
;
