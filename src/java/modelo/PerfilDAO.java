package modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PerfilDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    public PerfilDAO() {}

    public boolean insertar(Perfil p) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("INSERT INTO perfiles (perfil, activo) VALUES (?, 1)");
            stmt.setString(1, p.getPerfil());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error insertar perfil: " + e.getMessage());
        }
        return ok;
    }

    public List<Perfil> listar() {
        List<Perfil> lista = new ArrayList<>();
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM perfiles ORDER BY id_perfil");
            rs = stmt.executeQuery();
            while (rs.next()) {
                Perfil p = new Perfil();
                p.setIdPerfil(rs.getInt("id_perfil"));
                p.setPerfil(rs.getString("perfil"));
                p.setActivo(rs.getInt("activo"));
                lista.add(p);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error listar perfiles: " + e.getMessage());
        }
        return lista;
    }
    
    public List<Perfil> listarActivos() {
        List<Perfil> lista = new ArrayList<>();
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM perfiles WHERE activo = 1 ORDER BY id_perfil");
            rs = stmt.executeQuery();
            while (rs.next()) {
                Perfil p = new Perfil();
                p.setIdPerfil(rs.getInt("id_perfil"));
                p.setPerfil(rs.getString("perfil"));
                p.setActivo(rs.getInt("activo"));
                lista.add(p);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error listar perfiles activos: " + e.getMessage());
        }
        return lista;
    }

    public Perfil buscarPorId(int id) {
        Perfil p = null;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("SELECT * FROM perfiles WHERE id_perfil = ?");
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                p = new Perfil();
                p.setIdPerfil(rs.getInt("id_perfil"));
                p.setPerfil(rs.getString("perfil"));
                p.setActivo(rs.getInt("activo"));
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error buscar perfil: " + e.getMessage());
        }
        return p;
    }

    public boolean actualizar(Perfil p) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("UPDATE perfiles SET perfil = ? WHERE id_perfil = ?");
            stmt.setString(1, p.getPerfil());
            stmt.setInt(2, p.getIdPerfil());
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error actualizar perfil: " + e.getMessage());
        }
        return ok;
    }
    
    public boolean activarDesactivar(int id, int activo) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("UPDATE perfiles SET activo = ? WHERE id_perfil = ?");
            stmt.setInt(1, activo);
            stmt.setInt(2, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Perfil ID: " + id + " - Activo: " + activo + " - Resultado: " + resultado);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error activar/desactivar perfil: " + e.getMessage());
        }
        return ok;
    }

    public boolean eliminar(int id) {
        boolean ok = false;
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            stmt = conn.prepareStatement("DELETE FROM perfiles WHERE id_perfil = ?");
            stmt.setInt(1, id);
            int resultado = stmt.executeUpdate();
            ok = (resultado > 0);
            System.out.println("Perfil eliminado ID: " + id + " - Resultado: " + resultado);
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("Error eliminar perfil: " + e.getMessage());
        }
        return ok;
    }
}