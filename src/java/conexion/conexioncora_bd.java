
package conexion;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author USUARIO
 */
public class conexioncora_bd {
    private static String db = "cora_bd";
    private static String url = "jdbc:mysql://127.0.0.1:3306/"+db;
    private static String user = "root";
    private static String pass = "sandy200509";
    
    public static Connection probarConexion() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conexion establecida con "+db);

        } catch (Exception e) {
            e.getMessage();
        }
        return con;
    }
}
