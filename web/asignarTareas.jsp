<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    List<Perfil> perfiles = (List<Perfil>) request.getAttribute("perfiles");
    List<Map<String, Object>> tareas = (List<Map<String, Object>>) request.getAttribute("tareas");
    Map<String, Boolean> asignaciones = (Map<String, Boolean>) request.getAttribute("asignaciones");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Tareas</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }

        h2 { color: #1a1a2e; margin-bottom: 20px; text-align: center; }

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

        .btn-volver:hover { background: #5a6268; }

        .container {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .perfil-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            width: 380px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .perfil-card h3 {
            background: #1a1a2e;
            color: white;
            padding: 10px;
            margin: -20px -20px 15px -20px;
            border-radius: 12px 12px 0 0;
            text-align: center;
        }

        .tarea-item {
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .tarea-item:last-child {
            border-bottom: none;
        }

        .tarea-info {
            flex: 1;
        }

        .tarea-nombre {
            font-size: 14px;
            font-weight: 500;
            color: #333;
        }

        .tarea-fecha {
            font-size: 11px;
            color: #888;
            margin-top: 3px;
        }

        .checkbox-asignar {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin-left: 10px;
        }

        .btn-guardar {
            background: #4361ee;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
            font-weight: 600;
        }

        .btn-guardar:hover { background: #3451d1; }

        .mensaje {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #27ae60;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            display: none;
            z-index: 1000;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>

<h2>⚙️ Asignar Tareas por Perfil</h2>
<a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<div class="container" id="containerPerfiles">
    <%
        if (perfiles != null && !perfiles.isEmpty()) {
            for (Perfil perfil : perfiles) {
    %>
    <div class="perfil-card" data-perfil-id="<%= perfil.getIdPerfil() %>">
        <h3><%= perfil.getPerfil() %></h3>
        <div class="tareas-lista">
            <%
                if (tareas != null && !tareas.isEmpty()) {
                    for (Map<String, Object> tarea : tareas) {
                        int idTarea = (Integer) tarea.get("id_tarea");
                        String nombreTarea = (String) tarea.get("nombre_tarea");
                        java.sql.Date fechaEntrega = (java.sql.Date) tarea.get("fecha_entrega");
                        String key = perfil.getIdPerfil() + "_" + idTarea;
                        boolean asignada = asignaciones != null && asignaciones.containsKey(key);
            %>
            <div class="tarea-item">
                <div class="tarea-info">
                    <div class="tarea-nombre"><%= nombreTarea %></div>
                    <div class="tarea-fecha">📅 Entrega: <%= fechaEntrega %></div>
                </div>
                <input type="checkbox" 
                       class="checkbox-asignar" 
                       data-perfil="<%= perfil.getIdPerfil() %>" 
                       data-tarea="<%= idTarea %>"
                       data-nombre-tarea="<%= nombreTarea %>"
                       <%= asignada ? "checked" : "" %>>
            </div>
            <%
                    }
                } else {
            %>
            <div style="padding: 20px; text-align: center; color: #999;">
                No hay tareas registradas. Crea tareas primero en "Gestión de Tareas"
            </div>
            <%
                }
            %>
        </div>
        <button class="btn-guardar" onclick="guardarAsignaciones(this)">💾 Guardar Cambios</button>
    </div>
    <%
            }
        } else {
    %>
    <div class="loading">Cargando perfiles...</div>
    <%
        }
    %>
</div>

<div id="mensaje" class="mensaje"></div>

<script>
    function mostrarMensaje(texto, tipo) {
        var mensaje = document.getElementById('mensaje');
        mensaje.textContent = texto;
        mensaje.style.backgroundColor = tipo === 'error' ? '#e74c3c' : '#27ae60';
        mensaje.style.display = 'block';
        setTimeout(function() {
            mensaje.style.display = 'none';
        }, 3000);
    }
    
    function guardarAsignaciones(boton) {
        var perfilCard = boton.closest('.perfil-card');
        var perfilId = perfilCard.getAttribute('data-perfil-id');
        var checkboxes = perfilCard.querySelectorAll('.checkbox-asignar');
        
        var asignacionesActuales = [];
        checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                asignacionesActuales.push(checkbox.getAttribute('data-tarea'));
            }
        });
        
        // Primero eliminar TODAS las asignaciones de este perfil
        fetch('ControladorAsignarTarea', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'accion=eliminarTodas&id_perfil=' + perfilId
        })
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.success) {
                // Luego agregar las nuevas seleccionadas
                var promesas = asignacionesActuales.map(function(tareaId) {
                    return fetch('ControladorAsignarTarea', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'accion=asignar&id_perfil=' + perfilId + '&id_tarea=' + tareaId
                    });
                });
                return Promise.all(promesas);
            } else {
                throw new Error('Error al eliminar asignaciones');
            }
        })
        .then(function() {
            mostrarMensaje('✅ Asignaciones guardadas correctamente', 'success');
        })
        .catch(function(error) {
            console.error('Error:', error);
            mostrarMensaje('❌ Error al guardar las asignaciones', 'error');
        });
    }
</script>

</body>
</html>