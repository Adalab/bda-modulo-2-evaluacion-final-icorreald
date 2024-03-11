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