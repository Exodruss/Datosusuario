<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    List<String[]> lista = (List<String[]>) request.getAttribute("lista");
    List<Perfil> perfiles = (List<Perfil>) request.getAttribute("perfiles");
    List<Actividad> actividades = (List<Actividad>) request.getAttribute("actividades");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Actividades</title>
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

        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .btn-asignar {
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

        .btn-del {
            background: #e74c3c;
            color: white;
            padding: 5px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

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

<h2>⚙️ Asignar Actividades por Perfil</h2>
<a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<div class="form-container">
    <div class="form-group">
        <label>Perfil</label>
        <select id="id_perfil">
            <option value="">Seleccione un perfil</option>
            <% if (perfiles != null) {
                for (Perfil p : perfiles) { %>
                    <option value="<%= p.getIdPerfil() %>"><%= p.getPerfil() %></option>
            <%      }
               } %>
        </select>
    </div>
    <div class="form-group">
        <label>Actividad</label>
        <select id="id_actividad">
            <option value="">Seleccione una actividad</option>
            <% if (actividades != null) {
                for (Actividad a : actividades) { %>
                    <option value="<%= a.getIdActividad() %>"><%= a.getNomActividad() %></option>
            <%      }
               } %>
        </select>
    </div>
    <button onclick="asignarActividad()" class="btn-asignar">+ Asignar Actividad</button>
</div>

<table>
    <thead><tr><th>ID</th><th>Perfil</th><th>Actividad</th><th>Acciones</th></tr></thead>
    <tbody>
    <%
        if (lista != null && !lista.isEmpty()) {
            for (String[] fila : lista) {
    %>
        <tr>
            <td><%= fila[0] %></td>
            <td><%= fila[1] %></td>
            <td><%= fila[2] %></td>
            <td>
                <a href="ControladorGesActividad?accion=eliminar&id=<%= fila[0] %>" 
                   class="btn-del" 
                   onclick="return confirm('¿Eliminar esta asignación?')">Eliminar</a>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr><td colspan="4" style="text-align:center">No hay asignaciones registradas</td></tr>
    <%
        }
    %>
    </tbody>
</table>

<script>
    function asignarActividad() {
        var idPerfil = document.getElementById('id_perfil').value;
        var idActividad = document.getElementById('id_actividad').value;
        
        if (idPerfil === "") {
            alert("Seleccione un perfil");
            return;
        }
        if (idActividad === "") {
            alert("Seleccione una actividad");
            return;
        }
        
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = 'ControladorGesActividad';
        form.target = 'marco';
        
        var inputAccion = document.createElement('input');
        inputAccion.type = 'hidden';
        inputAccion.name = 'accion';
        inputAccion.value = 'asignar';
        
        var inputIdPerfil = document.createElement('input');
        inputIdPerfil.type = 'hidden';
        inputIdPerfil.name = 'id_perfil';
        inputIdPerfil.value = idPerfil;
        
        var inputIdActividad = document.createElement('input');
        inputIdActividad.type = 'hidden';
        inputIdActividad.name = 'id_actividad';
        inputIdActividad.value = idActividad;
        
        form.appendChild(inputAccion);
        form.appendChild(inputIdPerfil);
        form.appendChild(inputIdActividad);
        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>