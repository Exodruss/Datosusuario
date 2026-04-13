package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.Actividad;
import modelo.ActividadDAO;

@WebServlet(name = "ControladorActividad", urlPatterns = {"/ControladorActividad"})
public class ControladorActividad extends HttpServlet {

    ActividadDAO dao = new ActividadDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            request.setAttribute("lista", dao.listar());
            request.getRequestDispatcher("listarActividades.jsp").forward(request, response);
            
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("ControladorActividad?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nom_actividad");
            String enlace = request.getParameter("enlace");
            if (nombre != null && !nombre.trim().isEmpty()) {
                Actividad a = new Actividad();
                a.setNomActividad(nombre);
                a.setEnlace(enlace);
                dao.insertar(a);
            }
            response.sendRedirect("ControladorActividad?accion=listar");
            
        } else if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id_actividad"));
            String nombre = request.getParameter("nom_actividad");
            String enlace = request.getParameter("enlace");
            if (nombre != null && !nombre.trim().isEmpty()) {
                Actividad a = new Actividad();
                a.setIdActividad(id);
                a.setNomActividad(nombre);
                a.setEnlace(enlace);
                dao.actualizar(a);
            }
            response.sendRedirect("ControladorActividad?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }
}