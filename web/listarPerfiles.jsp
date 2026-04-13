<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    List<Perfil> lista = (List<Perfil>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Perfiles</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }

        h2 { color: #1a1a2e; margin-bottom: 20px; }

        .form-container {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: flex-end;
        }

        .form-group {
            flex: 1;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .btn-agregar {
            background: #4361ee;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: #1a1a2e;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 10px 12px;
            border-bottom: 1px solid #eee;
        }

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
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-bottom: 20px;
            text-decoration: none;
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

<h2>👥 Gestión de Perfiles</h2>
<a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<div class="form-container">
    <div class="form-group">
        <label>Nombre del perfil</label>
        <input type="text" id="nombrePerfil" placeholder="Ej: Operador">
    </div>
    <button onclick="agregarPerfil()" class="btn-agregar">+ Agregar Perfil</button>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Perfil</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Perfil p : lista) {
                String estadoClass = (p.getActivo() == 1) ? "activo" : "inactivo";
                String estadoTexto = (p.getActivo() == 1) ? "Activo" : "Inactivo";
    %>
        <tr>
            <td><%= p.getIdPerfil() %></td>
            <td><%= p.getPerfil() %></td>
            <td class="<%= estadoClass %>"><%= estadoTexto %></td>
            <td>
                <a href="editarPerfil.jsp?id=<%= p.getIdPerfil() %>" target="marco" class="btn-edit">Editar</a>
                <% if (p.getActivo() == 1) { %>
                    <a href="ControladorPerfil?accion=desactivar&id=<%= p.getIdPerfil() %>" class="btn-desactivar" onclick="return confirm('¿Desactivar este perfil? Los usuarios con este perfil no podrán acceder.')">Desactivar</a>
                <% } else { %>
                    <a href="ControladorPerfil?accion=activar&id=<%= p.getIdPerfil() %>" class="btn-activar" onclick="return confirm('¿Activar este perfil?')">Activar</a>
                <% } %>
                <a href="ControladorPerfil?accion=eliminar&id=<%= p.getIdPerfil() %>" class="btn-del" onclick="return confirm('¿Eliminar este perfil? Esta acción no se puede deshacer.')">Eliminar</a>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="4" style="text-align:center">No hay perfiles registrados</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<script>
    function agregarPerfil() {
        var nombre = document.getElementById('nombrePerfil').value.trim();
        if (nombre === "") {
            alert("Ingrese un nombre para el perfil");
            return;
        }
        
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'ControladorPerfil';
        form.target = 'marco';
        
        var inputAccion = document.createElement('input');
        inputAccion.type = 'hidden';
        inputAccion.name = 'accion';
        inputAccion.value = 'registrar';
        
        var inputPerfil = document.createElement('input');
        inputPerfil.type = 'hidden';
        inputPerfil.name = 'perfil';
        inputPerfil.value = nombre;
        
        form.appendChild(inputAccion);
        form.appendChild(inputPerfil);
        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>