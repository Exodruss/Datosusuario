package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GesActividadDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public GesActividadDAO() {}

    public boolean insertar(GesActividad g) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement(
                "INSERT INTO gesactividad (id_perfil, id_actividad) VALUES (?, ?)"
            );
            stmt.setInt(1, g.getIdPerfil());
            stmt.setInt(2, g.getIdActividad());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error insertar gesactividad: " + e.getMessage());
        }
        return ok;
    }

    public List<String[]> listarConNombres() {
        List<String[]> lista = new ArrayList<>();
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement(
                "SELECT g.idgesActividad, p.perfil, a.nom_actividad " +
                "FROM gesactividad g " +
                "JOIN perfiles p ON g.id_perfil = p.id_perfil " +
                "JOIN actividades a ON g.id_actividad = a.id_actividad"
            );
            rs = stmt.executeQuery();
            while (rs.next()) {
                String[] fila = {
                    rs.getString("idgesActividad"),
                    rs.getString("perfil"),
                    rs.getString("nom_actividad")
                };
                lista.add(fila);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error listar gesactividad: " + e.getMessage());
        }
        return lista;
    }
    
    public boolean existeAsignacion(int idPerfil, int idActividad) {
        boolean existe = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement(
                "SELECT * FROM gesactividad WHERE id_perfil = ? AND id_actividad = ?"
            );
            stmt.setInt(1, idPerfil);
            stmt.setInt(2, idActividad);
            rs = stmt.executeQuery();
            existe = rs.next();
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error verificar asignación: " + e.getMessage());
        }
        return existe;
    }
    
    public boolean eliminar(int id) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("DELETE FROM gesactividad WHERE idgesActividad = ?");
            stmt.setInt(1, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error eliminar gesactividad: " + e.getMessage());
        }
        return ok;
    }
    
    public boolean eliminarPorPerfilActividad(int idPerfil, int idActividad) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement(
                "DELETE FROM gesactividad WHERE id_perfil = ? AND id_actividad = ?"
            );
            stmt.setInt(1, idPerfil);
            stmt.setInt(2, idActividad);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error eliminar asignación: " + e.getMessage());
        }
        return ok;
    }
}