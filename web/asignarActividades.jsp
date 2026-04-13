<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    // Obtener todos los perfiles
    PerfilDAO perfilDAO = new PerfilDAO();
    List<Perfil> perfiles = perfilDAO.listar();
    
    // Obtener todas las actividades
    ActividadDAO actividadDAO = new ActividadDAO();
    List<Actividad> actividades = actividadDAO.listar();
    
    // Obtener asignaciones existentes
    GesActividadDAO gesDAO = new GesActividadDAO();
    List<String[]> asignaciones = gesDAO.listarConNombres();
    
    // Crear un mapa para saber qué actividades ya están asignadas a cada perfil
    Map<String, Boolean> mapaAsignaciones = new HashMap<>();
    for (String[] asig : asignaciones) {
        String key = asig[1] + "_" + asig[2]; // perfil_actividad
        mapaAsignaciones.put(key, true);
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asignar Actividades</title>
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
        }

        .perfil-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            width: 300px;
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

        .actividad-item {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .actividad-item:last-child {
            border-bottom: none;
        }

        .actividad-nombre {
            font-size: 13px;
            color: #444;
        }

        .checkbox-asignar {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .btn-guardar {
            background: #4361ee;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
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
        }
    </style>
</head>
<body>

<h2>⚙️ Asignar Actividades por Perfil</h2>
<a href="cpanel.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<div class="container" id="containerPerfiles">
    <%
        for (Perfil perfil : perfiles) {
    %>
    <div class="perfil-card" data-perfil-id="<%= perfil.getIdPerfil() %>">
        <h3><%= perfil.getPerfil() %></h3>
        <div class="actividades-lista">
            <%
                for (Actividad actividad : actividades) {
                    String key = perfil.getPerfil() + "_" + actividad.getNomActividad();
                    boolean asignada = mapaAsignaciones.containsKey(key);
            %>
            <div class="actividad-item">
                <span class="actividad-nombre"><%= actividad.getNomActividad() %></span>
                <input type="checkbox" 
                       class="checkbox-asignar" 
                       data-perfil="<%= perfil.getIdPerfil() %>" 
                       data-actividad="<%= actividad.getIdActividad() %>"
                       data-nombre-actividad="<%= actividad.getNomActividad() %>"
                       <%= asignada ? "checked" : "" %>>
            </div>
            <%
                }
            %>
        </div>
        <button class="btn-guardar" onclick="guardarAsignaciones(this)">Guardar Cambios</button>
    </div>
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
        
        var actividadesAsignar = [];
        var actividadesQuitar = [];
        
        checkboxes.forEach(function(checkbox) {
            var actividadId = checkbox.getAttribute('data-actividad');
            var actividadNombre = checkbox.getAttribute('data-nombre-actividad');
            
            if (checkbox.checked) {
                actividadesAsignar.push({id: actividadId, nombre: actividadNombre});
            } else {
                actividadesQuitar.push({id: actividadId, nombre: actividadNombre});
            }
        });
        
        // Primero eliminar las que ya no están marcadas
        var eliminarPromises = actividadesQuitar.map(function(act) {
            return fetch('ControladorGesActividad', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'accion=eliminarPorPerfilActividad&id_perfil=' + perfilId + '&id_actividad=' + act.id
            });
        });
        
        Promise.all(eliminarPromises)
            .then(function() {
                // Luego agregar las nuevas
                var agregarPromises = actividadesAsignar.map(function(act) {
                    return fetch('ControladorGesActividad', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'accion=asignar&id_perfil=' + perfilId + '&id_actividad=' + act.id
                    });
                });
                return Promise.all(agregarPromises);
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