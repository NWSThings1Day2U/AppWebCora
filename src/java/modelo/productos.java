
package modelo;

/**
 *
 * @author USUARIO
 */
public class productos {
    // Datos de la tabla productos
    private int id_producto;
    private int id_categoria;
    private String nombre_producto;
    private String imagen;
    private String descripcion;
    private int stock_min;
    private double descuento;
    private int estado;
    private String nombre_categoria;

    // Datos de la variante
    private int id_variante;
    private String color;
    private String talla;
    private int stock;
    private double precio;

    public productos() {
    }

    public productos(int id_producto, int id_variante, String nombre_producto, String nombre_categoria, String imagen, String descripcion, double precio, int stock_min, double descuento, int estado, String color, String talla, int id_categoria, int stock) {
        this.id_producto = id_producto;
        this.id_variante = id_variante;
        this.nombre_producto = nombre_producto;
        this.nombre_categoria = nombre_categoria;
        this.imagen = imagen;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock_min = stock_min;
        this.descuento = descuento;
        this.estado = estado;
        this.color = color;
        this.talla = talla;
        this.id_categoria = id_categoria;
        this.stock = stock;
    }

    public productos(int id_producto,int id_variante, String nombre_producto, String nombre_categoria, String imagen, String descripcion, double precio, int stock_min, double descuento, int estado, String color, String talla, int stock) {
        this.id_producto = id_producto;
        this.id_variante = id_variante;
        this.nombre_producto = nombre_producto;
        this.nombre_categoria = nombre_categoria;
        this.imagen = imagen;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock_min = stock_min;
        this.descuento = descuento;
        this.estado = estado;
        this.color = color;
        this.talla = talla;
        this.stock = stock;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public int getId_variante() {
        return id_variante;
    }

    public void setId_variante(int id_variante) {
        this.id_variante = id_variante;
    }

    
    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public String getNombre_producto() {
        return nombre_producto;
    }

    public void setNombre_producto(String nombre_producto) {
        this.nombre_producto = nombre_producto;
    }

    public String getNombre_categoria() {
        return nombre_categoria;
    }

    public void setNombre_categoria(String nombre_categoria) {
        this.nombre_categoria = nombre_categoria;
    }

    
    public String getNombre() {
        return nombre_producto;
    }

    public void setNombre(String nombre) {
        this.nombre_producto = nombre;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getStock_min() {
        return stock_min;
    }

    public void setStock_min(int stock_min) {
        this.stock_min = stock_min;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getTalla() {
        return talla;
    }

    public void setTalla(String talla) {
        this.talla = talla;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setId_categoria(int idCategoria) {
        this.id_categoria=idCategoria;
    }
    
    

    
    
}
