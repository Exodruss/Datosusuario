<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*, modelo.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    UsuarioDAO dao = new UsuarioDAO();
    Usuario u = dao.buscarPorId(id);

    Connection conn = null;
    Statement  stmt = null;
    ResultSet  rs   = null;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; padding: 30px; }

        .card {
            background: #fff;
            border-radius: 12px;
            padding: 32px 36px;
            max-width: 560px;
            box-shadow: 0 2px 12px rgba(0,0,0,.08);
        }

        h2 { color: #1a1a2e; margin-bottom: 24px; font-size: 20px; }

        .form-group { margin-bottom: 16px; }

        label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 9px 13px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
        }

        input:focus, select:focus { border-color: #4361ee; }

        .btn-guardar {
            background: #f0ad00;
            color: #fff;
            padding: 11px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>✏️ Editar Usuario</h2>

    <% if (u != null) { %>
    <form method="post" action="registrarUsuario">
        <input type="hidden" name="accion" value="editar" />
        <input type="hidden" name="idusu"  value="<%= u.getIdusu() %>" />

        <div class="form-group">
            <label>N° Documento</label>
            <input type="text" name="num_docu"  value="<%= u.getNumDocu() %>"  required />
        </div>
        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="nombre"    value="<%= u.getNombre() %>"   required />
        </div>
        <div class="form-group">
            <label>Apellido</label>
            <input type="text" name="apellido"  value="<%= u.getApellido() %>" required />
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email"    value="<%= u.getEmail() %>"    required />
        </div>
        <div class="form-group">
            <label>Usuario</label>
            <input type="text" name="usuario"   value="<%= u.getUsuario() %>"  required />
        </div>
        <div class="form-group">
            <label>Contraseña</label>
            <input type="password" name="clave" value="<%= u.getClave() %>"    maxlength="8" required />
        </div>
        <div class="form-group">
            <label>Perfil</label>
            <select name="id_perfil" required>
                <%
                    try {
                        Conexion cn = new Conexion();
                        conn = cn.crearConexion();
                        stmt = conn.createStatement();
                        rs   = stmt.executeQuery("SELECT * FROM perfiles");
                        while (rs.next()) {
                            int    pid    = rs.getInt("id_perfil");
                            String pnom   = rs.getString("perfil");
                            String sel    = (pid == u.getIdPerfil()) ? "selected" : "";
                %>
                <option value="<%= pid %>" <%= sel %>><%= pnom %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs   != null) try { rs.close();   } catch (Exception e) {}
                        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                        if (conn != null) try { conn.close(); } catch (Exception e) {}
                    }
                %>
            </select>
        </div>

        <button type="submit" class="btn-guardar">Actualizar</button>
    </form>
    <% } else { %>
        <p style="color:red">Usuario no encontrado.</p>
    <% } %>
</div>

</body>
</html>
