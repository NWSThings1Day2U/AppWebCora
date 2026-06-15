/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author USUARIO
 */
public class ItemCarrito {
    private int idVariante;
    private int idProducto;

    private String nombre;
    private String imagen;

    private String color;
    private String talla;

    private double precio;
    private String categoria;
    private int cantidad;

    public double getSubtotal() {
        return precio * cantidad;
    }

    public ItemCarrito() {
    }

    public ItemCarrito(int idVariante, int idProducto, String nombre, String imagen, String color, String talla, double precio, String categoria, int cantidad) {
        this.idVariante = idVariante;
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.imagen = imagen;
        this.color = color;
        this.talla = talla;
        this.precio = precio;
        this.categoria = categoria;
        this.cantidad = cantidad;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

   

    public int getIdVariante() {
        return idVariante;
    }

    public void setIdVariante(int idVariante) {
        this.idVariante = idVariante;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
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

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
}
