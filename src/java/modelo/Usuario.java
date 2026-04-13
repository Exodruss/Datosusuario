package modelo;

public class Usuario {

    private int    idusu;
    private String numDocu;
    private String nombre;
    private String apellido;
    private String email;
    private String usuario;
    private String clave;
    private int    idPerfil;
    private int    activo;  // 1 = activo, 0 = inactivo

    public Usuario() {}

    // ---- Getters ----
    public int    getIdusu()    { return idusu; }
    public String getNumDocu()  { return numDocu; }
    public String getNombre()   { return nombre; }
    public String getApellido() { return apellido; }
    public String getEmail()    { return email; }
    public String getUsuario()  { return usuario; }
    public String getClave()    { return clave; }
    public int    getIdPerfil() { return idPerfil; }
    public int    getActivo()   { return activo; }

    // ---- Setters ----
    public void setIdusu(int idusu)          { this.idusu = idusu; }
    public void setNumDocu(String numDocu)   { this.numDocu = numDocu; }
    public void setNombre(String nombre)     { this.nombre = nombre; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    public void setEmail(String email)       { this.email = email; }
    public void setUsuario(String usuario)   { this.usuario = usuario; }
    public void setClave(String clave)       { this.clave = clave; }
    public void setIdPerfil(int idPerfil)    { this.idPerfil = idPerfil; }
    public void setActivo(int activo)        { this.activo = activo; }
}