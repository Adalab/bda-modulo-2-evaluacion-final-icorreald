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

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente, muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT C.customer_id AS ID, C.first_name AS nombre, C.last_name AS apellido, COUNT(R.customer_id) AS numero_alquileres
FROM customer AS C
INNER JOIN rental AS R
ON C.customer_id = R.customer_id
GROUP BY R.customer_id
ORDER BY C.customer_id
;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
		/* Necesitamos categoría y cantidad de películas alquiladas en respectiva categoría.
			Tomamos name de category
            De rental sacamos cuántas veces se ha alquilado una película según su ID de inventario
            Con este ID de inventario, podemos trazar hasta film_category las películas y su respectivo category_id
            Si agrupamos por dicho category_id, obtenemos cuántas películas de esa categoría se han alquilado
            Nótese que hay películas que están repetidas; es decir, registradas varias veces en el inventario. Las contamos porque sigue siendo
				una película alquilada de esa categoría*/
SELECT C.`name` AS categoria, COUNT(R.`inventory_id`) AS numero_alquileres
FROM rental AS R
INNER JOIN inventory AS I ON R.inventory_id = I.inventory_id
INNER JOIN film_category AS FC ON I.film_id = FC.film_id
INNER JOIN category AS C ON FC.category_id = C.category_id
GROUP BY C.category_id
;
-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.
SELECT rating, AVG(length)
FROM film
GROUP BY rating
; 

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT `first_name` AS nombre, `last_name` AS apellido
FROM actor AS A
INNER JOIN film_actor AS FA ON A.actor_id = FA.actor_id
INNER JOIN film AS F ON FA.film_id = F.film_id
WHERE F.film_id = 458
;
-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT `title`
FROM film
WHERE `description` LIKE '%_dog_%' OR '%_cat_%' 
;

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`.
##############################################
SELECT A.`first_name`, A.`last_name`
FROM actor AS A
LEFT JOIN film_actor AS FA USING (actor_id)
WHERE A.actor_id NOT IN (FA)
;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT `title`
FROM film
WHERE release_year BETWEEN 2005 AND 2010
;
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT F.`title`
FROM film AS F
INNER JOIN film_category AS FC ON F.film_id = FC.film_id
WHERE FC.category_id = 8
;

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT A.`first_name`, A.`last_name`
FROM actor AS A
WHERE actor_id IN (SELECT actor_id
					FROM film_actor
					GROUP BY actor_id
						HAVING COUNT(actor_id) > 10)
;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.
SELECT `title`
FROM film
WHERE `length` > 120 AND `rating` LIKE 'R'
;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT c.`name`, AVG(f.`length`) AS `duracion_media`
FROM category AS C

INNER JOIN film_category AS FC ON c.category_id = FC.category_id
INNER JOIN film AS F ON FC.film_id = F.film_id

GROUP BY c.category_id
HAVING `duracion_media`> 120
;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
SELECT A.first_name AS nombre, A.last_name AS apellido, COUNT(FA.actor_id) AS numero_peliculas
FROM actor AS A
INNER JOIN film_actor AS FA ON A.actor_id = FA.actor_id
GROUP BY FA.actor_id
	HAVING numero_peliculas > 4
    ;
    
-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
		/* NOTA: el "todas" me confunde un poco. Si se quiere tener la lista con los nombres de las películas repetidos, sólo habría que
        eliminar el DISTINCT del select*/
        
SELECT DISTINCT F.title
FROM film AS F 
INNER JOIN inventory AS I ON F.film_id = I.film_id
INNER JOIN rental AS R ON I.inventory_id = R.inventory_id
WHERE R.rental_id IN (SELECT rental_id 
						FROM rental
						WHERE DATEDIFF(return_date, rental_date) > 5)
;

-- 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
SELECT first_name AS nombre, last_name AS apellido
FROM actor
WHERE actor_id IN (SELECT actor_id 
						FROM film_actor
						WHERE film_id IN (SELECT film_id
											FROM film_category
											WHERE category_id = 11))