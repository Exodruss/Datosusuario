CREATE DATABASE IF NOT EXISTS datosusuario 
CHARACTER SET utf8 
COLLATE utf8_general_ci;

USE datosusuario;

CREATE TABLE perfiles (
    id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    perfil VARCHAR(30) NOT NULL,
    activo TINYINT(1) DEFAULT 1
);

CREATE TABLE usuarios (
    idusu INT PRIMARY KEY AUTO_INCREMENT,
    num_docu VARCHAR(20) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR(60) NOT NULL,
    usuario VARCHAR(20) NOT NULL UNIQUE,
    clave VARCHAR(8) NOT NULL,
    id_perfil INT,
    activo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);

CREATE TABLE tareas (
    id_tarea INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tarea VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_entrega DATE NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'pendiente'
);

CREATE TABLE tareas_perfil (
    id_asignacion INT PRIMARY KEY AUTO_INCREMENT,
    id_perfil INT NOT NULL,
    id_tarea INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil) ON DELETE CASCADE,
    FOREIGN KEY (id_tarea) REFERENCES tareas(id_tarea) ON DELETE CASCADE
);

INSERT INTO perfiles (perfil, activo) VALUES 
('Administrador', 1),
('Usuario', 1);

INSERT INTO usuarios (num_docu, nombre, apellido, email, usuario, clave, id_perfil, activo) VALUES 
('123456789', 'Admin', 'Sistema', 'admin@usb.edu.co', 'admin', 'admin123', 1, 1),
('987654321', 'Juan', 'Perez', 'juan@usb.edu.co', 'juan', 'user123', 2, 1);

INSERT INTO tareas (nombre_tarea, descripcion, fecha_entrega) VALUES 
('Revisión de usuarios', 'Revisar y actualizar la lista de usuarios del sistema.', DATE_ADD(CURDATE(), INTERVAL 7 DAY)),
('Reporte mensual', 'Generar reporte de actividades del mes.', DATE_ADD(CURDATE(), INTERVAL 15 DAY)),
('Actualización de perfiles', 'Revisar y actualizar los perfiles de usuario.', DATE_ADD(CURDATE(), INTERVAL 20 DAY)),
('Capacitación del sistema', 'Completar el curso de capacitación.', DATE_ADD(CURDATE(), INTERVAL 5 DAY)),
('Auditoría de seguridad', 'Realizar auditoría de accesos y permisos.', DATE_ADD(CURDATE(), INTERVAL 30 DAY));

INSERT INTO tareas_perfil (id_perfil, id_tarea) VALUES 
(1, 1), (1, 2), (1, 3), (1, 5);

INSERT INTO tareas_perfil (id_perfil, id_tarea) VALUES 
(2, 1), (2, 4);

SELECT '=== PERFILES ===' AS '';
SELECT id_perfil, perfil, 
       CASE WHEN activo = 1 THEN 'Activo' ELSE 'Inactivo' END AS estado 
FROM perfiles;

SELECT '=== USUARIOS ===' AS '';
SELECT idusu, nombre, usuario, 
       CASE WHEN activo = 1 THEN 'Activo' ELSE 'Inactivo' END AS estado 
FROM usuarios;

SELECT '=== TAREAS ===' AS '';
SELECT id_tarea, nombre_tarea, fecha_entrega FROM tareas;

SELECT '=== TAREAS ASIGNADAS POR PERFIL ===' AS '';
SELECT p.perfil, t.nombre_tarea, t.fecha_entrega 
FROM tareas_perfil tp
JOIN perfiles p ON tp.id_perfil = p.id_perfil
JOIN tareas t ON tp.id_tarea = t.id_tarea
ORDER BY p.perfil, t.fecha_entrega;

-- ============================================
-- VERIFICAR ESTRUCTURA DE LA BASE DE DATOS
-- ============================================

USE datosusuario;

-- 1. Ver todas las tablas
SHOW TABLES;

-- 2. Ver estructura de la tabla perfiles
DESCRIBE perfiles;

-- 3. Ver estructura de la tabla usuarios
DESCRIBE usuarios;

-- 4. Ver estructura de la tabla tareas
DESCRIBE tareas;

-- 5. Ver estructura de la tabla tareas_perfil
DESCRIBE tareas_perfil;

-- 6. Ver datos de perfiles
SELECT * FROM perfiles;

-- 7. Ver datos de usuarios
SELECT idusu, nombre, usuario, id_perfil, activo FROM usuarios;

-- 8. Ver datos de tareas
SELECT * FROM tareas;

SELECT * FROM usuarios;
