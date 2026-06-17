
package modelo;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author USUARIO
 */
public class pedido {
    //atributos de tabla pedidos
    private int id_pedido;
    private int id_usuario;
    private String nombreCompleto;
    private String telefono;
    private String correo;
    private String fecha_pedido;
    private String tipo_entrega;
    private double costo_delivery;
    private String direccion;
    private String metodo_pago;
    private String estado;
    private Date fechaEntregaMin;
    private Date fechaEntregaMax;
    private List<detallepedido> detalles;

    public pedido() {
    }

    public pedido(int id_pedido, int id_usuario, String nombreCompleto, String fecha_pedido, String tipo_entrega, double costo_delivery, String direccion, String metodo_pago, String estado, List<detallepedido> detalles) {
        this.id_pedido = id_pedido;
        this.id_usuario = id_usuario;
        this.nombreCompleto = nombreCompleto;
        this.fecha_pedido = fecha_pedido;
        this.tipo_entrega = tipo_entrega;
        this.costo_delivery = costo_delivery;
        this.direccion = direccion;
        this.metodo_pago = metodo_pago;
        this.estado = estado;
        this.detalles = detalles;
    }

    public pedido(int id_pedido, int id_usuario, String nombreCompleto, String telefono, String correo, String fecha_pedido, String tipo_entrega, double costo_delivery, String direccion, String metodo_pago, String estado, Date fechaEntregaMin, Date fechaEntregaMax, List<detallepedido> detalles) {
        this.id_pedido = id_pedido;
        this.id_usuario = id_usuario;
        this.nombreCompleto = nombreCompleto;
        this.telefono = telefono;
        this.correo = correo;
        this.fecha_pedido = fecha_pedido;
        this.tipo_entrega = tipo_entrega;
        this.costo_delivery = costo_delivery;
        this.direccion = direccion;
        this.metodo_pago = metodo_pago;
        this.estado = estado;
        this.fechaEntregaMin = fechaEntregaMin;
        this.fechaEntregaMax = fechaEntregaMax;
        this.detalles = detalles;
    }
    
    public Date getFechaEntregaMin() {
        return fechaEntregaMin;
    }

    public void setFechaEntregaMin(Date fechaEntregaMin) {
        this.fechaEntregaMin = fechaEntregaMin;
    }

    public Date getFechaEntregaMax() {
        return fechaEntregaMax;
    }

    public void setFechaEntregaMax(Date fechaEntregaMax) {
        this.fechaEntregaMax = fechaEntregaMax;
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

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }
    
    
    public List<detallepedido> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<detallepedido> detalles) {
        this.detalles = detalles;
    }

    public int getId_pedido() {
        return id_pedido;
    }

    public void setId_pedido(int id_pedido) {
        this.id_pedido = id_pedido;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getFecha_pedido() {
        return fecha_pedido;
    }

    public void setFecha_pedido(String fecha_pedido) {
        this.fecha_pedido = fecha_pedido;
    }

    public String getTipo_entrega() {
        return tipo_entrega;
    }

    public void setTipo_entrega(String tipo_entrega) {
        this.tipo_entrega = tipo_entrega;
    }

    public double getCosto_delivery() {
        return costo_delivery;
    }

    public void setCosto_delivery(double costo_delivery) {
        this.costo_delivery = costo_delivery;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getMetodo_pago() {
        return metodo_pago;
    }

    public void setMetodo_pago(String metodo_pago) {
        this.metodo_pago = metodo_pago;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
