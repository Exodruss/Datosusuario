<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mensaje</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .message-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            max-width: 400px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .message-card h2 { color: #1a1a2e; margin-bottom: 15px; }
        .message-card p { color: #666; margin-bottom: 20px; }
        .btn-ok {
            background: #4361ee;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-ok:hover { background: #3451d1; }
    </style>
</head>
<body>
    <div class="message-card">
        <h2>✅ Operación Exitosa</h2>
        <p><%= request.getAttribute("mensaje") != null ? request.getAttribute("mensaje") : "Operación realizada correctamente." %></p>
        <a href="listarUsuarios" target="marco" class="btn-ok">Aceptar</a>
    </div>
</body>
</html>