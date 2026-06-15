package util;

import org.mindrot.jbcrypt.BCrypt;

public class encriptar {
    public static String encriptar(String contrasena) {
        return BCrypt.hashpw(contrasena, BCrypt.gensalt());
    }

    public static boolean verificar(String contrasenaescrita, String hashBD) {
        return BCrypt.checkpw(contrasenaescrita, hashBD);
    }
}
