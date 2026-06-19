
package modelo;

/**
 *
 * @author USUARIO
 */
public class dashboard {
    private int mes;
    private double ventas;
    private String estado_pedido;
    private int cantidad_estado;
    private int cantidad_categoria;
    private int cantidad_pedidos;
    private String categoria;
    private String nombreproducto;
    private int vendidos;
    private String color;
    private String talla;
    private int stock;
    private int stock_min;
    private String metodo_pago;
    private double ingresospago;
    private String tipo_entrega;
    private int cantidadtipo;
    private int clientes_nuevos;
    private int clientes_antiguos;
    private int id_cliente;
    private String cliente;
    private String fecha_estimada;
    private double total;
    public dashboard() {
    }

    public dashboard(int mes, double ventas, String estado_pedido, int cantidad_estado, int cantidad_categoria, int cantidad_pedidos, String categoria, String nombreproducto, int vendidos, String color, String talla, int stock, int stock_min, String metodo_pago, double ingresospago, String tipo_entrega, int cantidadtipo, int clientes_nuevos, int clientes_antiguos, int id_cliente, String cliente, String fecha_estimada, double total) {
        this.mes = mes;
        this.ventas = ventas;
        this.estado_pedido = estado_pedido;
        this.cantidad_estado = cantidad_estado;
        this.cantidad_categoria = cantidad_categoria;
        this.cantidad_pedidos = cantidad_pedidos;
        this.categoria = categoria;
        this.nombreproducto = nombreproducto;
        this.vendidos = vendidos;
        this.color = color;
        this.talla = talla;
        this.stock = stock;
        this.stock_min = stock_min;
        this.metodo_pago = metodo_pago;
        this.ingresospago = ingresospago;
        this.tipo_entrega = tipo_entrega;
        this.cantidadtipo = cantidadtipo;
        this.clientes_nuevos = clientes_nuevos;
        this.clientes_antiguos = clientes_antiguos;
        this.id_cliente = id_cliente;
        this.cliente = cliente;
        this.fecha_estimada = fecha_estimada;
        this.total = total;
    }

    public int getCantidad_pedidos() {
        return cantidad_pedidos;
    }

    public void setCantidad_pedidos(int cantidad_pedidos) {
        this.cantidad_pedidos = cantidad_pedidos;
    }
    
    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getCliente() {
        return cliente;
    }

    public void setCliente(String cliente) {
        this.cliente = cliente;
    }

    public String getFecha_estimada() {
        return fecha_estimada;
    }

    public void setFecha_estimada(String fecha_estimada) {
        this.fecha_estimada = fecha_estimada;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

   

    

    public String getTipo_entrega() {
        return tipo_entrega;
    }

    public void setTipo_entrega(String tipo_entrega) {
        this.tipo_entrega = tipo_entrega;
    }

    public int getCantidadtipo() {
        return cantidadtipo;
    }

    public void setCantidadtipo(int cantidadtipo) {
        this.cantidadtipo = cantidadtipo;
    }


    public int getClientes_nuevos() {
        return clientes_nuevos;
    }

    public void setClientes_nuevos(int clientes_nuevos) {
        this.clientes_nuevos = clientes_nuevos;
    }

    public int getClientes_antiguos() {
        return clientes_antiguos;
    }

    public void setClientes_antiguos(int clientes_antiguos) {
        this.clientes_antiguos = clientes_antiguos;
    }
    
    
    
    public String getMetodo_pago() {
        return metodo_pago;
    }

    public void setMetodo_pago(String metodo_pago) {
        this.metodo_pago = metodo_pago;
    }

    public double getIngresospago() {
        return ingresospago;
    }

    public void setIngresospago(double ingresospago) {
        this.ingresospago = ingresospago;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getStock_min() {
        return stock_min;
    }

    public void setStock_min(int stock_min) {
        this.stock_min = stock_min;
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

    
    public String getNombreproducto() {
        return nombreproducto;
    }

    public void setNombreproducto(String nombreproducto) {
        this.nombreproducto = nombreproducto;
    }

    public int getVendidos() {
        return vendidos;
    }

    public void setVendidos(int vendidos) {
        this.vendidos = vendidos;
    }
    
    public int getCantidad_categoria() {
        return cantidad_categoria;
    }

    public void setCantidad_categoria(int cantidad_categoria) {
        this.cantidad_categoria = cantidad_categoria;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    
    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    public double getVentas() {
        return ventas;
    }

    public void setVentas(double ventas) {
        this.ventas = ventas;
    }

    public String getEstado_pedido() {
        return estado_pedido;
    }

    public void setEstado_pedido(String estado_pedido) {
        this.estado_pedido = estado_pedido;
    }

    public int getCantidad_estado() {
        return cantidad_estado;
    }

    public void setCantidad_estado(int cantidad_estado) {
        this.cantidad_estado = cantidad_estado;
    }

    
    
}
