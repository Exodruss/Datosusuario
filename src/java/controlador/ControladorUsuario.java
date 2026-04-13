package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "ControladorUsuario", urlPatterns = {"/ControladorUsuario"})
public class ControladorUsuario extends HttpServlet {

    UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("listar".equals(accion)) {
            request.setAttribute("lista", dao.listar());
            request.getRequestDispatcher("listarUsuarios.jsp").forward(request, response);
            
        } else if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);
            response.sendRedirect("ControladorUsuario?accion=listar");
            
        } else if ("activar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.activarDesactivar(id, 1);
            response.sendRedirect("ControladorUsuario?accion=listar");
            
        } else if ("desactivar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.activarDesactivar(id, 0);
            response.sendRedirect("ControladorUsuario?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("registrar".equals(accion)) {
            Usuario u = new Usuario();
            u.setNumDocu(request.getParameter("num_docu"));
            u.setNombre(request.getParameter("nombre"));
            u.setApellido(request.getParameter("apellido"));
            u.setEmail(request.getParameter("email"));
            u.setUsuario(request.getParameter("usuario"));
            u.setClave(request.getParameter("clave"));
            u.setIdPerfil(Integer.parseInt(request.getParameter("id_perfil")));
            dao.insertar(u);
            response.sendRedirect("ControladorUsuario?accion=listar");
            
        } else if ("editar".equals(accion)) {
            Usuario u = new Usuario();
            u.setIdusu(Integer.parseInt(request.getParameter("idusu")));
            u.setNumDocu(request.getParameter("num_docu"));
            u.setNombre(request.getParameter("nombre"));
            u.setApellido(request.getParameter("apellido"));
            u.setEmail(request.getParameter("email"));
            u.setUsuario(request.getParameter("usuario"));
            u.setClave(request.getParameter("clave"));
            u.setIdPerfil(Integer.parseInt(request.getParameter("id_perfil")));
            dao.actualizar(u);
            response.sendRedirect("ControladorUsuario?accion=listar");
            
        } else {
            response.sendRedirect("cpanel.jsp");
        }
    }
}