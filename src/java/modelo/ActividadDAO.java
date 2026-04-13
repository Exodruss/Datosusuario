package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActividadDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public ActividadDAO() {}

    public boolean insertar(Actividad a) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("INSERT INTO actividades (nom_actividad, enlace) VALUES (?, ?)");
            stmt.setString(1, a.getNomActividad());
            stmt.setString(2, a.getEnlace());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error insertar actividad: " + e.getMessage());
        }
        return ok;
    }

    public List<Actividad> listar() {
        List<Actividad> lista = new ArrayList<>();
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM actividades ORDER BY id_actividad");
            rs = stmt.executeQuery();
            while (rs.next()) {
                Actividad a = new Actividad();
                a.setIdActividad(rs.getInt("id_actividad"));
                a.setNomActividad(rs.getString("nom_actividad"));
                a.setEnlace(rs.getString("enlace"));
                lista.add(a);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error listar actividades: " + e.getMessage());
        }
        return lista;
    }

    public Actividad buscarPorId(int id) {
        Actividad a = null;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM actividades WHERE id_actividad = ?");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                a = new Actividad();
                a.setIdActividad(rs.getInt("id_actividad"));
                a.setNomActividad(rs.getString("nom_actividad"));
                a.setEnlace(rs.getString("enlace"));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error buscar actividad: " + e.getMessage());
        }
        return a;
    }

    public boolean actualizar(Actividad a) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("UPDATE actividades SET nom_actividad = ?, enlace = ? WHERE id_actividad = ?");
            stmt.setString(1, a.getNomActividad());
            stmt.setString(2, a.getEnlace());
            stmt.setInt(3, a.getIdActividad());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error actualizar actividad: " + e.getMessage());
        }
        return ok;
    }

    public boolean eliminar(int id) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("DELETE FROM actividades WHERE id_actividad = ?");
            stmt.setInt(1, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Actividad eliminada ID: " + id + " - Resultado: " + resultado);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error eliminar actividad: " + e.getMessage());
        }
        return ok;
    }
}