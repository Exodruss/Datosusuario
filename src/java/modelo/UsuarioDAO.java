package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    private Connection conn = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public List<Usuario> listar() {
        List<Usuario> lista = new ArrayList<>();
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM usuarios ORDER BY idusu");
            rs = stmt.executeQuery();
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdusu(rs.getInt("idusu"));
                u.setNumDocu(rs.getString("num_docu"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setIdPerfil(rs.getInt("id_perfil"));
                u.setActivo(rs.getInt("activo"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return lista;
    }
    
    public boolean insertar(Usuario u) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            
            // Verificar si el usuario ya existe
            stmt = conn.prepareStatement("SELECT usuario FROM usuarios WHERE usuario = ?");
            stmt.setString(1, u.getUsuario());
            rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("El usuario ya existe: " + u.getUsuario());
                rs.close();
                stmt.close();
                conn.close();
                return false;
            }
            rs.close();
            stmt.close();
            
            // Insertar nuevo usuario (activo por defecto = 1)
            stmt = conn.prepareStatement(
                "INSERT INTO usuarios (num_docu, nombre, apellido, email, usuario, clave, id_perfil, activo) VALUES (?, ?, ?, ?, ?, ?, ?, 1)"
            );
            stmt.setString(1, u.getNumDocu());
            stmt.setString(2, u.getNombre());
            stmt.setString(3, u.getApellido());
            stmt.setString(4, u.getEmail());
            stmt.setString(5, u.getUsuario());
            stmt.setString(6, u.getClave());
            stmt.setInt(7, u.getIdPerfil());
            
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Usuario insertado: " + u.getUsuario() + " - Resultado: " + resultado);
            
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al insertar usuario: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    public boolean actualizar(Usuario u) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement(
                "UPDATE usuarios SET num_docu=?, nombre=?, apellido=?, email=?, usuario=?, clave=?, id_perfil=? WHERE idusu=?"
            );
            stmt.setString(1, u.getNumDocu());
            stmt.setString(2, u.getNombre());
            stmt.setString(3, u.getApellido());
            stmt.setString(4, u.getEmail());
            stmt.setString(5, u.getUsuario());
            stmt.setString(6, u.getClave());
            stmt.setInt(7, u.getIdPerfil());
            stmt.setInt(8, u.getIdusu());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    public boolean activarDesactivar(int id, int activo) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("UPDATE usuarios SET activo = ? WHERE idusu = ?");
            stmt.setInt(1, activo);
            stmt.setInt(2, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Usuario ID: " + id + " - Activo: " + activo + " - Resultado: " + resultado);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al activar/desactivar usuario: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    public boolean eliminar(int id) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("DELETE FROM usuarios WHERE idusu = ?");
            stmt.setInt(1, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Usuario eliminado ID: " + id + " - Resultado: " + resultado);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al eliminar usuario: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    public Usuario buscarPorId(int id) {
        Usuario u = null;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM usuarios WHERE idusu = ?");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                u = new Usuario();
                u.setIdusu(rs.getInt("idusu"));
                u.setNumDocu(rs.getString("num_docu"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setIdPerfil(rs.getInt("id_perfil"));
                u.setActivo(rs.getInt("activo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return u;
    }
}