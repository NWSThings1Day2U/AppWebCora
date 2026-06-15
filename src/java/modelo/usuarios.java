
package modelo;

/**
 *
 * @author USUARIO
 */
public class usuarios {
    private int idUsuario;
    private String nombreusuario;
    private String dni;
    private String telefono;
    private String nombrecompleto;
    private String contrasena;
    private String rol;
    private String imagen;
    private String correo;
    private String fechaRegistro; 
    private int idrol;
    private int estadousuario;
    public usuarios() {
    }

    public usuarios(int idUsuario, String nombreusuario, String dni, String telefono, String nombrecompleto, String contrasena, String rol, String imagen, String correo, String fechaRegistro, int estadousuario) {
        this.idUsuario = idUsuario;
        this.nombreusuario = nombreusuario;
        this.dni = dni;
        this.telefono = telefono;
        this.nombrecompleto = nombrecompleto;
        this.contrasena = contrasena;
        this.rol = rol;
        this.imagen = imagen;
        this.correo = correo;
        this.fechaRegistro = fechaRegistro;
        this.estadousuario = estadousuario;
    }

    public int getIdrol() {
        return idrol;
    }

    public void setIdrol(int idrol) {
        this.idrol = idrol;
    }
    
    public int getEstadousuario() {
        return estadousuario;
    }

    public void setEstadousuario(int estadousuario) {
        this.estadousuario = estadousuario;
    }
    
    public String getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(String fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getNombrecompleto() {
        return nombrecompleto;
    }

    public void setNombrecompleto(String nombrecompleto) {
        this.nombrecompleto = nombrecompleto;
    }
    
    

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }
    
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreusuario() {
        return nombreusuario;
    }

    public void setNombreusuario(String nombreusuario) {
        this.nombreusuario = nombreusuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }
    
}
