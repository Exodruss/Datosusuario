package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.GesActividad;
import modelo.GesActividadDAO;

@WebServlet(name = "ControladorGesActividad", urlPatterns = {"/ControladorGesActividad"})
public class ControladorGesActividad extends HttpServlet {

    GesActividadDAO dao = new GesActividadDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("asignarActividades.jsp");
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("asignar".equals(accion)) {
            int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
            int idActividad = Integer.parseInt(request.getParameter("id_actividad"));
            
            // Verificar si ya existe para evitar duplicados
            if (!dao.existeAsignacion(idPerfil, idActividad)) {
                GesActividad g = new GesActividad();
                g.setIdPerfil(idPerfil);
                g.setIdActividad(idActividad);
                dao.insertar(g);
            }
            
        } else if ("eliminarPorPerfilActividad".equals(accion)) {
            int idPerfil = Integer.parseInt(request.getParameter("id_perfil"));
            int idActividad = Integer.parseInt(request.getParameter("id_actividad"));
            dao.eliminarPorPerfilActividad(idPerfil, idActividad);
        }
        
        response.setContentType("application/json");
        response.getWriter().write("{\"success\":true}");
    }
}