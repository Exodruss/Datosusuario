<%@ page contentType="text/html; charset=UTF-8" language="java" import="modelo.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ActividadDAO dao = new ActividadDAO();
    Actividad actividad = dao.buscarPorId(id);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Actividad</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 24px; }
        
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        h2 { color: #1a1a2e; margin-bottom: 20px; text-align: center; }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #444;
            margin-bottom: 5px;
        }
        
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .btn-submit {
            background: #4361ee;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            width: 100%;
        }
        
        .btn-submit:hover { background: #3451d1; }
        
        .btn-volver {
            background: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            width: 100%;
            margin-top: 10px;
        }
        
        .btn-volver:hover { background: #5a6268; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>✏️ Editar Actividad</h2>
        
        <form action="ControladorActividad" method="post">
            <input type="hidden" name="accion" value="editar">
            <input type="hidden" name="id_actividad" value="<%= actividad.getIdActividad() %>">
            
            <div class="form-group">
                <label>Nombre de la Actividad:</label>
                <input type="text" name="nom_actividad" value="<%= actividad.getNomActividad() %>" required>
            </div>
            
            <div class="form-group">
                <label>Enlace (URL):</label>
                <input type="text" name="enlace" value="<%= actividad.getEnlace() %>" required>
            </div>
            
            <button type="submit" class="btn-submit">Actualizar Actividad</button>
            <button type="button" onclick="window.location.href='ControladorActividad?accion=listar'" class="btn-volver">← Volver</button>
        </form>
    </div>
</body>
</html>