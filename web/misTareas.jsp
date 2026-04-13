<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*, java.util.*, modelo.*" %>
<%
    HttpSession sesion_cli = request.getSession(false);

    if (sesion_cli == null || sesion_cli.getAttribute("nUsuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Usuario usuario = (Usuario) sesion_cli.getAttribute("datosUsuario");
    int idPerfil = usuario.getIdPerfil();
    String nombreUsuario = usuario.getNombre() + " " + usuario.getApellido();
    
    List<Map<String, Object>> misTareas = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        Conexion cn = new Conexion();
        conn = cn.crearConexion();
        pstmt = conn.prepareStatement(
            "SELECT t.id_tarea, t.nombre_tarea, t.descripcion, t.fecha_entrega, t.estado " +
            "FROM tareas t " +
            "INNER JOIN tareas_perfil tp ON t.id_tarea = tp.id_tarea " +
            "WHERE tp.id_perfil = ? " +
            "ORDER BY t.fecha_entrega ASC"
        );
        pstmt.setInt(1, idPerfil);
        rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Map<String, Object> tarea = new HashMap<>();
            tarea.put("id_tarea", rs.getInt("id_tarea"));
            tarea.put("nombre_tarea", rs.getString("nombre_tarea"));
            tarea.put("descripcion", rs.getString("descripcion"));
            tarea.put("fecha_entrega", rs.getDate("fecha_entrega"));
            tarea.put("estado", rs.getString("estado"));
            misTareas.add(tarea);
        }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
    
    java.util.Date hoy = new java.util.Date();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Tareas</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }

        h2 { color: #1a1a2e; margin-bottom: 10px; }
        .subtitulo { color: #666; margin-bottom: 30px; font-size: 14px; }

        .tarea-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border-left: 4px solid #4361ee;
        }

        .tarea-card.vencida {
            border-left-color: #e74c3c;
            background: #fff5f5;
        }

        .tarea-titulo {
            font-size: 18px;
            font-weight: 600;
            color: #1a1a2e;
            margin-bottom: 10px;
        }

        .tarea-descripcion {
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .tarea-fecha {
            font-size: 12px;
            color: #888;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .fecha-vencimiento {
            background: #f0ad00;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
        }

        .fecha-vencida {
            background: #e74c3c;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
        }

        .empty-message {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 12px;
            color: #999;
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

<h2>📋 Mis Tareas</h2>
<p class="subtitulo">Bienvenido, <%= nombreUsuario %> - Estas son las tareas asignadas para ti</p>
<a href="front.jsp" target="_top" class="btn-volver">← Volver al Panel</a>

<%
    if (misTareas != null && !misTareas.isEmpty()) {
        for (Map<String, Object> tarea : misTareas) {
            java.sql.Date fechaEntrega = (java.sql.Date) tarea.get("fecha_entrega");
            String estado = (String) tarea.get("estado");
            String claseCard = "";
            String claseFecha = "";
            String textoFecha = "";
            
            if (fechaEntrega.before(hoy) && !"completada".equals(estado)) {
                claseCard = "vencida";
                claseFecha = "fecha-vencida";
                textoFecha = "VENCIDA";
            } else {
                claseCard = "";
                claseFecha = "fecha-vencimiento";
                textoFecha = "Pendiente hasta:";
            }
%>
<div class="tarea-card <%= claseCard %>">
    <div class="tarea-titulo">📌 <%= tarea.get("nombre_tarea") %></div>
    <div class="tarea-descripcion"><%= tarea.get("descripcion") %></div>
    <div class="tarea-fecha">
        <span class="<%= claseFecha %>"><%= textoFecha %></span>
        <span><%= fechaEntrega %></span>
    </div>
</div>
<%
        }
    } else {
%>
<div class="empty-message">
    📭 No tienes tareas asignadas actualmente.<br>
    Contacta al administrador para más información.
</div>
<%
    }
%>

</body>
</html>