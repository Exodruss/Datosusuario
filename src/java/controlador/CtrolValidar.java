package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo.LoginDAO;
import modelo.Usuario;

@WebServlet(name = "CtrolValidar", urlPatterns = {"/ctrolValidar"})
public class CtrolValidar extends HttpServlet {

    LoginDAO logindao = new LoginDAO();
    Usuario datos = new Usuario();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null && accion.equalsIgnoreCase("Ingresar")) {

            String usu = request.getParameter("cusuario");
            String cla = request.getParameter("cclave");

            datos = logindao.Login_datos(usu, cla);

            if (datos != null && datos.getUsuario() != null) {

                // Guardar datos en sesión
                HttpSession sesion_cli = request.getSession(true);
                sesion_cli.setAttribute("nUsuario", usu);
                sesion_cli.setAttribute("datosUsuario", datos);
                sesion_cli.setAttribute("idPerfil", datos.getIdPerfil());

                request.setAttribute("datos", datos);
                
                // Redirigir según el perfil
                if (datos.getIdPerfil() == 1) {
                    request.getRequestDispatcher("cpanel.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("front.jsp").forward(request, response);
                }

            } else {
                // Credenciales incorrectas o usuario desactivado
                request.setAttribute("error", "Usuario o contraseña incorrectos, o usuario desactivado.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de validación de login";
    }
}