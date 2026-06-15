
package modelo;

/**
 *
 * @author USUARIO
 */
public class contacto {
    private int id_contacto;
    private String nombre;
    private String telefono;
    private String correo;
    private String asunto;
    private String mensaje;
    private String fecha;
    private String estado;
    private String respuesta;
    private String fecha_respuesta;
    
    public contacto(int id_contacto, String nombre, String telefono, String correo, String asunto, String mensaje, String fecha, String estado, String respuesta, String fecha_respuesta) {
        this.id_contacto = id_contacto;
        this.nombre = nombre;
        this.telefono = telefono;
        this.correo = correo;
        this.asunto = asunto;
        this.mensaje = mensaje;
        this.fecha = fecha;
        this.estado = estado;
        this.respuesta = respuesta;
        this.fecha_respuesta = fecha_respuesta;
    }
    

    public contacto() {
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public String getFecha_respuesta() {
        return fecha_respuesta;
    }

    public void setFecha_respuesta(String fecha_respuesta) {
        this.fecha_respuesta = fecha_respuesta;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getEstado() {
        return estado;
    }

    public int getId_contacto() {
        return id_contacto;
    }

    public void setId_contacto(int id_contacto) {
        this.id_contacto = id_contacto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    
            
}
