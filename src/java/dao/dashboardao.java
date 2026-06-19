
package dao;

import conexion.conexioncora_bd;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.*;

import java.sql.PreparedStatement;

/**
 *
 * @author USUARIO
 */
public class dashboardao {
    private Connection cn = null;
    private CallableStatement cs = null;
    private ResultSet rs = null;
    public double totalVentas() {
        double total = 0;
        try {
            cn = conexioncora_bd.probarConexion();
            String sql = "SELECT SUM(dp.cantidad * dp.precio_unitario) total_ventas "
                    + "FROM detalle_pedido dp "
                    + "INNER JOIN pedidos p ON dp.id_pedido=p.id_pedido "
                    + "WHERE p.estado='ENTREGADO' ";
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("total_ventas");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cerrarrecursos();
        }
        return  total;
    }
    
    public int totalPedidos() {
        int total = 0;
        try {
            cn = conexioncora_bd.probarConexion();
            String sql = "SELECT COUNT(*) as total_pedidos " +
                        "FROM pedidos";
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total_pedidos");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cerrarrecursos();
        }
        return total;
    }
    public int totalClientes() {
        int total = 0;
        try {
            cn = conexioncora_bd.probarConexion();
            String sql = "SELECT COUNT(*) as total_clientes " +
                        "FROM usuarios u " +
                        "INNER JOIN usuario_rol ur " +
                        "ON u.id_usuario=ur.id_usuario " +
                        "INNER JOIN roles r " +
                        "ON ur.id_rol=r.id_rol " +
                        "WHERE r.nombre='cliente' " ;
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total_clientes");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cerrarrecursos();
        }
        return total;
    }
    public int totalProductos() {
        int total = 0;
        try {
            cn = conexioncora_bd.probarConexion();
            String sql = "SELECT COUNT(*) as total_productos " +
                        "FROM productos " +
                        "WHERE estado=1 ";
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt("total_productos");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            cerrarrecursos();
        }
        return total;
    }
    
