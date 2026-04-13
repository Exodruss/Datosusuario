package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private final String URL    = "jdbc:mysql://localhost:3306/datosusuario";
    private final String USUARIO = "root";
    private final String CLAVE   = "root";         

    public Connection crearConexion() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USUARIO, CLAVE);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
        }
        return con;
    }
}
