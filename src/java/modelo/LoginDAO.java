package modelo;

import java.sql.*;

public class LoginDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public LoginDAO() {}

    public Usuario Login_datos(String usuario, String clave) {
        Usuario datos = null;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            
            // Verificar usuario activo y perfil activo
            stmt = conn.prepareStatement(
                "SELECT u.*, p.activo as perfil_activo " +
                "FROM usuarios u " +
                "INNER JOIN perfiles p ON u.id_perfil = p.id_perfil " +
                "WHERE u.usuario = ? AND u.clave = ? AND u.activo = 1 AND p.activo = 1"
            );
            stmt.setString(1, usuario);
            stmt.setString(2, clave);
            rs = stmt.executeQuery();

            if (rs.next()) {
                datos = new Usuario();
                datos.setIdusu(rs.getInt("idusu"));
                datos.setNumDocu(rs.getString("num_docu"));
                datos.setNombre(rs.getString("nombre"));
                datos.setApellido(rs.getString("apellido"));
                datos.setEmail(rs.getString("email"));
                datos.setUsuario(rs.getString("usuario"));
                datos.setClave(rs.getString("clave"));
                datos.setIdPerfil(rs.getInt("id_perfil"));
                datos.setActivo(rs.getInt("activo"));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error en Login_datos: " + e.getMessage());
        }
        return datos;
    }
}