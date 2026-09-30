package ma.youcode.klinikus;

import org.mindrot.jbcrypt.BCrypt;

public class BCryptTest {

    public static void main(String[] args) {

        String password = "Infirmier123";

        String hash = BCrypt.hashpw(password, BCrypt.gensalt());

        System.out.println(hash);
    }
}