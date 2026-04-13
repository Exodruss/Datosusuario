<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bienvenido</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .welcome-card {
            text-align: center;
            background: white;
            padding: 60px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            max-width: 500px;
        }
        .welcome-card h1 {
            font-size: 32px;
            color: #1a1a2e;
            margin-bottom: 15px;
        }
        .welcome-card p {
            font-size: 16px;
            color: #666;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
    <div class="welcome-card">
        <h1>👋 Bienvenido al Sistema</h1>
        <p>Selecciona una opción del menú para comenzar.</p>
    </div>
</body>
</html>