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

@WebServlet(name = "ControladorTarea", urlPatterns = {"/ControladorTarea"})
public class ControladorTarea extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            listarTareas(request, response);
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            eliminarTarea(id);
            response.sendRedirect("ControladorTarea?accion=listar");
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nombre_tarea");
            String descripcion = request.getParameter("descripcion");
            String fechaEntrega = request.getParameter("fecha_entrega");
            
            registrarTarea(nombre, descripcion, fechaEntrega);
            response.sendRedirect("ControladorTarea?accion=listar");
            
        } else if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id_tarea"));
            String nombre = request.getParameter("nombre_tarea");
            String descripcion = request.getParameter("descripcion");
            String fechaEntrega = request.getParameter("fecha_entrega");
            
            actualizarTarea(id, nombre, descripcion, fechaEntrega);
            response.sendRedirect("ControladorTarea?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }
    
    private void listarTareas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                tarea.put("estado", rs.getString("estado"));
                tareas.add(tarea);
            }
            request.setAttribute("tareas", tareas);
            request.getRequestDispatcher("listarTareas.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    
    private void registrarTarea(String nombre, String descripcion, String fechaEntrega) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement(
                "INSERT INTO tareas (nombre_tarea, descripcion, fecha_entrega) VALUES (?, ?, ?)"
            );
            pstmt.setString(1, nombre);
            pstmt.setString(2, descripcion);
            pstmt.setDate(3, Date.valueOf(fechaEntrega));
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    
    private void actualizarTarea(int id, String nombre, String descripcion, String fechaEntrega) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement(
                "UPDATE tareas SET nombre_tarea=?, descripcion=?, fecha_entrega=? WHERE id_tarea=?"
            );
            pstmt.setString(1, nombre);
            pstmt.setString(2, descripcion);
            pstmt.setDate(3, Date.valueOf(fechaEntrega));
            pstmt.setInt(4, id);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    
    private void eliminarTarea(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();
            pstmt = conn.prepareStatement("DELETE FROM tareas WHERE id_tarea = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
