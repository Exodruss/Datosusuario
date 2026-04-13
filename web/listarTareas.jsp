<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" %>
<%
    List<Map<String, Object>> tareas = (List<Map<String, Object>>) request.getAttribute("tareas");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Tareas</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }

        h2 { color: #1a1a2e; margin-bottom: 20px; }

        .btn-nuevo, .btn-volver {
            display: inline-block;
            background: #4361ee;
            color: #fff;
            padding: 9px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 20px;
            border: none;
            cursor: pointer;
        }

        .btn-volver {
            background: #6c757d;
            margin-left: 10px;
        }

        .btn-volver:hover { background: #5a6268; }
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

        .btn-edit, .btn-del {
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

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 12px;
            width: 500px;
            max-width: 90%;
        }

        .modal-content h3 {
            margin-bottom: 20px;
            color: #1a1a2e;
        }

        .modal-content input, .modal-content textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        .modal-content button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-guardar { background: #4361ee; color: white; }
        .btn-cancelar { background: #6c757d; color: white; }
        
        .vencida {
            color: #e74c3c;
            font-weight: bold;
        }
        
        .pendiente {
            color: #f0ad00;
        }
    </style>
</head>
<body>

<h2>📋 Gestión de Tareas</h2>
<div>
    <button onclick="abrirModalNuevo()" class="btn-nuevo">+ Nueva Tarea</button>
    <a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Tarea</th>
            <th>Descripción</th>
            <th>Fecha Entrega</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
    <%
        if (tareas != null && !tareas.isEmpty()) {
            java.util.Date hoy = new java.util.Date();
            for (Map<String, Object> tarea : tareas) {
                java.sql.Date fechaEntrega = (java.sql.Date) tarea.get("fecha_entrega");
                String estado = (String) tarea.get("estado");
                String estadoClass = "";
                String estadoTexto = "";
                
                if (fechaEntrega.before(hoy) && !"completada".equals(estado)) {
                    estadoClass = "vencida";
                    estadoTexto = "Vencida";
                } else if ("completada".equals(estado)) {
                    estadoClass = "";
                    estadoTexto = "Completada";
                } else {
                    estadoClass = "pendiente";
                    estadoTexto = "Pendiente";
                }
    %>
        <tr>
            <td><%= tarea.get("id_tarea") %></td>
            <td><%= tarea.get("nombre_tarea") %></td>
            <td><%= tarea.get("descripcion") %></td>
            <td><%= fechaEntrega %></td>
            <td class="<%= estadoClass %>"><%= estadoTexto %></td>
            <td>
                <button onclick="editarTarea(<%= tarea.get("id_tarea") %>, '<%= tarea.get("nombre_tarea") %>', '<%= tarea.get("descripcion") %>', '<%= fechaEntrega %>')" class="btn-edit">Editar</button>
                <a href="ControladorTarea?accion=eliminar&id=<%= tarea.get("id_tarea") %>" class="btn-del" onclick="return confirm('¿Eliminar esta tarea?')">Eliminar</a>
            </td>
        </tr>
    <%
            }
        } else {
    %>
        <tr>
            <td colspan="6" style="text-align:center">No hay tareas registradas</td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Modal para Nueva Tarea -->
<div id="modalNuevo" class="modal">
    <div class="modal-content">
        <h3>➕ Nueva Tarea</h3>
        <form action="ControladorTarea" method="post">
            <input type="hidden" name="accion" value="registrar">
            <input type="text" name="nombre_tarea" placeholder="Nombre de la tarea" required>
            <textarea name="descripcion" rows="3" placeholder="Descripción de la tarea" required></textarea>
            <input type="date" name="fecha_entrega" required>
            <div>
                <button type="submit" class="btn-guardar">Guardar</button>
                <button type="button" class="btn-cancelar" onclick="cerrarModal()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal para Editar Tarea -->
<div id="modalEditar" class="modal">
    <div class="modal-content">
        <h3>✏️ Editar Tarea</h3>
        <form action="ControladorTarea" method="post">
            <input type="hidden" name="accion" value="editar">
            <input type="hidden" name="id_tarea" id="edit_id">
            <input type="text" name="nombre_tarea" id="edit_nombre" placeholder="Nombre de la tarea" required>
            <textarea name="descripcion" id="edit_descripcion" rows="3" placeholder="Descripción de la tarea" required></textarea>
            <input type="date" name="fecha_entrega" id="edit_fecha" required>
            <div>
                <button type="submit" class="btn-guardar">Actualizar</button>
                <button type="button" class="btn-cancelar" onclick="cerrarModalEditar()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<script>
    function abrirModalNuevo() {
        document.getElementById('modalNuevo').style.display = 'flex';
    }
    
    function cerrarModal() {
        document.getElementById('modalNuevo').style.display = 'none';
    }
    
    function editarTarea(id, nombre, descripcion, fecha) {
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_nombre').value = nombre;
        document.getElementById('edit_descripcion').value = descripcion;
        document.getElementById('edit_fecha').value = fecha;
        document.getElementById('modalEditar').style.display = 'flex';
    }
    
    function cerrarModalEditar() {
        document.getElementById('modalEditar').style.display = 'none';
    }
    
    window.onclick = function(event) {
        if (event.target == document.getElementById('modalNuevo')) {
            cerrarModal();
        }
        if (event.target == document.getElementById('modalEditar')) {
            cerrarModalEditar();
        }
    }
</script>

</body>
</html>