<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, modelo.*" %>
<%
    PerfilDAO perfilDAO = new PerfilDAO();
    List<Perfil> perfiles = perfilDAO.listarActivos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Usuario</title>
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
        
        input, select {
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
        
        .password-wrapper {
            position: relative;
        }
        
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>➕ Registrar Nuevo Usuario</h2>
        <form action="ControladorUsuario" method="post">
            <input type="hidden" name="accion" value="registrar">
            
            <div class="form-group">
                <label>Número de Documento:</label>
                <input type="text" name="num_docu" required>
            </div>
            
            <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="nombre" required>
            </div>
            
            <div class="form-group">
                <label>Apellido:</label>
                <input type="text" name="apellido" required>
            </div>
            
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label>Usuario:</label>
                <input type="text" name="usuario" required>
            </div>
            
            <div class="form-group">
                <label>Contraseña:</label>
                <div class="password-wrapper">
                    <input type="password" name="clave" id="clave" required>
                    <span class="toggle-password" onclick="togglePassword()">👁️</span>
                </div>
            </div>
            
            <div class="form-group">
                <label>Perfil:</label>
                <select name="id_perfil" required>
                    <option value="">Seleccione un perfil</option>
                    <% if (perfiles != null) {
                        for (Perfil p : perfiles) { %>
                            <option value="<%= p.getIdPerfil() %>"><%= p.getPerfil() %></option>
                    <%      }
                       } %>
                </select>
            </div>
            
            <button type="submit" class="btn-submit">Registrar Usuario</button>
            <button type="button" onclick="window.location.href='ControladorUsuario?accion=listar'" class="btn-volver">← Volver</button>
        </form>
    </div>
    
    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('clave');
            const toggleIcon = document.querySelector('.toggle-password');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.textContent = '🙈';
            } else {
                passwordInput.type = 'password';
                toggleIcon.textContent = '👁️';
            }
        }
    </script>
</body>
</html>