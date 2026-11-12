CREATE TABLE departamento (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
)

CREATE TABLE alumno (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('H', 'M'))
)

CREATE TABLE profesor (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nif VARCHAR(9) UNIQUE,
    nombre VARCHAR(25) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    ciudad VARCHAR(25) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(9),
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('H', 'M')),
    id_departamento INT NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
)

CREATE TABLE grado (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
)

CREATE TABLE asignatura (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos FLOAT NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('básica', 'obligatoria', 'optativa')),
    curso TINYINT NOT NULL,
    cuatrimestre TINYINT NOT NULL,
    id_profesor INT,
    id_grado INT NOT NULL,
    FOREIGN KEY(id_profesor) REFERENCES profesor(id),
    FOREIGN KEY(id_grado) REFERENCES grado(id)
)

CREATE TABLE curso_escolar (
    id INT IDENTITY(1,1) PRIMARY KEY,
    anyo_inicio INT NOT NULL CHECK (anyo_inicio BETWEEN 1901 AND 2155),
    anyo_fin INT NOT NULL CHECK (anyo_fin BETWEEN 1901 AND 2155)
)

CREATE TABLE alumno_se_matricula_asignatura (
    id_alumno INT NOT NULL,
    id_asignatura INT NOT NULL,
    id_curso_escolar INT NOT NULL,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    FOREIGN KEY (id_alumno) REFERENCES alumno(id),
    FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
    FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
)

/* Departamento */
INSERT INTO departamento VALUES ('Informática') 
INSERT INTO departamento VALUES ('Matemáticas') 
INSERT INTO departamento VALUES ('Economía y Empresa') 
INSERT INTO departamento VALUES ('Educación') 
INSERT INTO departamento VALUES ('Agronomía') 
INSERT INTO departamento VALUES ('Química y Física') 
INSERT INTO departamento VALUES ('Filología') 
INSERT INTO departamento VALUES ('Derecho') 
INSERT INTO departamento VALUES ('Biología y Geología') 

 select * from alumno
/* Alumno */
INSERT INTO alumno VALUES ('89542419S','Juan','Saez','Vega','Almería','C/ Mercurio','618253876','1992-08-08','H') 
INSERT INTO alumno VALUES ('26902806M','Salvador','Sánchez','Pérez','Almería','C/ Real del barrio alto','950254837','1991-03-28','H') 
INSERT INTO alumno VALUES ('17105885A','Pedro','Heller','Pagac','Almería','C/ Estrella fugaz',NULL,'2000-10-05','H') 
INSERT INTO alumno VALUES ('04233869Y','José','Koss','Bayer','Almería','C/ Júpiter','628349590','1998-01-28','H') 
INSERT INTO alumno VALUES ('97258166K','Ismael','Strosin','Turcotte','Almería','C/ Neptuno',NULL,'1999-05-24','H') 
INSERT INTO alumno VALUES ('82842571K','Ramón','Herzog','Tremblay','Almería','C/ Urano','626351429','1996-11-21','H') 
INSERT INTO alumno VALUES ('46900725E','Daniel','Herman','Pacocha','Almería','C/ Andarax','679837625','1997-04-26','H') 
INSERT INTO alumno VALUES ('11578526G','Inma','Lakin','Yundt','Almería','C/ Picos de Europa','678652431','1998-09-01','M') 
INSERT INTO alumno VALUES ('79089577Y','Juan','Gutiérrez','López','Almería','C/ Los pinos','678652431','1998-01-01','H') 
INSERT INTO alumno VALUES ('41491230N','Antonio','Domínguez','Guerrero','Almería','C/ Cabo de Gata','626652498','1999-02-11','H') 
INSERT INTO alumno VALUES ('64753215G','Irene','Hernández','Martínez','Almería','C/ Zapillo','628452384','1996-03-12','M') 
INSERT INTO alumno VALUES ('85135690V','Sonia','Gea','Ruiz','Almería','C/ Mercurio','678812017','1995-04-13','M') 

