package dao;

import conexion.conexioncora_bd;
import modelo.contacto;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author USUARIO
 */
public class contactodao {

    private Connection cn;
    private CallableStatement cs;
    private ResultSet rs;

    public ArrayList<contacto> listarcontactos() {
        ArrayList<contacto> lista = new ArrayList<>();
        String sql = "CALL sp_mostrarcontacto()";
        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);
            rs = cs.executeQuery();

            while (rs.next()) {
                contacto c = new contacto();
                c.setId_contacto(rs.getInt("id_contacto"));
                c.setNombre(rs.getString("nombre"));
                c.setTelefono(rs.getString("telefono"));
                c.setCorreo(rs.getString("correo"));
                c.setAsunto(rs.getString("asunto"));
                c.setMensaje(rs.getString("mensaje"));
                c.setFecha(rs.getString("fecha"));
                c.setEstado(rs.getString("estado"));
                c.setRespuesta(rs.getString("respuesta"));
                c.setFecha_respuesta(rs.getString("fecha_respuesta"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return lista;
    }

    public boolean responderContacto(
            int idContacto,
            String respuesta) {

        boolean resultado = false;

        try {

            cn = conexioncora_bd.probarConexion();

            cs = cn.prepareCall(
                    "{CALL sp_respondercontacto(?,?)}"
            );

            cs.setInt(1, idContacto);
            cs.setString(2, respuesta);

            resultado = cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return resultado;
    }

    private void cerrarRecursos() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (cs != null) {
                cs.close();
            }
            if (cn != null) {
                cn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
