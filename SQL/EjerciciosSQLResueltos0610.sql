-- 1. --Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto 
-- 2.--Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto 
-- 3. Todas las columnas de producto: 
SELECT * FROM producto 
-- 4 y 5. Precios en euros y dólares (con o sin alias): 
SELECT nombre as nombreDeProducto, precio as Euros, precio * 1.06 AS Dólares FROM producto
--6 y 7. Nombres en mayúsculas o minúsculas: 
SELECT UPPER(nombre), precio FROM producto  
SELECT LOWER(nombre), precio FROM producto 
-- 8. Dos primeros caracteres del fabricante en mayúsculas: 
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) FROM fabricante 
-- 9 y 10. Redondeo o truncamiento de precios: 
SELECT nombre, ROUND(precio, 0) FROM producto  
SELECT nombre, FLOOR(precio) AS precioTruncado FROM producto 
-- 11 y 12. Códigos de fabricantes con productos (con y sin duplicados): 
SELECT DISTINCT p.id_fabricante FROM producto p inner join fabricante f on p.id_fabricante = f.id
-- 13 y 14. Fabricantes ordenados ASC/DESC: 
SELECT nombre FROM fabricante ORDER BY nombre ASC  
SELECT nombre FROM fabricante ORDER BY nombre DESC 
-- 15. Ordenar por nombre ASC y precio DESC: 
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC 
-- 16 y 17. Límites y rangos (LIMIT): 
SELECT TOP 5 * FROM fabricante 
SELECT * FROM fabricante ORDER BY id OFFSET 3 ROWS FETCH NEXT 2 ROWS ONLY 
-- 18 y 19. Producto más barato y más caro: 
SELECT TOP 1 nombre, precio FROM producto ORDER BY precio ASC 
SELECT TOP 1 nombre, precio FROM producto ORDER BY precio DESC 
-- 20. Productos de fabricante con código 2: 
SELECT nombre FROM producto WHERE id_fabricante = 2 
--21. --Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT nombre, precio FROM producto WHERE precio <= 120 
--22. --Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT nombre FROM producto WHERE precio >= 400 
--23. --Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre, precio FROM producto WHERE NOT precio >= 400 
SELECT nombre, precio FROM producto WHERE precio < 400 
--24. --Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT * FROM producto WHERE precio >= 80 AND precio <= 300 
--25. --Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200 
--26. --Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.
SELECT * FROM producto WHERE precio > 200 AND id_fabricante = 6 
--27. --Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT * FROM producto WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5 
--28. --Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE id_fabricante IN (1, 3, 5) 
--29. --Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT nombre, precio * 100 AS céntimos FROM producto 
--30. --Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%' 
--31. --Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante WHERE nombre LIKE '%e' 
--32. --Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%' 
--33. --Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante WHERE LEN(nombre) = 4
SELECT nombre FROM fabricante WHERE nombre LIKE '____' 
--34. --Devuelve una --Lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%' 
--35. --Devuelve una --Lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215 
/**36. --Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).**/
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC

-- 1.1.4 Consultas multitabla (Composición interna)
/** 1. --Devuelve un --Listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
El --Listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.**/
SELECT p.nombre, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id 
/** 2. --Devuelve una --Lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
Ordene el resultado por nombre de fabricante, por orden alfabético.**/
SELECT p.nombre as producto, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY f.nombre ASC

SELECT p.nombre as producto, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY f.nombre ASC, p.precio desc
--3. --Devuelve una --Lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.id, p.nombre, f.id, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
--4. --Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT top 1 p.nombre, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY p.precio ASC

SELECT p.nombre, p.precio, f.nombre 
FROM dbo.producto p 
INNER JOIN dbo.fabricante f on p.id_fabricante = f.id 
WHERE p.precio = (SELECT MIN(precio) FROM producto )
--5. --Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT top 1 p.nombre, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY p.precio DESC
--6. --Devuelve una --Lista de todos los productos del fabricante Lenovo.
SELECT p.*, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo' 

SELECT p.*, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre like '%ovo' 
--7. --Devuelve una --Lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.* 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Crucial' AND p.precio > 200 
--8. --Devuelve un --Listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT p.* 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate' 
--9. --Devuelve un --Listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
SELECT p.* 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate') 
--10. --Devuelve un --Listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, p.precio 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%e' 
--11. --Devuelve un --Listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w.
SELECT p.nombre, p.precio 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%w%' 
--12. --Devuelve un --Listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. 
--Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT p.nombre, p.precio, f.nombre 
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC 
--13. --Devuelve un --Listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT f.id, f.nombre 
FROM fabricante f
INNER JOIN producto p ON f.id = p.id_fabricante 
--1.1.5 Consultas multitabla (Composición externa)
-- 1. --Devuelve un --Listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
--El --Listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT f.nombre, p.nombre 
FROM fabricante f
LEFT JOIN producto p ON f.id = p.id_fabricante 

SELECT f.nombre, p.nombre 
FROM  producto p
RIGHT JOIN fabricante f ON f.id = p.id_fabricante 
-- 2. --Devuelve un --Listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.*, p.nombre
FROM fabricante f
LEFT JOIN producto p ON f.id = p.id_fabricante
WHERE p.id_fabricante IS NULL 


select * from fabricante
select * from producto
