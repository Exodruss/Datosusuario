package modelo;

public class GesActividad {

    private int idgesActividad;
    private int idPerfil;
    private int idActividad;

    public GesActividad() {}

    // ---- Getters ----
    public int getIdgesActividad() { return idgesActividad; }
    public int getIdPerfil()       { return idPerfil; }
    public int getIdActividad()    { return idActividad; }

    // ---- Setters ----
    public void setIdgesActividad(int idgesActividad) { this.idgesActividad = idgesActividad; }
    public void setIdPerfil(int idPerfil)             { this.idPerfil = idPerfil; }
    public void setIdActividad(int idActividad)       { this.idActividad = idActividad; }
}
