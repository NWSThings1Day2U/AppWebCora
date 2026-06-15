package dao;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo.categorias;
import conexion.conexioncora_bd;
import java.sql.SQLException;

public class categoriadao {

    Connection con;
    CallableStatement cs;
    PreparedStatement ps;
    ResultSet rs;

    public boolean insertarCategoria(categorias cat) {
        String sql = "{CALL Insertarcategorias(?, ?, ?)}";

        try {
            con = conexioncora_bd.probarConexion();
            cs = con.prepareCall(sql);

            cs.setString(1, cat.getNombre());
            cs.setString(2, cat.getDescripcion());
            cs.setString(3, cat.getImagen());

            cs.execute();
            return true;

        } catch (Exception e) {
            System.out.println("Error al insertar categoria: " + e.getMessage());
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    public ArrayList<categorias> mostrarCategorias() {
        ArrayList<categorias> lista = new ArrayList<>();
        String sql = "{CALL Mostrarcategorias()}";

        try {
            con = conexioncora_bd.probarConexion();
            cs = con.prepareCall(sql);
            rs = cs.executeQuery();

            while (rs.next()) {
                categorias cat = new categorias();

                cat.setId_categoria(rs.getInt("id_categoria"));
                cat.setNombre(rs.getString("nombre"));
                cat.setDescripcion(rs.getString("descripcion"));
                cat.setImagen(rs.getString("imagen"));

                lista.add(cat);
            }

        } catch (Exception e) {
            System.out.println("Error al mostrar categorias: " + e.getMessage());
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    public boolean editarCategoria(categorias cat) {
        String sql = "{CALL Editarcategorias(?, ?, ?, ?)}";

        try {
            con = conexioncora_bd.probarConexion();
            cs = con.prepareCall(sql);

            cs.setInt(1, cat.getId_categoria());
            cs.setString(2, cat.getNombre());
            cs.setString(3, cat.getDescripcion());
            cs.setString(4, cat.getImagen());

            cs.execute();
            return true;

        } catch (Exception e) {
            System.out.println("Error al editar categoria: " + e.getMessage());
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    public boolean eliminarCategoria(int id_categoria) {
        String sql = "{CALL Eliminarcategorias(?)}";

        try {
            con = conexioncora_bd.probarConexion();
            cs = con.prepareCall(sql);

            cs.setInt(1, id_categoria);

            cs.execute();
            return true;

        } catch (Exception e) {
            System.out.println("Error al eliminar categoria: " + e.getMessage());
            return false;
        } finally {
            cerrarRecursos();
        }
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
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
