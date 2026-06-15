package dao;

import conexion.conexioncora_bd;
import modelo.usuarios;
import java.sql.*;
import java.util.ArrayList;
import util.encriptar;

public class usuariodao {

    private Connection cn = null;
    private CallableStatement cs = null; 
    private ResultSet rs = null;
    private PreparedStatement ps = null;
    
    public usuarios validar(String user, String pass) {
        usuarios us = null;
        String sql = "{call sp_validarusuario(?)}";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);
            
            cs.setString(1, user);
            
            rs = cs.executeQuery();

            if (rs.next()) {
                String contrasenabd = rs.getString("contrasena");
                if (encriptar.verificar(pass, contrasenabd)) {
                    us = new usuarios();
                    us.setIdUsuario(rs.getInt("id_usuario"));
                    us.setNombreusuario(rs.getString("nombreusuario"));
                    us.setRol(rs.getString("rol"));
                    us.setCorreo(rs.getString("correo"));
                    us.setImagen(rs.getString("imagen"));
                    us.setDni(rs.getString("dni"));
                    us.setNombrecompleto(rs.getString("nombre_completo"));
                    us.setTelefono(rs.getString("telefono"));
                    us.setEstadousuario(rs.getInt("estado"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return us;
    }

    public boolean registrar(String user, String pass, String nombre, String dni, String correo, String telefono) {
        String sql = "{call sp_registrarusuario(?, ?, ?, ?, ?, ?, ?)}";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setString(1, user);
            cs.setString(2, encriptar.encriptar(pass));
            cs.setString(3, nombre);
            cs.setString(4, dni);
            cs.setString(5, correo);
            cs.setString(6, telefono);
            cs.registerOutParameter(7, Types.INTEGER);
            cs.executeUpdate();
            return cs.getInt(7) == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }
    public ArrayList<usuarios>listarusuarios() {
        ArrayList<usuarios> lista = new ArrayList<>();
        String sql ="{call sp_mostrarusuarios()}";
        
        try {
            cn = conexioncora_bd.probarConexion();
            ps = cn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                usuarios usu = new usuarios();
                usu.setIdUsuario(rs.getInt("idUsuario"));
                usu.setNombreusuario(rs.getString("nombreusuario"));
                usu.setEstadousuario(rs.getInt("estadousuario"));
                usu.setDni(rs.getString("dni"));
                usu.setNombrecompleto(rs.getString("nombrecompleto"));
                usu.setCorreo(rs.getString("correo"));
                usu.setTelefono(rs.getString("telefono"));
                usu.setImagen(rs.getString("imagen"));
                usu.setRol(rs.getString("rol"));

                lista.add(usu);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }
        return  lista;
    }
    
    public boolean registrarusuarios(String user, String pass, String nombre, String dni, String correo, String telefono, String imagen, int idrol) {
        String sql = "{call sp_registrarusuarios(?, ?, ?, ?, ?, ?, ?,?,?)}";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setString(1, user);
            cs.setString(2, encriptar.encriptar(pass));
            cs.setString(3, nombre);
            cs.setString(4, dni);
            cs.setString(5, correo);
            cs.setString(6, telefono);
            cs.setString(7, imagen);
            cs.setInt(8, idrol);
            cs.registerOutParameter(9, Types.INTEGER);
            cs.executeUpdate();
            return cs.getInt(9) == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }
    
    //editar usuario
    public boolean editarusuario(int idUsuario, String user, String pass, String nombre, String dni, String correo, String telefono, String imagen, int idRol, int estado) {
        String sql = "{call sp_editarusuario(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, idUsuario);
            cs.setString(2, user);
            
            if (pass != null && !pass.trim().isEmpty()) {
                cs.setString(3, encriptar.encriptar(pass));
            } else {
                cs.setString(3, "");
            }
            
            cs.setString(4, nombre);
            cs.setString(5, dni);
            cs.setString(6, correo);
            cs.setString(7, telefono);
            cs.setString(8, imagen);
            cs.setInt(9, idRol);
            cs.setInt(10, estado);
            
            cs.registerOutParameter(11, Types.INTEGER);
            
            cs.executeUpdate();
            
            return cs.getInt(11) == 1;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }
    //desactivar usuario
    public boolean desactivarusuario(int idUsuario) {
        String sql = "{call sp_desactivarusuario(?, ?)}";

        try {
            cn = conexioncora_bd.probarConexion();
            cs = cn.prepareCall(sql);

            cs.setInt(1, idUsuario);
            
            cs.registerOutParameter(2, Types.INTEGER);
            
            cs.executeUpdate();
            
            return cs.getInt(2) == 1;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
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

