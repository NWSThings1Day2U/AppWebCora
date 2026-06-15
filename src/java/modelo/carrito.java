
package modelo;

/**
 *
 * @author USUARIO
 */
public class carrito {
    //atributos de la tabla carrito
    private int id_carrito;
    private int id_usuario;//id de cliente logueado
    private String fecha_registro;
    
    //atributos de detalle carrito
    private int id_detalle;//id detalle de carrito
    private int id_variante;//id del producto variante seleccionado
    private int cantidad;

    public carrito() {
    }

    public carrito(int id_carrito, int id_usuario, String fecha_registro, int id_detalle, int id_variante, int cantidad) {
        this.id_carrito = id_carrito;
        this.id_usuario = id_usuario;
        this.fecha_registro = fecha_registro;
        this.id_detalle = id_detalle;
        this.id_variante = id_variante;
        this.cantidad = cantidad;
    }

    public void setId_detalle(int id_detalle) {
        this.id_detalle = id_detalle;
    }

    public int getId_detalle() {
        return id_detalle;
    }

    public int getId_carrito() {
        return id_carrito;
    }

    public void setId_carrito(int id_carrito) {
        this.id_carrito = id_carrito;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getFecha_registro() {
        return fecha_registro;
    }

    public void setFecha_registro(String fecha_registro) {
        this.fecha_registro = fecha_registro;
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
    
    
}
