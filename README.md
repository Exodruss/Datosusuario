# Datosusuario - Sistema de Gestión de Usuarios y Tareas

Aplicación web Java (JSP + MVC) con base de datos MySQL.

## Requisitos
- Java JDK 8+
- NetBeans IDE
- MySQL 8+
- Servidor: Apache Tomcat (incluido en NetBeans)

## Paso 1 — Configurar la base de datos
1. Abrir **MySQL Workbench**
2. Ir a **File → Open SQL Script**
3. Seleccionar el archivo `database.sql` del proyecto
4. Ejecutar con el rayo ⚡
5. Verificar que se creó la base de datos `datosusuario`

## Paso 2 — Abrir el proyecto en NetBeans
1. Clonar o descargar el repositorio como ZIP
2. En NetBeans: **File → Open Project**
3. Seleccionar la carpeta descargada

## Paso 3 — Verificar la conexión
Abrir `src/modelo/Conexion.java` y confirmar:
```java
private final String URL     = "jdbc:mysql://localhost:3306/datosusuario";
private final String USUARIO = "root";   // cambiar si es diferente
private final String CLAVE   = "root";   // cambiar si es diferente
```

## Paso 4 — Ejecutar
1. Clic derecho en el proyecto → **Clean and Build**
2. Luego clic en **Run Project** (botón Play ▶)
3. Se abrirá en el navegador automáticamente

## Usuarios de prueba
| Usuario | Clave    | Perfil        |
|---------|----------|---------------|
| admin   | admin123 | Administrador |
| juan    | user123  | Usuario       |
