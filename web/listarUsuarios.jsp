<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    List<Usuario> lista = (List<Usuario>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Listado de Usuarios</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }

        h2 { color: #1a1a2e; margin-bottom: 20px; }

        .btn-nuevo {
            display: inline-block;
            background: #4361ee;
            color: #fff;
            padding: 9px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .btn-nuevo:hover { background: #3451d1; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: #1a1a2e;
            color: #fff;
            padding: 12px 16px;
            text-align: left;
        }

        td {
            padding: 11px 16px;
            border-bottom: 1px solid #f0f2f5;
            color: #444;
        }

        tr:hover td { background: #f7f8ff; }

        .btn-edit, .btn-del, .btn-activar, .btn-desactivar {
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            margin-right: 4px;
            display: inline-block;
            border: none;
            cursor: pointer;
        }

        .btn-edit { background: #f0ad00; color: #fff; }
        .btn-edit:hover { background: #e09900; }
        .btn-del { background: #e74c3c; color: #fff; }
        .btn-del:hover { background: #c0392b; }
        .btn-activar { background: #27ae60; color: #fff; }
        .btn-activar:hover { background: #229954; }
        .btn-desactivar { background: #e67e22; color: #fff; }
        .btn-desactivar:hover { background: #d35400; }

        .btn-volver {
            background: #6c757d;
            color: #fff;
            padding: 9px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            margin-left: 10px;
            display: inline-block;
        }
        
        .activo {
            color: #27ae60;
            font-weight: bold;
        }
        
        .inactivo {
            color: #e74c3c;
            font-weight: bold;
        }
    </style>
</head>
<body>

<h2>👥 Gestión de Usuarios</h2>
<div>
    <a href="regUsuario.jsp" target="marco" class="btn-nuevo">+ Nuevo Usuario</a>
    <a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Documento</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Email</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Usuario u : lista) {
                String estadoClass = (u.getActivo() == 1) ? "activo" : "inactivo";
                String estadoTexto = (u.getActivo() == 1) ? "Activo" : "Inactivo";
    %>
        <tr>
            <td><%= u.getIdusu() %></td>
            <td><%= u.getNumDocu() %></td>
            <td><%= u.getNombre() %></td>
            <td><%= u.getApellido() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getUsuario() %></td>
            <td><%= (u.getIdPerfil() == 1) ? "Administrador" : "Usuario" %></td>
            <td class="<%= estadoClass %>"><%= estadoTexto %></td>
            <td>
                <a href="editarUsuario.jsp?id=<%= u.getIdusu() %>" target="marco" class="btn-edit">Editar</a>
                <% if (u.getActivo() == 1) { %>
                    <a href="ControladorUsuario?accion=desactivar&id=<%= u.getIdusu() %>" class="btn-desactivar" onclick="return confirm('¿Desactivar este usuario? No podrá iniciar sesión.')">Desactivar</a>
                <% } else { %>
                    <a href="ControladorUsuario?accion=activar&id=<%= u.getIdusu() %>" class="btn-activar" onclick="return confirm('¿Activar este usuario?')">Activar</a>
                <% } %>
                <a href="ControladorUsuario?accion=eliminar&id=<%= u.getIdusu() %>" class="btn-del" onclick="return confirm('¿Eliminar este usuario? Esta acción no se puede deshacer.')">Eliminar</a>
             </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="9" style="text-align:center">No hay usuarios registrados</td></tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>