    public List<dashboard> obtenerVentasPorMes() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT MONTH(p.fecha_pedido) as mes, SUM(dp.cantidad * dp.precio_unitario) as ventas " +
                     "FROM pedidos p INNER JOIN detalle_pedido dp ON p.id_pedido=dp.id_pedido " +
                     "WHERE p.estado='ENTREGADO' GROUP BY MONTH(p.fecha_pedido) ORDER BY mes ";
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard v = new dashboard();
                v.setMes(rs.getInt("mes"));
                v.setVentas(rs.getDouble("ventas"));
                lista.add(v);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerEstadosPedidos() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT  estado as estado_pedido, " +
                        "COUNT(*) as cantidad_estado " +
                        "FROM pedidos " +
                        "GROUP BY estado ";
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard e = new dashboard();
                e.setEstado_pedido(rs.getString("estado_pedido"));
                e.setCantidad_estado(rs.getInt("cantidad_estado"));
                lista.add(e);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    public List<dashboard> obtenerVentasCategorias() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT c.nombre categoria, " +
                        "SUM(dp.cantidad) vendidos " +
                        "FROM detalle_pedido dp " +
                        "INNER JOIN producto_variantes pv " +
                        "ON dp.id_variante=pv.id_variante " +
                        "INNER JOIN productos p " +
                        "ON pv.id_producto=p.id_producto " +
                        "INNER JOIN categorias c " +
                        "ON p.id_categoria=c.id_categoria " +
                        "GROUP BY c.nombre " +
                        "ORDER BY vendidos DESC ";
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard e = new dashboard();
                e.setCategoria(rs.getString("categoria"));
                e.setCantidad_categoria(rs.getInt("vendidos"));
                lista.add(e);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    public List<dashboard> obtenerProductosVendidos() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT p.nombre nombreproducto, " +
                        "SUM(dp.cantidad) vendidos " +
                        "FROM detalle_pedido dp " +
                        "INNER JOIN producto_variantes pv " +
                        "ON dp.id_variante=pv.id_variante " +
                        "INNER JOIN productos p " +
                        "ON pv.id_producto=p.id_producto " +
                        "GROUP BY p.id_producto " +
                        "ORDER BY vendidos DESC " +
                        "LIMIT 10 " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard e = new dashboard();
                e.setNombreproducto(rs.getString("nombreproducto"));
                e.setVendidos(rs.getInt("vendidos"));
                lista.add(e);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerStockCritico() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT p.nombre as nombreproducto, p.stock_min as stock_min," +
                        "pv.color as color, " +
                        "pv.talla as talla, " +
                        "pv.stock as stock " +
                        "FROM producto_variantes pv " +
                        "INNER JOIN productos p " +
                        "ON pv.id_producto=p.id_producto " +
                        "WHERE pv.stock <= p.stock_min " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard s = new dashboard();
                s.setNombreproducto(rs.getString("nombreproducto"));
                s.setColor(rs.getString("color"));
                s.setTalla(rs.getString("talla"));
                s.setStock(rs.getInt("stock"));
                s.setStock_min(rs.getInt("stock_min"));
                lista.add(s);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerIngresosMPagos() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT metodo_pago, " +
                    "SUM(dp.cantidad*dp.precio_unitario) total " +
                    "FROM pedidos p " +
                    "INNER JOIN detalle_pedido dp " +
                    "ON p.id_pedido=dp.id_pedido " +
                    "GROUP BY metodo_pago  " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard i = new dashboard();
                i.setMetodo_pago(rs.getString("metodo_pago"));
                i.setIngresospago(rs.getDouble("total"));
                lista.add(i);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerCantidadTipoE() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT tipo_entrega, " +
                    "COUNT(*) as cantidadtipo " +
                    "FROM pedidos " +
                    "GROUP BY tipo_entrega " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard e = new dashboard();
                e.setTipo_entrega(rs.getString("tipo_entrega"));
                e.setCantidadtipo(rs.getInt("cantidadtipo"));
                lista.add(e);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerUltimosPedidos() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT p.id_pedido AS Id_Cliente, " +
                    "    du.nombre_completo AS cliente, " +
                    "    IF(p.fecha_entrega_min IS NULL OR p.fecha_entrega_max IS NULL,  " +
                    "       'Por definir',  " +
                    "       CONCAT(p.fecha_entrega_min, ' a ', p.fecha_entrega_max) " +
                    "    ) AS Fecha_de_Entrega_Estimada, " +
                    "    p.estado AS estado, " +
                    "    (COALESCE(dp.subtotal, 0) + COALESCE(p.costo_delivery, 0)) AS Total " +
                    "FROM pedidos p " +
                    "INNER JOIN detalle_usuario du ON p.id_usuario = du.id_usuario " +
                    "LEFT JOIN ( " +
                    "    SELECT  " +
                    "        id_pedido,  " +
                    "        SUM(cantidad * precio_unitario) AS subtotal " +
                    "    FROM detalle_pedido " +
                    "    GROUP BY id_pedido " +
                    ") dp ON p.id_pedido = dp.id_pedido " +
                    "ORDER BY p.fecha_pedido DESC " +
                    "LIMIT 5;" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setId_cliente(rs.getInt("Id_Cliente"));
                d.setCliente(rs.getString("cliente"));
                d.setFecha_estimada(rs.getString("Fecha_de_Entrega_Estimada"));
                d.setEstado_pedido(rs.getString("estado"));
                d.setTotal(rs.getDouble("total"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    } 
    
    public List<dashboard> obtenerCantidadClientes() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT SUM(CASE WHEN MONTH(fecha_creacion) = MONTH(CURRENT_DATE()) AND YEAR(fecha_creacion) = YEAR(CURRENT_DATE()) THEN 1 ELSE 0 END) AS clientes_nuevos, " +
                    "    SUM(CASE WHEN fecha_creacion < DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01') THEN 1 ELSE 0 END) AS clientes_antiguos " +
                    "FROM usuarios " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setClientes_nuevos(rs.getInt("clientes_nuevos"));
                d.setClientes_antiguos(rs.getInt("clientes_antiguos"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    } 
    
    public List<dashboard> obtenerTopClientes() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT  du.nombre_completo AS Cliente, " +
                    "    COUNT(DISTINCT p.id_pedido) AS Pedidos, " +
                    "    SUM(dp.cantidad * dp.precio_unitario) AS Total_Comprado " +
                    "FROM pedidos p " +
                    "INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido " +
                    "INNER JOIN detalle_usuario du ON p.id_usuario = du.id_usuario " +
                    "GROUP BY du.nombre_completo " +
                    "ORDER BY Total_Comprado DESC " +
                    "LIMIT 10 " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setCliente(rs.getString("Cliente"));
                d.setCantidad_pedidos(rs.getInt("Pedidos"));
                d.setTotal(rs.getDouble("Total_Comprado"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    } 
    
    public double obtenerTotalInventario() {
        double total = 0;
        String sql = "SELECT SUM(stock * precio) AS Inventario_Valorizado " +
                "FROM producto_variantes " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                total =rs.getDouble("Inventario_Valorizado");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return total;
    } 
    public List<dashboard> obtenerTallaVendidas() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT pv.talla as talla,  SUM(dp.cantidad) AS Total_Vendido " +
                    "FROM detalle_pedido dp " +
                    "INNER JOIN producto_variantes pv " +
                    "    ON dp.id_variante = pv.id_variante " +
                    "GROUP BY pv.talla " +
                    "ORDER BY Total_Vendido DESC " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setTalla(rs.getString("talla"));
                d.setTotal(rs.getDouble("Total_Vendido"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    } 
    public List<dashboard> obtenerColoresVendidos() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT pv.color as color, SUM(dp.cantidad) AS Total_Vendido " +
                    "FROM detalle_pedido dp " +
                    "INNER JOIN producto_variantes pv " +
                    "    ON dp.id_variante = pv.id_variante " +
                    "GROUP BY pv.color " +
                    "ORDER BY Total_Vendido DESC;" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setColor(rs.getString("color"));
                d.setTotal(rs.getDouble("Total_Vendido"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerPedidosDia() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT DATE(fecha_pedido) AS Fecha, " +
                        "    COUNT(*) AS Pedidos " +
                        "FROM pedidos " +
                        "GROUP BY DATE(fecha_pedido) " +
                        "ORDER BY Fecha " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setFecha_estimada(rs.getString("Fecha"));
                d.setCantidad_pedidos(rs.getInt("Pedidos"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerBajaRotacion() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT pr.nombre as nombreproducto, " +
                    "    COALESCE(SUM(dp.cantidad),0) AS Total_Vendido " +
                    "FROM productos pr " +
                    "LEFT JOIN producto_variantes pv " +
                    "    ON pr.id_producto = pv.id_producto " +
                    "LEFT JOIN detalle_pedido dp " +
                    "    ON pv.id_variante = dp.id_variante " +
                    "GROUP BY pr.id_producto " +
                    "ORDER BY Total_Vendido ASC " +
                    "LIMIT 10;" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setNombreproducto(rs.getString("nombreproducto"));
                d.setTotal(rs.getDouble("Total_Vendido"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public List<dashboard> obtenerCategoriaRentable() {
        List<dashboard> lista = new ArrayList<>();
        String sql = "SELECT c.nombre AS Categoria, " +
                    "    SUM(dp.cantidad * dp.precio_unitario) AS Ingresos " +
                    "FROM categorias c " +
                    "INNER JOIN productos pr " +
                    "    ON c.id_categoria = pr.id_categoria " +
                    "INNER JOIN producto_variantes pv " +
                    "    ON pr.id_producto = pv.id_producto " +
                    "INNER JOIN detalle_pedido dp " +
                    "    ON pv.id_variante = dp.id_variante " +
                    "GROUP BY c.id_categoria " +
                    "ORDER BY Ingresos DESC " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                dashboard d = new dashboard();
                d.setCategoria(rs.getString("Categoria"));
                d.setTotal(rs.getDouble("Ingresos"));
                lista.add(d);
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return lista;
    }
    
    public int obtenerMensajesPendientes() {
        int total = 0;
        String sql = "SELECT COUNT(*) as mensajespendientes " +
                        "FROM contacto " +
                        "WHERE estado='Pendiente';" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                total =rs.getInt("mensajespendientes");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return total;
    } 
    
    public int obtenerMensajesRespondidas() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS Mensajes_Respondidos " +
                    "FROM contacto " +
                    "WHERE estado='Respondido';" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                total =rs.getInt("Mensajes_Respondidos");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return total;
    } 
    public String obtenerTiempoRespuesta() {
        String Horas_Promedio = "";
        String sql = "SELECT ROUND(AVG( TIMESTAMPDIFF( HOUR, fecha,fecha_respuesta ) ),  2) AS Horas_Promedio " +
                    "FROM contacto " +
                    "WHERE fecha_respuesta IS NOT NULL;" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Horas_Promedio =rs.getString("Horas_Promedio");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return Horas_Promedio;
    } 
    
    public double obtenerVentasMes() {
        double Monto =0;
        String sql = "SELECT  SUM(dp.cantidad * dp.precio_unitario) AS Ventas_Mes " +
                    "FROM pedidos p " +
                    "INNER JOIN detalle_pedido dp " +
                    "    ON p.id_pedido = dp.id_pedido " +
                    "WHERE MONTH(p.fecha_pedido)=MONTH(CURDATE()) " +
                    "AND YEAR(p.fecha_pedido)=YEAR(CURDATE());" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Monto =rs.getDouble("Ventas_Mes");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return Monto;
    } 
    
    public double obtenerTicketPromedio() {
        double Monto =0;
        String sql = "SELECT  ROUND( AVG(TotalPedido), 2) AS Ticket_Promedio " +
                    "FROM " +
                    "( SELECT  p.id_pedido,  SUM(dp.cantidad * dp.precio_unitario) AS TotalPedido " +
                    "    FROM pedidos p " +
                    "    INNER JOIN detalle_pedido dp " +
                    "        ON p.id_pedido=dp.id_pedido " +
                    "    GROUP BY p.id_pedido " +
                    ") t;" ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Monto =rs.getDouble("Ticket_Promedio");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return Monto;
    } 
     public double obtenerPorcentajeEntregado() {
        double porcentaje =0;
        String sql = "SELECT  ROUND( " +
                    "        (SUM(CASE WHEN estado = 'entregado' THEN 1 ELSE 0 END) * 100.0) " +
                    "        / COUNT(*), " +
                    "    2) AS Porcentaje_Entregados  " +
                    "FROM pedidos; " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                porcentaje =rs.getDouble("Porcentaje_Entregados");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return porcentaje;
    } 
     
     public int obtenerProductosCriticos() {
        int contar =0;
        String sql = "SELECT COUNT(*) AS Productos_Criticos " +
                    "FROM productos p " +
                    "INNER JOIN producto_variantes pv " +
                    "    ON p.id_producto = pv.id_producto " +
                    "WHERE pv.stock <= p.stock_min; " ;
        try {
            cn = conexioncora_bd.probarConexion();

            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                contar =rs.getInt("Productos_Criticos");
                
            }
        } catch (Exception e) {
                e.printStackTrace();
            }finally {
                cerrarrecursos();
            }   
        return contar;
    } 
    
    public double obtenerCrecimientoVentas() {
        double crecimiento = 0;

        String sql = "SELECT COALESCE(ROUND(((v.actual - v.anterior) / NULLIF(v.anterior, 0)) * 100, 2), 0) AS crecimiento " +
        "FROM (SELECT  " +
        "        SUM(CASE WHEN p.fecha_pedido >= DATE_FORMAT(CURDATE(), '%Y-%m-01') AND p.fecha_pedido < DATE_ADD(DATE_FORMAT(CURDATE(), '%Y-%m-01'), INTERVAL 1 MONTH) THEN dp.cantidad * dp.precio_unitario ELSE 0 END) AS actual, " +
        "        SUM(CASE WHEN p.fecha_pedido >= DATE_SUB(DATE_FORMAT(CURDATE(), '%Y-%m-01'), INTERVAL 1 MONTH) AND p.fecha_pedido < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN dp.cantidad * dp.precio_unitario ELSE 0 END) AS anterior " +
        "    FROM pedidos p INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido " +
        ") v;";

        try {
            cn = conexioncora_bd.probarConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            if(rs.next()){
                crecimiento = rs.getDouble("crecimiento");
            }

        } catch(Exception e){
            e.printStackTrace();
        } finally{
            cerrarrecursos();
        }

        return crecimiento;
    } 
    
    
    public List<dashboard> obtenerTop4ProductosInicio() {

        List<dashboard> lista = new ArrayList<>();

        String sql =
            "SELECT p.id_producto, " +
            "       p.nombre AS nombreproducto, " +
            "       p.imagen, " +
            "       c.nombre AS categoria, " +
            "       MIN(pv.precio) AS precio, " +
            "       SUM(dp.cantidad) AS vendidos " +
            "FROM productos p " +
            "INNER JOIN categorias c ON p.id_categoria = c.id_categoria " +
            "INNER JOIN producto_variantes pv ON p.id_producto = pv.id_producto " +
            "INNER JOIN detalle_pedido dp ON pv.id_variante = dp.id_variante " +
            "INNER JOIN pedidos pe ON dp.id_pedido = pe.id_pedido " +
            "WHERE YEARWEEK(pe.fecha_pedido, 1) = YEARWEEK(CURDATE(), 1) " +
            "AND pe.estado = 'ENTREGADO' " +
            "GROUP BY p.id_producto, p.nombre, p.imagen, c.nombre " +
            "ORDER BY vendidos DESC " +
            "LIMIT 4";

        try {

            cn = conexioncora_bd.probarConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {

                dashboard d = new dashboard();

                d.setId_producto(rs.getInt("id_producto"));
                d.setNombreproducto(rs.getString("nombreproducto"));
                d.setImagen(rs.getString("imagen"));
                d.setCategoria(rs.getString("categoria"));
                d.setPrecio(rs.getDouble("precio"));
                d.setVendidos(rs.getInt("vendidos"));

                lista.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarrecursos();
        }

        return lista;
    }
     
    private void cerrarrecursos() {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (cs != null) cs.close(); } catch (Exception e) {}
        try { if (cn != null) {
            cn.setAutoCommit(true); 
            cn.close(); 
        }} catch (Exception e) {}
    }
}