/* Profesor */
INSERT INTO profesor VALUES ('11105554G','Zoe','Ramirez','Gea','Almería','C/ Marte','618223876','1979-08-19','M',1) 
INSERT INTO profesor VALUES ('38223286T','David','Schmidt','Fisher','Almería','C/ Venus','678516294','1978-01-19','H',2) 
INSERT INTO profesor VALUES ('79503962T','Cristina','Lemke','Rutherford','Almería','C/ Saturno','669162534','1977-08-21','M',3) 
INSERT INTO profesor VALUES ('61142000L','Esther','Spencer','Lakin','Almería','C/ Plutón',NULL,'1977-05-19','M',4) 
INSERT INTO profesor VALUES ('85366986W','Carmen','Streich','Hirthe','Almería','C/ Almanzora',NULL,'1971-04-29','M',4) 
INSERT INTO profesor VALUES ('73571384L','Alfredo','Stiedemann','Morissette','Almería','C/ Guadalquivir','950896725','1980-02-01','H',6) 
INSERT INTO profesor VALUES ('82937751G','Manolo','Hamill','Kozey','Almería','C/ Duero','950263514','1977-01-02','H',1) 
INSERT INTO profesor VALUES ('80502866Z','Alejandro','Kohler','Schoen','Almería','C/ Tajo','668726354','1980-03-14','H',2) 
INSERT INTO profesor VALUES ('10485008K','Antonio','Fahey','Considine','Almería','C/ Sierra de los Filabres',NULL,'1982-03-18','H',3) 
INSERT INTO profesor VALUES ('85869555K','Guillermo','Ruecker','Upton','Almería','C/ Sierra de Gádor',NULL,'1973-05-05','H',4) 
INSERT INTO profesor VALUES ('04326833G','Micaela','Monahan','Murray','Almería','C/ Veleta','662765413','1976-02-25','H',5) 
INSERT INTO profesor VALUES ('79221403L','Francesca','Schowalter','Muller','Almería','C/ Quinto pino',NULL,'1980-10-31','H',6) 
INSERT INTO profesor VALUES ('13175769N','Pepe','Sánchez','Ruiz','Almería','C/ Quinto pino',NULL,'1980-10-16','H',1) 
INSERT INTO profesor VALUES ('98816696W','Juan','Guerrero','Martínez','Almería','C/ Quinto pino',NULL,'1980-11-21','H',1) 
INSERT INTO profesor VALUES ('77194445M','María','Domínguez','Hernández','Almería','C/ Quinto pino',NULL,'1980-12-13','M',2) 

/* Grado */
INSERT INTO grado VALUES ('Grado en Ingeniería Agrícola (Plan 2015)') 
INSERT INTO grado VALUES ('Grado en Ingeniería Eléctrica (Plan 2014)') 
INSERT INTO grado VALUES ('Grado en Ingeniería Electrónica Industrial (Plan 2010)') 
INSERT INTO grado VALUES ('Grado en Ingeniería Informática (Plan 2015)') 
INSERT INTO grado VALUES ('Grado en Ingeniería Mecánica (Plan 2010)') 
INSERT INTO grado VALUES ('Grado en Ingeniería Química Industrial (Plan 2010)') 
INSERT INTO grado VALUES ('Grado en Biotecnología (Plan 2015)') 
INSERT INTO grado VALUES ('Grado en Ciencias Ambientales (Plan 2009)') 
INSERT INTO grado VALUES ('Grado en Matemáticas (Plan 2010)') 
INSERT INTO grado VALUES ('Grado en Química (Plan 2009)') 

