--1.5.4 Consultas sobre una tabla
--1. Listado con el primer apellido, segundo apellido y el nombre de todos los alumnos, ordenado alfabéticamente
SELECT apellido1, apellido2, nombre 
FROM alumno 
ORDER BY apellido1, apellido2, nombre ASC
--ORDER BY 1, 2, 3 ASC).

--2. Nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono
SELECT nombre, apellido1, apellido2 
FROM alumno 
WHERE telefono IS NULL
--3. Listado de los alumnos que nacieron en 1999
SELECT * 
FROM alumno 
WHERE YEAR(fecha_nacimiento) = '1999'
--WHERE fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31')

--4. Listado de profesores que no han dado de alta su teléfono y su NIF termina en K
SELECT * 
FROM profesor 
WHERE telefono IS NULL AND nif LIKE '%K'
--5. Listado de las asignaturas del primer cuatrimestre, tercer curso y grado con identificador 7
SELECT * 
FROM asignatura 
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7

--1.5.5 Consultas multitabla
--1. Alumnas matriculadas alguna vez en el Grado en Ingeniería Informática (Plan 2015)
SELECT DISTINCT a.*
FROM alumno a
INNER JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
INNER JOIN asignatura asi ON am.id_asignatura = asi.id
INNER JOIN grado g ON asi.id_grado = g.id
WHERE a.sexo = 'M' 
  AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'

--2. Asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015)
SELECT a.*
FROM asignatura a
INNER JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'

--3. Profesores junto con el nombre de su departamento (ordenado)
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor p
INNER JOIN departamento d ON p.id_departamento = d.id
ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC

--4. Asignaturas y curso escolar del alumno con NIF '26902806M'
SELECT asi.nombre AS nombre_asignatura, c.anyo_inicio, c.anyo_fin
FROM alumno a
INNER JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
INNER JOIN asignatura asi ON am.id_asignatura = asi.id
INNER JOIN curso_escolar c ON am.id_curso_escolar = c.id
WHERE a.nif = '26902806M'

--5. Departamentos con profesores que imparten en el Grado en Ingeniería Informática (Plan 2015)
SELECT DISTINCT d.nombre
FROM departamento d
INNER JOIN profesor prof ON d.id = prof.id_departamento
INNER JOIN asignatura a ON prof.id = a.id_profesor
INNER JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'


--6. Alumnos matriculados en alguna asignatura durante el curso 2018/2019
SELECT DISTINCT a.*
FROM alumno a
INNER JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
INNER JOIN curso_escolar c ON am.id_curso_escolar = c.id
WHERE c.anyo_inicio = 2015 
  AND c.anyo_fin = 2016

select * from curso_escolar

--1.5.6 Consultas multitabla
--1. Profesores y sus departamentos (incluyendo profesores sin departamento asignado)
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id
ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC

--2. Profesores que no están asociados a un departamento
SELECT p.nombre, p.apellido1, p.apellido2
FROM profesor p
WHERE p.id_departamento IS NULL

--3. Departamentos que no tienen profesores asociados
SELECT d.*
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
WHERE prof.id IS NULL

--4. Profesores que no imparten ninguna asignatura
SELECT p.nombre, p.apellido1, p.apellido2
FROM profesor p
LEFT JOIN asignatura a ON p.id = a.id_profesor
WHERE a.id_profesor IS NULL

--5. Asignaturas que no tienen un profesor asignado
SELECT *
FROM asignatura
WHERE id_profesor IS NULL

--6. Departamentos con asignaturas que nunca se han impartido en ningún curso escolar
SELECT d.nombre AS nombre_departamento, a.nombre AS nombre_asignatura
FROM asignatura a
INNER JOIN profesor prof ON a.id_profesor = prof.id
INNER JOIN departamento d ON prof.id_departamento = d.id
LEFT JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura
WHERE am.id_asignatura IS NULL

--1.5.7 Consultas resumen
--1. Número total de alumnas que hay
SELECT COUNT(*) AS total_alumnas
FROM alumno
WHERE sexo = 'M'

--2. Cuántos alumnos nacieron en 1999
SELECT COUNT(*) AS alumnos_1999
FROM alumno
WHERE DATEPART(year, fecha_nacimiento) = 1999
--WHERE YEAR(fecha_nacimiento) = 1999

--3. Profesores por departamento (solo con profesores, ordenado de mayor a menor)
SELECT d.nombre AS nombre_departamento, COUNT(prof.id) AS total_profesores
FROM departamento d
INNER JOIN profesor prof ON d.id = prof.id_departamento
GROUP BY d.nombre
ORDER BY total_profesores DESC

--4. Todos los departamentos y su número de profesores (incluyendo los que tienen 0)
SELECT d.nombre AS nombre_departamento, COUNT(prof.id) AS total_profesores
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
GROUP BY d.nombre

--5. Todos los grados y su número de asignaturas (incluyendo los que tienen 0, ordenado de mayor a menor)
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS total_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY total_asignaturas DESC

--6. Grados que tengan más de 40 asignaturas asociadas
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS total_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40

--7. Grados, tipo de asignatura y suma total de créditos (ordenado de mayor a menor crédito)
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo
ORDER BY total_creditos DESC

--8. Número de alumnos matriculados por cada curso escolar
SELECT c.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS alumnos_matriculados
FROM curso_escolar c
JOIN alumno_se_matricula_asignatura am ON c.id = am.id_curso_escolar
GROUP BY c.id, c.anyo_inicio

--9. Número de asignaturas que imparte cada profesor (incluyendo los que no imparten ninguna, ordenados de mayor a menor)
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura a ON p.id = a.id_profesor
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC