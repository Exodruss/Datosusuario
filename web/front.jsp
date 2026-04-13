<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*, modelo.*" %>
<%
    HttpSession sesion_cli = request.getSession(false);

    if (sesion_cli == null || sesion_cli.getAttribute("nUsuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Usuario usuario = (Usuario) sesion_cli.getAttribute("datosUsuario");
    int idPerfil = usuario.getIdPerfil();
    String nombre = usuario.getNombre();
    String apellido = usuario.getApellido();
    int activo = usuario.getActivo();
    
    // Si el usuario está desactivado, cerrar sesión
    if (activo == 0) {
        session.invalidate();
        response.sendRedirect("index.jsp?error=Usuario desactivado");
        return;
    }
    
    if (idPerfil == 1) {
        response.sendRedirect("cpanel.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Usuario</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            display: flex;
            flex-direction: column;
            height: 100vh;
            overflow: hidden;
        }

        .header {
            background: #1a1a2e;
            color: #fff;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        .header .logo {
            font-size: 18px;
            font-weight: 700;
        }

        .header .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 14px;
        }

        .header .user-info span {
            background: #4361ee;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .header a.cerrar {
            color: #ff6b6b;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            border: 1px solid #ff6b6b;
            padding: 5px 12px;
            border-radius: 6px;
            transition: all .2s;
        }

        .header a.cerrar:hover {
            background: #ff6b6b;
            color: #fff;
        }

        .main-layout {
            display: flex;
            flex: 1;
            overflow: hidden;
        }

        .sidebar {
            width: 260px;
            background: #16213e;
            color: #ccc;
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            overflow-y: auto;
        }

        .sidebar .menu-title {
            padding: 18px 20px 10px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            color: #888;
            border-bottom: 1px solid #2a2a4a;
        }

        .sidebar ul {
            list-style: none;
            padding: 8px 0;
            flex: 1;
        }

        .sidebar ul li a {
            display: block;
            padding: 12px 20px;
            color: #ccc;
            text-decoration: none;
            font-size: 14px;
            transition: all .2s;
            border-left: 3px solid transparent;
        }

        .sidebar ul li a:hover {
            background: #0f3460;
            color: #fff;
            border-left-color: #4361ee;
            padding-left: 25px;
        }

        .content {
            flex: 1;
            overflow: auto;
            background: #f0f2f5;
            padding: 20px;
        }

        iframe#marco {
            width: 100%;
            height: 100%;
            border: none;
            background: #f0f2f5;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo">🏛️ Universidad San Buenaventura - Panel Usuario</div>
    <div class="user-info">
        <span>👤 <%= nombre %> <%= apellido %></span>
        <a href="CerrarSesion" class="cerrar">🚪 Cerrar sesión</a>
    </div>
</div>

<div class="main-layout">
    <nav class="sidebar">
        <div class="menu-title">📋 MI MENÚ</div>
        <ul>
            <li><a href="misTareas.jsp" target="marco">📋 Mis Tareas</a></li>
        </ul>
    </nav>

    <div class="content">
        <iframe id="marco" name="marco" src="misTareas.jsp"></iframe>
    </div>
</div>

</body>
</html>