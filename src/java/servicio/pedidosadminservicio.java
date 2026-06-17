package servicio;
import conexion.conexioncora_bd;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import modelo.ItemCarrito;
public class pedidosadminservicio {

    public boolean registrarPedidoAdmin(
            int idUsuario,
            String tipoEntrega,
            double costoDelivery,
            String direccion,
            String metodoPago,
            String estado,
            List<ItemCarrito> carrito) {

        Connection cn = null;

        try {
            cn = conexioncora_bd.probarConexion();
            cn.setAutoCommit(false);

            // 1. CREAR PEDIDO
            CallableStatement csPedido = cn.prepareCall("{CALL sp_crear_pedido_admin(?,?,?,?,?,?,?,?)}");

            csPedido.setInt(1, idUsuario);
            csPedido.setTimestamp(2, new java.sql.Timestamp(System.currentTimeMillis()));
            csPedido.setString(3, tipoEntrega);
            csPedido.setDouble(4, costoDelivery);
            csPedido.setString(5, direccion);
            csPedido.setString(6, metodoPago);
            csPedido.setString(7, estado);

            csPedido.registerOutParameter(8, Types.INTEGER);
            csPedido.execute();

            int idPedido = csPedido.getInt(8);
            csPedido.close();

            // 2. DETALLE + STOCK POR CADA ITEM
            for (ItemCarrito item : carrito) {

                // validar stock
                CallableStatement csValidar = cn.prepareCall("{CALL sp_validar_stock(?,?)}");
                csValidar.setInt(1, item.getIdVariante());
                csValidar.setInt(2, item.getCantidad());

                ResultSet rs = csValidar.executeQuery();

                if (rs.next() && rs.getInt("disponible") == 0) {
                    cn.rollback();
                    rs.close();
                    csValidar.close();
                    return false;
                }

                rs.close();
                csValidar.close();

                // detalle
                CallableStatement csDetalle = cn.prepareCall("{CALL sp_agregar_detalle_pedido(?,?,?)}");
                csDetalle.setInt(1, idPedido);
                csDetalle.setInt(2, item.getIdVariante());
                csDetalle.setInt(3, item.getCantidad());
                csDetalle.execute();
                csDetalle.close();

                // stock
                CallableStatement csStock = cn.prepareCall("{CALL sp_descontar_stock(?,?)}");
                csStock.setInt(1, item.getIdVariante());
                csStock.setInt(2, item.getCantidad());
                csStock.execute();
                csStock.close();
            }

            cn.commit();
            return true;

        } catch (Exception e) {
            try {
                if (cn != null) cn.rollback();
            } catch (Exception ex) {}

            e.printStackTrace();
            return false;

        } finally {
            try {
                if (cn != null) {
                    cn.setAutoCommit(true);
                    cn.close();
                }
            } catch (Exception ex) {}
        }
    }
}