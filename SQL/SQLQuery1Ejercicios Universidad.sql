--1.5.4 Consultas sobre una tabla--

--1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

Select apellido1, apellido2, nombre 
From dbo.alumno
order by apellido1 ASC, apellido2 ASC, nombre ASC

--or 

Select apellido1, apellido2, nombre 
From dbo.alumno
order by apellido1, apellido2, nombre ASC

--or 

Select apellido1, apellido2, nombre 
From dbo.alumno
order by 1, 2, 3 ASC


--2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.--

Select nombre, apellido1, apellido2, telefono
From dbo.alumno
where telefono is null

--3. Devuelve el listado de los alumnos que nacieron en 1999--

Select nombre, apellido1, apellido2, fecha_nacimiento
From dbo.alumno
where left(fecha_nacimiento,4) in (1999)

-- or

Select nombre, apellido1, apellido2, fecha_nacimiento
From dbo.alumno
where year (fecha_nacimiento) in (1999)

-- or 

Select nombre, apellido1, apellido2, fecha_nacimiento
From dbo.alumno
where fecha_nacimiento between '1999-01-01' and '1999-12-31'


--4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.--

Select nombre, apellido1, apellido2, telefono, nif
From dbo.profesor
where telefono is null and nif like '%K' 

--5.Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

Select nombre, cuatrimestre, curso, id_grado
From dbo.asignatura
where cuatrimestre =1 and curso =3 and id_grado=7 

--1.5.5 Consultas multitabla (Composición interna)--

--1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).--

Select distinct a. id, a.nombre, a.apellido1, a. apellido2, a.sexo, am.id_alumno, g.id, g.nombre
From dbo.alumno a
left join dbo.alumno_se_matricula_asignatura am on a.id = am.id_alumno
left join dbo.asignatura asi on am.id_asignatura = asi.id
left join dbo.grado g on asi.id_grado = g.id
where a.sexo = 'M' and g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'

--2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).--

Select g.id, g.nombre as nombre_grado, asi.id_grado, asi.id, asi.nombre as nombre_asignatura
From dbo.asignatura asi
left join dbo.grado g on asi.id_grado = g.id
where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'

--3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.--

Select p.apellido1, p.apellido2, p.nombre, d.nombre as nombre_departamento
From dbo.profesor p
left  join dbo.departamento d on p.id_departamento = d.id
order by p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC

--4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

Select asi.nombre as nombre_asignatura, c.anyo_inicio, c.anyo_fin, a.nombre, a.apellido1, a.apellido2, a.nif
from dbo.alumno a
inner join dbo.alumno_se_matricula_asignatura am on a.id = am.id_alumno
inner join dbo.asignatura asi on am.id_asignatura = asi.id
inner join dbo.curso_escolar c on asi.curso = c.id
where a.nif  = '26902806M'

--5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

Select distinct d.nombre as nombre_depto, d.id, p.id_departamento, p.id, asi.id_profesor, asi.id_grado
from dbo.departamento d
inner join dbo.profesor p on d.id = p.id_departamento
inner join dbo.asignatura asi on p.id = asi.id_profesor
inner join dbo.grado g on asi.id_grado = g.id
where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)'

--6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.--

Select a.nombre, a.apellido1, a.apellido2, c.anyo_inicio, c.anyo_fin
from dbo.alumno a
inner join dbo.alumno_se_matricula_asignatura am on a.id = am.id_alumno
inner join dbo.curso_escolar c on am.id_curso_escolar = c.id
Where c.anyo_inicio = 2018 and c.anyo_fin =2019

--1.5.6 Consultas multitabla (Composición externa)--

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.--

--1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.--

select d.nombre as nombre_departamento, p.apellido1, p.apellido2, p.nombre
from dbo.profesor p
left join dbo.departamento d on p.id_departamento = d.id
order by d.nombre ASC, p.apellido1, p.apellido2, p.nombre

--2. Devuelve un listado con los profesores que no están asociados a un departamento.--

select apellido1, apellido2, nombre
from dbo.profesor
where id_departamento is null 

--3. Devuelve un listado con los departamentos que no tienen profesores asociados.--

select d.nombre as nombre_departamento, p.apellido1, p.apellido2, p.nombre
from dbo.profesor p
right join dbo.departamento d on p.id_departamento = d.id
where p.apellido1 is null 

--4. Devuelve un listado con los profesores que no imparten ninguna asignatura.--

Select p.nombre, p.apellido1, p.apellido2, a.nombre as asignatura
From dbo.profesor p
left join dbo.asignatura a on p.id = a.id_profesor 
where a.nombre is null

--5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.--

Select nombre as asignatura, id_profesor
From dbo.asignatura
where id_profesor is null

--6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.--

Select d.nombre as nombre_departamento, a.nombre as nombre_asignatura
from dbo.departamento d
left join dbo.profesor p on d.id = p.id_departamento
left join dbo.asignatura a on p.id = a.id_profesor
where a.id_curso is null

--Raul
Select d.nombre as departamento, a.nombre as asignatura
from dbo.departamento as d
INNER JOIN dbo.profesor as p on d.id = p.id_departamento
INNER JOIN dbo.asignatura as a on p.id = a.id_profesor
LEFT JOIN dbo.alumno_se_matricula_asignatura AS m ON a.id = m.id_asignatura
where m.id_asignatura IS NULL


select * from dbo.departamento
select * from dbo.profesor
select * from dbo.asignatura



select * from dbo.profesor



select * from dbo.alumno 
select * from dbo.alumno_se_matricula_asignatura 





select * from dbo.grado

select * from dbo.curso_escolar
