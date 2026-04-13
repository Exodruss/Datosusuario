package modelo;

public class Actividad {

    private int    idActividad;
    private String nomActividad;
    private String enlace;

    public Actividad() {}

    // ---- Getters ----
    public int    getIdActividad()  { return idActividad; }
    public String getNomActividad() { return nomActividad; }
    public String getEnlace()       { return enlace; }

    // ---- Setters ----
    public void setIdActividad(int idActividad)      { this.idActividad = idActividad; }
    public void setNomActividad(String nomActividad) { this.nomActividad = nomActividad; }
    public void setEnlace(String enlace)             { this.enlace = enlace; }
}
