package ma.youcode.klinikus.service;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;

import ma.youcode.klinikus.dao.UserDAO;
import ma.youcode.klinikus.model.User;

/**
 * Logique d'authentification. Dépend uniquement de l'interface UserDAO
 * (jamais de JdbcUserDAO / JpaUserDAO), pour que la migration JPA ne touche pas
 * ce service.
 */
public class AuthService {

    private static final int BCRYPT_COST = 12;

    // Hash factice : permet de faire un checkpw même quand l'email est inconnu,
    // afin que le temps de réponse ne révèle pas si le compte existe.
    private static final String DUMMY_HASH = BCrypt.hashpw("mot-de-passe-factice", BCrypt.gensalt(BCRYPT_COST));

    private final UserDAO userDAO;

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * @return l'utilisateur si les identifiants sont valides, sinon Optional vide
     *         (même résultat pour email inconnu et mot de passe faux).
     */
    public Optional<User> authentifier(String email, String motDePasse) {
        if (email == null || email.isBlank() || motDePasse == null || motDePasse.isEmpty()) {
            return Optional.empty();
        }

        Optional<User> trouve = userDAO.findByEmail(email.trim());
        String hash = trouve.map(User::getPassword).orElse(DUMMY_HASH);

        boolean valide;
        try {
            System.out.println("Email: " + email);
            System.out.println("User found: " + trouve.isPresent());

            if (trouve.isPresent()) {
                System.out.println("Password hash: " + trouve.get().getPassword());
            }
            valide = BCrypt.checkpw(motDePasse, hash);
        } catch (IllegalArgumentException e) {
            // hash mal formé en base (ex. mot de passe stocké en clair par erreur)
            valide = false;
        }

        return valide ? trouve : Optional.empty();
    }

    /** À utiliser pour générer les hashes du script SQL (schema.sql). */
    public static String hasherMotDePasse(String motDePasseClair) {
        return BCrypt.hashpw(motDePasseClair, BCrypt.gensalt(BCRYPT_COST));
    }
}