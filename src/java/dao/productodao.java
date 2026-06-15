package dao;

import conexion.conexioncora_bd;
import java.sql.*;
import java.util.ArrayList;
import modelo.productos;

public class productodao {

    private Connection cn = null;
    private CallableStatement cs = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public void registrarproducto(productos prod) {
        String sql = "CALL sp_agregarproducto(?,?,?,?,?,?,?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, prod.getId_categoria());
            cs.setString(2, prod.getNombre());
            cs.setString(3, prod.getImagen());
            cs.setString(4, prod.getDescripcion());
            cs.setInt(5, prod.getStock_min());
            cs.setDouble(6, prod.getDescuento());
            cs.setInt(7, prod.getEstado());

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
    }

    public ArrayList<productos> listarproductos() {
        ArrayList<productos> lista = new ArrayList<>();
        String sql = "CALL sp_mostrarproductos()";
        try {
            cn = conexioncora_bd.probarConexion();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                productos p = new productos();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setImagen(rs.getString("imagen"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStock_min(rs.getInt("stock_min"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setEstado(rs.getInt("estado"));
                p.setId_categoria(rs.getInt("id_categoria"));
                p.setNombre_categoria(rs.getString("nombre_categoria"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return lista;
    }

    public void actualizarproducto(productos prod) {

        String sql = "CALL sp_editarproducto(?,?,?,?,?,?,?,?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, prod.getId_producto());
            cs.setInt(2, prod.getId_categoria());
            cs.setString(3, prod.getNombre());
            cs.setString(4, prod.getImagen());
            cs.setString(5, prod.getDescripcion());
            cs.setInt(6, prod.getStock_min());
            cs.setDouble(7, prod.getDescuento());
            cs.setInt(8, prod.getEstado());

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
    }

    public void eliminarproducto(int idProducto) throws Exception {

        String sql = "CALL sp_eliminarproducto_raiz(?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, idProducto);

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            cerrarRecursos();
        }
    }

    // Métodos adicionales para la vista de detalles
    public productos obtenerProducto(int idProducto) {
        productos p = null;
        String sql = "SELECT p.*, c.nombre AS nombre_categoria FROM productos p JOIN categorias c ON p.id_categoria = c.id_categoria WHERE p.id_producto = ?";
        try {
            cn = conexioncora_bd.probarConexion();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idProducto);
            rs = ps.executeQuery();
            if (rs.next()) {
                p = new productos();
                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setImagen(rs.getString("imagen"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStock_min(rs.getInt("stock_min"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setEstado(rs.getInt("estado"));
                p.setId_categoria(rs.getInt("id_categoria"));
                p.setNombre_categoria(rs.getString("nombre_categoria"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return p;
    }

    public ArrayList<productos> listarVariantes(int idProducto) {
        ArrayList<productos> lista = new ArrayList<>();
        String sql = "CALL sp_mostrar_variantes_producto(?)";
        try {
            cn = conexioncora_bd.probarConexion();
            ps = cn.prepareStatement(sql);
            ps.setInt(1, idProducto);
            rs = ps.executeQuery();
            while (rs.next()) {
                productos v = new productos();
                v.setId_variante(rs.getInt("id_variante"));
                v.setColor(rs.getString("color"));
                v.setTalla(rs.getString("talla"));
                v.setPrecio(rs.getDouble("precio"));
                v.setStock(rs.getInt("stock"));
                lista.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return lista;
    }

    public void registrarVariante(productos v) {

        String sql = "CALL sp_agregar_variante(?,?,?,?,?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, v.getId_producto());
            cs.setString(2, v.getColor());
            cs.setString(3, v.getTalla());
            cs.setInt(4, v.getStock());
            cs.setDouble(5, v.getPrecio());

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
    }

    public void actualizarVariante(productos v) {

        String sql = "CALL sp_editar_variante(?,?,?,?,?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, v.getId_variante());
            cs.setString(2, v.getColor());
            cs.setString(3, v.getTalla());
            cs.setInt(4, v.getStock());
            cs.setDouble(5, v.getPrecio());

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
    }

    public void eliminarVariante(int idVariante) {

        String sql = "CALL sp_eliminar_variante(?)";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, idVariante);

            cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
    }
    
    //metodo productos para catalogo con precio relativo
    public ArrayList<productos> listarProductosCatalogo() {

        ArrayList<productos> lista = new ArrayList<>();

        String sql =
            "SELECT p.*, MIN(v.precio) precio_referencial " +
            "FROM productos p " +
            "INNER JOIN producto_variantes v " +
            "ON p.id_producto = v.id_producto " +
            "WHERE p.estado = 1 " +
            "GROUP BY p.id_producto";

        try {

            cn = conexioncora_bd.probarConexion();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while(rs.next()){

                productos p = new productos();

                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setImagen(rs.getString("imagen"));
                p.setId_categoria(rs.getInt("id_categoria"));

                p.setPrecio(rs.getDouble("precio_referencial"));

                lista.add(p);
            }

        } catch(Exception e){
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }
    public productos obtenerVariante(int idVariante){
        productos p = null;

        try{
            cn = conexioncora_bd.probarConexion();

            String sql =
                "SELECT p.id_producto,p.nombre,p.imagen," +
                "c.nombre as nombre_categoria," +
                "v.id_variante,v.color,v.talla,v.precio " +
                "FROM producto_variantes v " +
                "INNER JOIN productos p ON p.id_producto=v.id_producto " +
                "INNER JOIN categorias c ON c.id_categoria=p.id_categoria " +
                "WHERE v.id_variante=?";

            ps = cn.prepareStatement(sql);
            ps.setInt(1,idVariante);

            rs = ps.executeQuery();

            if(rs.next()){
                p = new productos();

                p.setId_producto(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setImagen(rs.getString("imagen"));
                p.setNombre_categoria(rs.getString("nombre_categoria"));
                p.setId_variante(rs.getInt("id_variante"));
                p.setColor(rs.getString("color"));
                p.setTalla(rs.getString("talla"));
                p.setPrecio(rs.getDouble("precio"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return p;
    }
    
    public ArrayList<productos> buscarProductos(String termino) {

        ArrayList<productos> lista = new ArrayList<>();

        try {

            cn = conexioncora_bd.probarConexion();
            String sql =
                "SELECT p.*, MIN(v.precio) precio_referencial, c.nombre as nombre_categoria " +
                "FROM productos p " +
                "INNER JOIN producto_variantes v " +
                "ON p.id_producto = v.id_producto " +
                "INNER JOIN categorias c ON c.id_categoria=p.id_categoria " +   
                "WHERE (p.nombre LIKE ? OR c.nombre LIKE ?) " +
                "AND p.estado = 1 " +
                "GROUP BY p.id_producto ";
            ps = cn.prepareStatement(sql);
            String parametro = "%" + termino + "%";
            ps.setString(1, parametro);
            ps.setString(2, parametro);
            rs = ps.executeQuery();

            while(rs.next()) {

                productos p = new productos();
                p.setNombre_categoria(rs.getString("nombre_categoria"));
                p.setId_producto(rs.getInt("id_producto"));
                p.setId_categoria(rs.getInt("id_categoria"));
                p.setNombre(rs.getString("nombre"));
                p.setImagen(rs.getString("imagen"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setDescuento(rs.getDouble("descuento"));
                p.setPrecio(rs.getDouble("precio_referencial"));
                lista.add(p);
            }

        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }
    private void cerrarRecursos() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (cs != null) {
                cs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (cn != null) {
                cn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
