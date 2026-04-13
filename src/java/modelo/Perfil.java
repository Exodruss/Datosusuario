package modelo;

public class Perfil {

    private int    idPerfil;
    private String perfil;
    private int    activo;  // 1 = activo, 0 = inactivo

    public Perfil() {}

    // ---- Getters ----
    public int    getIdPerfil() { return idPerfil; }
    public String getPerfil()   { return perfil; }
    public int    getActivo()   { return activo; }

    // ---- Setters ----
    public void setIdPerfil(int idPerfil)  { this.idPerfil = idPerfil; }
    public void setPerfil(String perfil)   { this.perfil = perfil; }
    public void setActivo(int activo)      { this.activo = activo; }
}
