
package modelo;

/**
 *
 * @author USUARIO
 */
public class pedido {
    //atributos de tabla pedidos
    private int id_pedido;
    private int id_usuario;
    private String fecha_pedido;
    private String tipo_entrega;
    private double costo_delivery;
    private String direccion;
    private String metodo_pago;
    private String estado;
    //atributos de tabla detalle pedidos
    private int id_detalle; //carrito detalle
    private int id_variante;//id variante producto
    private int cantidad;
    private double precio_unitario;

    public pedido() {
    }

    public pedido(int id_pedido, int id_usuario, String fecha_pedido, String tipo_entrega, double costo_delivery, String direccion, String metodo_pago, String estado, int id_detalle, int id_variante, int cantidad, double precio_unitario) {
        this.id_pedido = id_pedido;
        this.id_usuario = id_usuario;
        this.fecha_pedido = fecha_pedido;
        this.tipo_entrega = tipo_entrega;
        this.costo_delivery = costo_delivery;
        this.direccion = direccion;
        this.metodo_pago = metodo_pago;
        this.estado = estado;
        this.id_detalle = id_detalle;
        this.id_variante = id_variante;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
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

    public int getId_detalle() {
        return id_detalle;
    }

    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
    }

    public int getId_variante() {
        return id_variante;
    }

    public void setId_variante(int id_variante) {
        this.id_variante = id_variante;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(double precio_unitario) {
        this.precio_unitario = precio_unitario;
    }
    
    
    
}
