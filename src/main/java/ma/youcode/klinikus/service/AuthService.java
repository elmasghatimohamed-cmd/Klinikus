package ma.youcode.klinikus.service;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.klinikus.dao.UserDAO;
import ma.youcode.klinikus.model.User;

public class AuthService {

    private static final int BCRYPT_COST = 12;
    private static final String DUMMY_HASH = BCrypt.hashpw("mot-de-passe-factice", BCrypt.gensalt(BCRYPT_COST));

    private final UserDAO userDAO;

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public Optional<User> authentifier(String email, String motDePasse) {
        if (email == null || email.isBlank() || motDePasse == null || motDePasse.isEmpty()) {
            return Optional.empty();
        }

        Optional<User> trouve = userDAO.findByEmail(email.trim());
        String hash = trouve.map(User::getPassword).orElse(DUMMY_HASH);

        boolean valide;
        try {
            valide = BCrypt.checkpw(motDePasse, hash);
        } catch (IllegalArgumentException e) {
            valide = false;
        }

        return valide ? trouve : Optional.empty();
    }

    public static String hasherMotDePasse(String motDePasseClair) {
        return BCrypt.hashpw(motDePasseClair, BCrypt.gensalt(BCRYPT_COST));
    }
}