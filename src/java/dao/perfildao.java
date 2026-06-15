package dao;

import conexion.conexioncora_bd;
import modelo.usuarios;
import java.sql.*;

public class perfildao {
    private Connection cn;
    private CallableStatement cs; 
    private ResultSet rs;

    public usuarios obtenerPerfil(int id) {
        usuarios usu = null;
        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall("{call sp_obtener_perfil(?)}");
            cs.setInt(1, id);
            rs = cs.executeQuery();
            if (rs.next()) {
                usu = new usuarios();
                usu.setIdUsuario(rs.getInt("id_usuario"));
                usu.setNombreusuario(rs.getString("nombreusuario"));
                usu.setNombrecompleto(rs.getString("nombre_completo"));
                usu.setDni(rs.getString("dni"));
                usu.setCorreo(rs.getString("correo"));
                usu.setTelefono(rs.getString("telefono"));
                usu.setImagen(rs.getString("imagen"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return usu;
    }

    public boolean actualizarPerfil(int id, String nomUsu, String nombre, String correo, String tel, String pass, String imagen) {
        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall("{call sp_actualizar_perfil(?,?,?,?,?,?,?)}");
            cs.setInt(1, id);
            cs.setString(2, nomUsu);
            cs.setString(3, nombre);
            cs.setString(4, correo);
            cs.setString(5, tel);
            cs.setString(6, (pass != null && !pass.trim().isEmpty()) ? pass : null);
            cs.setString(7, imagen);
            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }
    public boolean existeUsuario(String nomUsu, int idActual) {
        boolean existe = false;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE nombreusuario = ? AND id_usuario != ?";

        try {
            cn = conexioncora_bd.probarConexion();
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, nomUsu);
            ps.setInt(2, idActual);

            rs = ps.executeQuery();
            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return existe;
    }
    private void cerrarRecursos() {
        try {
            if (rs != null) rs.close();
            if (cs != null) cs.close(); 
            if (cn != null) cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
   
}
