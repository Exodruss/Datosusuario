<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    List<Actividad> lista = (List<Actividad>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Actividades</title>
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
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
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

        .btn-edit, .btn-del {
            padding: 5px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            margin-right: 4px;
            display: inline-block;
        }

        .btn-edit { background: #f0ad00; color: #fff; }
        .btn-edit:hover { background: #e09900; }
        .btn-del { background: #e74c3c; color: #fff; }
        .btn-del:hover { background: #c0392b; }

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
    </style>
</head>
<body>

<h2>📋 Gestión de Actividades</h2>
<a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<div class="form-container">
    <div class="form-group">
        <label>Nombre de la actividad</label>
        <input type="text" id="nombreActividad" placeholder="Ej: Listar Usuarios">
    </div>
    <div class="form-group">
        <label>Enlace (URL)</label>
        <input type="text" id="enlaceActividad" placeholder="Ej: listarUsuarios.jsp">
    </div>
    <button onclick="agregarActividad()" class="btn-agregar">+ Agregar Actividad</button>
</div>

<table>
    <thead><tr><th>ID</th><th>Nombre</th><th>Enlace</th><th>Acciones</th></tr></thead>
    <tbody>
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Actividad a : lista) {
    %>
        <tr>
            <td><%= a.getIdActividad() %></td>
            <td><%= a.getNomActividad() %></td>
            <td><%= a.getEnlace() %></td>
            <td>
                <a href="editarActividad.jsp?id=<%= a.getIdActividad() %>" target="marco" class="btn-edit">Editar</a>
                <a href="ControladorActividad?accion=eliminar&id=<%= a.getIdActividad() %>" 
                   class="btn-del" 
                   onclick="return confirm('¿Eliminar esta actividad?')">Eliminar</a>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="4" style="text-align:center">No hay actividades registradas</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<script>
    function agregarActividad() {
        var nombre = document.getElementById('nombreActividad').value.trim();
        var enlace = document.getElementById('enlaceActividad').value.trim();
        
        if (nombre === "") {
            alert("Ingrese un nombre para la actividad");
            return;
        }
        if (enlace === "") {
            alert("Ingrese un enlace para la actividad");
            return;
        }
        
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'ControladorActividad';
        form.target = 'marco';
        
        var inputAccion = document.createElement('input');
        inputAccion.type = 'hidden';
        inputAccion.name = 'accion';
        inputAccion.value = 'registrar';
        
        var inputNombre = document.createElement('input');
        inputNombre.type = 'hidden';
        inputNombre.name = 'nom_actividad';
        inputNombre.value = nombre;
        
        var inputEnlace = document.createElement('input');
        inputEnlace.type = 'hidden';
        inputEnlace.name = 'enlace';
        inputEnlace.value = enlace;
        
        form.appendChild(inputAccion);
        form.appendChild(inputNombre);
        form.appendChild(inputEnlace);
        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>