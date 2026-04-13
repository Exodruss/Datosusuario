<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.Conexion" %>
<%
    HttpSession sesion_cli = request.getSession(false);

    if (sesion_cli == null || sesion_cli.getAttribute("nUsuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String nUsuario = (String) sesion_cli.getAttribute("nUsuario");

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String nombre = "";
    String apellido = "";
    int idPerfil = 0;

    try {
        Conexion cn = new Conexion();
        conn = cn.crearConexion();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM usuarios WHERE usuario = '" + nUsuario + "'");
        if (rs.next()) {
            nombre = rs.getString("nombre");
            apellido = rs.getString("apellido");
            idPerfil = rs.getInt("id_perfil");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    if (idPerfil != 1) {
        response.sendRedirect("front.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Panel de Control</title>
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

        .btn-front {
            background: #27ae60;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all .2s;
            display: inline-block;
            cursor: pointer;
        }

        .btn-front:hover {
            background: #229954;
        }

        .btn-panel {
            background: #4361ee;
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all .2s;
            display: inline-block;
            cursor: pointer;
        }

        .btn-panel:hover {
            background: #3451d1;
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
    <div class="logo">🏛️ Universidad San Buenaventura - Panel de Control</div>
    <div class="user-info">
        <span>👤 <%= nombre %> <%= apellido %> (Administrador)</span>
        <button onclick="window.location.href='front.jsp'" class="btn-front">👁️ Ver como Usuario</button>
        <button onclick="window.location.href='cpanel.jsp'" class="btn-panel">🏠 Panel Principal</button>
        <a href="CerrarSesion" class="cerrar">🚪 Cerrar sesión</a>
    </div>
</div>

<div class="main-layout">
    <nav class="sidebar">
        <div class="menu-title">📋 MENÚ ADMINISTRADOR</div>
        <ul>
            <li><a href="ControladorUsuario?accion=listar" target="marco">👥 Gestión de Usuarios</a></li>
            <li><a href="ControladorPerfil?accion=listar" target="marco">👤 Gestión de Perfiles</a></li>
            <li><a href="ControladorTarea?accion=listar" target="marco">📋 Gestión de Tareas</a></li>
            <li><a href="ControladorAsignarTarea?accion=listar" target="marco">⚙️ Asignar Tareas</a></li>
        </ul>
    </nav>

    <div class="content">
        <iframe id="marco" name="marco" src="bienvenida.jsp"></iframe>
    </div>
</div>

</body>
</html>