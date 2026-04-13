package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import modelo.Conexion;
import modelo.Perfil;
import modelo.PerfilDAO;

@WebServlet(name = "ControladorAsignarTarea", urlPatterns = {"/ControladorAsignarTarea"})
public class ControladorAsignarTarea extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            listarAsignaciones(request, response);
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            eliminarAsignacion(id);
            response.sendRedirect("ControladorAsignarTarea?accion=listar");
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if ("asignar".equals(accion)) {
            int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
            int idTarea = Integer.parseInt(request.getParameter("id_tarea"));
            
            boolean resultado = asignarTareaAPerfil(idPerfil, idTarea);
            response.getWriter().write("{\"success\":" + resultado + "}");
            
        } else if ("eliminarTodas".equals(accion)) {
            int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
            boolean resultado = eliminarTodasAsignaciones(idPerfil);
            response.getWriter().write("{\"success\":" + resultado + "}");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }
    
    private void listarAsignaciones(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PerfilDAO perfilDAO = new PerfilDAO();
        List<Perfil> perfiles = perfilDAO.listar();
        
        List<Map<String, Object>> tareas = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement(
                "SELECT * FROM tareas ORDER BY fecha_entrega ASC"
            );
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> tarea = new HashMap<>();
                tarea.put("id_tarea", rs.getInt("id_tarea"));
                tarea.put("nombre_tarea", rs.getString("nombre_tarea"));
                tarea.put("descripcion", rs.getString("descripcion"));
                tarea.put("fecha_entrega", rs.getDate("fecha_entrega"));
                tareas.add(tarea);
            }
            rs.close();
            pstmt.close();
            
            Map<String, Boolean> asignaciones = new HashMap<>();
            pstmt = conn.prepareStatement(
                "SELECT id_perfil, id_tarea FROM tareas_perfil"
            );
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String key = rs.getInt("id_perfil") + "_" + rs.getInt("id_tarea");
                asignaciones.put(key, true);
            }
            rs.close();
            pstmt.close();
            conn.close();
            
            request.setAttribute("perfiles", perfiles);
            request.setAttribute("tareas", tareas);
            request.setAttribute("asignaciones", asignaciones);
            request.getRequestDispatcher("asignarTareas.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    
    private boolean asignarTareaAPerfil(int idPerfil, int idTarea) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            
            pstmt = conn.prepareStatement(
                "SELECT * FROM tareas_perfil WHERE id_perfil = ? AND id_tarea = ?"
            );
            pstmt.setInt(1, idPerfil);
            pstmt.setInt(2, idTarea);
            ResultSet rs = pstmt.executeQuery();
            
            if (!rs.next()) {
                rs.close();
                pstmt.close();
                
                pstmt = conn.prepareStatement(
                    "INSERT INTO tareas_perfil (id_perfil, id_tarea) VALUES (?, ?)"
                );
                pstmt.setInt(1, idPerfil);
                pstmt.setInt(2, idTarea);
                int resultado = pstmt.executeUpdate();
                ok = (resultado > 0);
            } else {
                rs.close();
                ok = true;
            }
            
            pstmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    private boolean eliminarTodasAsignaciones(int idPerfil) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement("DELETE FROM tareas_perfil WHERE id_perfil = ?");
            pstmt.setInt(1, idPerfil);
            int resultado = pstmt.executeUpdate();
            ok = (resultado >= 0);
            pstmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return ok;
    }
    
    private void eliminarAsignacion(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement("DELETE FROM tareas_perfil WHERE id_asignacion = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}