/* Asignatura */
INSERT INTO asignatura VALUES ('Introducción a la programación',6,'básica',1,1,3,4) 
INSERT INTO asignatura VALUES ('Estadística',6,'básica',1,2,14,4) 
INSERT INTO asignatura VALUES ('Estructura y tecnología de computadores',6,'básica',1,2,14,4) 
INSERT INTO asignatura VALUES ('Fundamentos de electrónica',6,'básica',1,2,3,4) 
INSERT INTO asignatura VALUES ('Metodología de la programación',6,'básica',1,2,14,4) 
INSERT INTO asignatura VALUES ('Arquitectura de Computadores',6,'básica',2,1,3,4) 
INSERT INTO asignatura VALUES ('Estructura de Datos y Algoritmos I',6,'obligatoria',2,1,3,4) 
INSERT INTO asignatura VALUES ('Ingeniería del Software',6,'obligatoria',2,1,14,4) 
INSERT INTO asignatura VALUES ('Sistemas Inteligentes',6,'obligatoria',2,1,3,4) 
INSERT INTO asignatura VALUES ('Sistemas Operativos',6,'obligatoria',2,1,14,4) 
INSERT INTO asignatura VALUES ('Bases de Datos',6,'básica',2,2,14,4) 
INSERT INTO asignatura VALUES ('Estructura de Datos y Algoritmos II',6,'obligatoria',2,2,14,4) 
INSERT INTO asignatura VALUES ('Fundamentos de Redes de Computadores',6,'obligatoria',2,2,3,4) 
INSERT INTO asignatura VALUES ('Planificación y Gestión de Proyectos Informáticos',6,'obligatoria',2,2,3,4) 
INSERT INTO asignatura VALUES ('Programación de Servicios Software',6,'obligatoria',2,2,14,4) 
INSERT INTO asignatura VALUES ('Desarrollo de interfaces de usuario',6,'obligatoria',3,1,14,4) 
INSERT INTO asignatura VALUES ('Ingeniería de Requisitos',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Integración de las Tecnologías de la Información en las Organizaciones',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Modelado y Diseño del Software 1',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Multiprocesadores',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Seguridad y cumplimiento normativo',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Sistema de Información para las Organizaciones',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Tecnologías web',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Teoría de códigos y criptografía',6,'optativa',3,1,NULL,4) 
INSERT INTO asignatura VALUES ('Administración de bases de datos',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Herramientas y Métodos de Ingeniería del Software',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Informática industrial y robótica',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Ingeniería de Sistemas de Información',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Modelado y Diseño del Software 2',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Negocio Electrónico',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Periféricos e interfaces',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Sistemas de tiempo real',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Tecnologías de acceso a red',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Tratamiento digital de imágenes',6,'optativa',3,2,NULL,4) 
INSERT INTO asignatura VALUES ('Administración de redes y sistemas operativos',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Almacenes de Datos',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Fiabilidad y Gestión de Riesgos',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Líneas de Productos Software',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Procesos de Ingeniería del Software 1',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Tecnologías multimedia',6,'optativa',4,1,NULL,4) 
INSERT INTO asignatura VALUES ('Análisis y planificación de las TI',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Desarrollo Rápido de Aplicaciones',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Gestión de la Calidad y de la Innovación Tecnológica',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Inteligencia del Negocio',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Procesos de Ingeniería del Software 2',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Seguridad Informática',6,'optativa',4,2,NULL,4) 
INSERT INTO asignatura VALUES ('Biologia celular',6,'básica',1,1,NULL,7) 
INSERT INTO asignatura VALUES ('Física',6,'básica',1,1,NULL,7) 
INSERT INTO asignatura VALUES ('Matemáticas I',6,'básica',1,1,NULL,7) 
INSERT INTO asignatura VALUES ('Química general',6,'básica',1,1,NULL,7) 
INSERT INTO asignatura VALUES ('Química orgánica',6,'básica',1,1,NULL,7) 
INSERT INTO asignatura VALUES ('Biología vegetal y animal',6,'básica',1,2,NULL,7) 
INSERT INTO asignatura VALUES ('Bioquímica',6,'básica',1,2,NULL,7) 
INSERT INTO asignatura VALUES ('Genética',6,'básica',1,2,NULL,7) 
INSERT INTO asignatura VALUES ('Matemáticas II',6,'básica',1,2,NULL,7) 
INSERT INTO asignatura VALUES ('Microbiología',6,'básica',1,2,NULL,7) 
INSERT INTO asignatura VALUES ('Botánica agrícola',6,'obligatoria',2,1,NULL,7) 
INSERT INTO asignatura VALUES ('Fisiología vegetal',6,'obligatoria',2,1,NULL,7) 
INSERT INTO asignatura VALUES ('Genética molecular',6,'obligatoria',2,1,NULL,7) 
INSERT INTO asignatura VALUES ('Ingeniería bioquímica',6,'obligatoria',2,1,NULL,7) 
INSERT INTO asignatura VALUES ('Termodinámica y cinética química aplicada',6,'obligatoria',2,1,NULL,7) 
INSERT INTO asignatura VALUES ('Biorreactores',6,'obligatoria',2,2,NULL,7) 
INSERT INTO asignatura VALUES ('Biotecnología microbiana',6,'obligatoria',2,2,NULL,7) 
INSERT INTO asignatura VALUES ('Ingeniería genética',6,'obligatoria',2,2,NULL,7) 
INSERT INTO asignatura VALUES ('Inmunología',6,'obligatoria',2,2,NULL,7) 
INSERT INTO asignatura VALUES ('Virología',6,'obligatoria',2,2,NULL,7) 
INSERT INTO asignatura VALUES ('Bases moleculares del desarrollo vegetal',4.5,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Fisiología animal',4.5,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Metabolismo y biosíntesis de biomoléculas',6,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Operaciones de separación',6,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Patología molecular de plantas',4.5,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Técnicas instrumentales básicas',4.5,'obligatoria',3,1,NULL,7) 
INSERT INTO asignatura VALUES ('Bioinformática',4.5,'obligatoria',3,2,NULL,7) 
INSERT INTO asignatura VALUES ('Biotecnología de los productos hortofrutículas',4.5,'obligatoria',3,2,NULL,7) 
INSERT INTO asignatura VALUES ('Biotecnología vegetal',6,'obligatoria',3,2,NULL,7) 
INSERT INTO asignatura VALUES ('Genómica y proteómica',4.5,'obligatoria',3,2,NULL,7) 
INSERT INTO asignatura VALUES ('Procesos biotecnológicos',6,'obligatoria',3,2,NULL,7) 
INSERT INTO asignatura VALUES ('Técnicas instrumentales avanzadas',4.5,'obligatoria',3,2,NULL,7) 

/* Curso escolar */
INSERT INTO curso_escolar VALUES (2014,2015) 
INSERT INTO curso_escolar VALUES (2015,2016) 
INSERT INTO curso_escolar VALUES (2016,2017) 
INSERT INTO curso_escolar VALUES (2017,2018) 

/* Alumno se matricula en asignatura */
INSERT INTO alumno_se_matricula_asignatura VALUES (1,4,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,4,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (1,6,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,6,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (1,7,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,7,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (1,8,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,8,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (1,10,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,10,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (2,4,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,4,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (2,6,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,6,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (2,7,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,7,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (2,8,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,8,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (2,10,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,10,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (3,14,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,14,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (3,16,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,16,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (3,17,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,17,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (3,18,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,18,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (3,19,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,19,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (4,14,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (7,14,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,16,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (7,16,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,17,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (7,17,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,18,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (7,18,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (4,19,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (7,19,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (5,24,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (8,24,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,26,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (8,26,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,27,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (8,27,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,28,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (8,28,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (5,29,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (8,29,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (6,24,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (9,24,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,26,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (9,26,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,27,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (9,27,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,28,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (9,28,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (6,29,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (9,29,2) 

INSERT INTO alumno_se_matricula_asignatura VALUES (10,4,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (11,4,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (10,6,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (11,6,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (10,7,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (11,7,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (10,8,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (11,8,2) 
INSERT INTO alumno_se_matricula_asignatura VALUES (10,10,1) 
INSERT INTO alumno_se_matricula_asignatura VALUES (11,10,2) 
