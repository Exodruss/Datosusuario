<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #1a1a2e;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-card {
            background: #fff;
            border-radius: 12px;
            padding: 40px 48px;
            width: 380px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
        }

        .login-card h2 {
            text-align: center;
            margin-bottom: 8px;
            color: #1a1a2e;
        }

        .login-card p.sub {
            text-align: center;
            color: #888;
            font-size: 13px;
            margin-bottom: 28px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #444;
            margin-bottom: 6px;
        }

        .password-wrapper {
            position: relative;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px 40px 10px 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: border .2s;
        }

        input:focus { border-color: #4361ee; }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            user-select: none;
            font-size: 18px;
            color: #888;
            transition: color .2s;
        }

        .toggle-password:hover {
            color: #4361ee;
        }

        .show-password-option {
            margin: 8px 0 0 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .show-password-option input {
            width: auto;
            margin: 0;
            cursor: pointer;
        }

        .show-password-option label {
            margin: 0;
            font-weight: normal;
            font-size: 12px;
            cursor: pointer;
            color: #666;
        }

        .btn-ingresar {
            width: 100%;
            padding: 12px;
            background: #4361ee;
            color: #fff;
            font-size: 15px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 8px;
            transition: background .2s;
        }

        .btn-ingresar:hover { background: #3451d1; }

        .error-msg {
            background: #ffe3e3;
            color: #c0392b;
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 13px;
            margin-bottom: 16px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>🔐 Control de Acceso</h2>
    <p class="sub">Universidad de San Buenaventura</p>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg"><%= request.getAttribute("error") %></div>
    <% } %>

    <form method="post" action="ctrolValidar">
        <div class="form-group">
            <label for="cusuario">Usuario</label>
            <input type="text" name="cusuario" id="cusuario" placeholder="Ingrese su usuario" required />
        </div>
        <div class="form-group">
            <label for="cclave">Contraseña</label>
            <div class="password-wrapper">
                <input type="password" name="cclave" id="cclave" placeholder="Ingrese su contraseña" required />
                <span class="toggle-password" onclick="togglePasswordVisibility()">👁️</span>
            </div>
            <div class="show-password-option">
                <input type="checkbox" id="showPasswordCheckbox" onclick="togglePasswordVisibility()">
                <label for="showPasswordCheckbox">Mostrar contraseña</label>
            </div>
        </div>
        <input type="hidden" name="accion" value="Ingresar" />
        <button type="submit" class="btn-ingresar">Ingresar</button>
    </form>
</div>

<script>
    function togglePasswordVisibility() {
        const passwordInput = document.getElementById('cclave');
        const toggleIcon = document.querySelector('.toggle-password');
        const checkbox = document.getElementById('showPasswordCheckbox');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.textContent = '🙈';
            if (checkbox) checkbox.checked = true;
        } else {
            passwordInput.type = 'password';
            toggleIcon.textContent = '👁️';
            if (checkbox) checkbox.checked = false;
        }
    }
</script>

</body>
</html>