package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.Perfil;
import modelo.PerfilDAO;

@WebServlet(name = "ControladorPerfil", urlPatterns = {"/ControladorPerfil"})
public class ControladorPerfil extends HttpServlet {

    PerfilDAO dao = new PerfilDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            request.setAttribute("lista", dao.listar());
            request.getRequestDispatcher("listarPerfiles.jsp").forward(request, response);
            
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("ControladorPerfil?accion=listar");
            
        } else if ("activar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.activarDesactivar(id, 1);
            response.sendRedirect("ControladorPerfil?accion=listar");
            
        } else if ("desactivar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.activarDesactivar(id, 0);
            response.sendRedirect("ControladorPerfil?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("registrar".equals(accion)) {
            String nombrePerfil = request.getParameter("perfil");
            if (nombrePerfil != null && !nombrePerfil.trim().isEmpty()) {
                Perfil p = new Perfil();
                p.setPerfil(nombrePerfil);
                dao.insertar(p);
            }
            response.sendRedirect("ControladorPerfil?accion=listar");
            
        } else if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id_perfil"));
            String nombrePerfil = request.getParameter("perfil");
            if (nombrePerfil != null && !nombrePerfil.trim().isEmpty()) {
                Perfil p = new Perfil();
                p.setIdPerfil(id);
                p.setPerfil(nombrePerfil);
                dao.actualizar(p);
            }
            response.sendRedirect("ControladorPerfil?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }
}