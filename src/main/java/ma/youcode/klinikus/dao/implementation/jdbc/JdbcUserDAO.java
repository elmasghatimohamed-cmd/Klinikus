package ma.youcode.klinikus.dao.implementation.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;

import ma.youcode.klinikus.config.DatabaseConnection;
import ma.youcode.klinikus.dao.UserDAO;
import ma.youcode.klinikus.model.User;
import ma.youcode.klinikus.model.enums.Role;

public class JdbcUserDAO implements UserDAO {

    private static final String SELECT_BY_EMAIL = "SELECT id, nom, email, mot_de_passe, role " +
            "FROM utilisateur WHERE email = ?";

    private static final String SELECT_BY_ID = "SELECT id, nom, email, mot_de_passe, role " +
            "FROM utilisateur WHERE id = ?";

    private static final String INSERT = "INSERT INTO utilisateur (nom, email, mot_de_passe, role) " +
            "VALUES (?, ?, ?, ?)";

    @Override
    public Optional<User> findByEmail(String email) {

        try (Connection cn = DatabaseConnection.getConnection();
                PreparedStatement ps = cn.prepareStatement(SELECT_BY_EMAIL)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next()
                        ? Optional.of(mapper(rs))
                        : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Erreur lors de la recherche de l'utilisateur par email", e);
        }
    }

    @Override
    public Optional<User> findById(Long id) {

        try (Connection cn = DatabaseConnection.getConnection();
                PreparedStatement ps = cn.prepareStatement(SELECT_BY_ID)) {

            ps.setLong(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next()
                        ? Optional.of(mapper(rs))
                        : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Erreur lors de la recherche de l'utilisateur par id", e);
        }
    }

    @Override
    public User save(User user) {

        try (Connection cn = DatabaseConnection.getConnection();
                PreparedStatement ps = cn.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getNom());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole().name());

            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    user.setId(keys.getLong(1));
                }
            }

            return user;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Erreur lors de l'enregistrement de l'utilisateur", e);
        }
    }

    private User mapper(ResultSet rs) throws SQLException {

        return new User(
                rs.getLong("id"),
                rs.getString("nom"),
                rs.getString("email"),
                rs.getString("mot_de_passe"),
                Role.valueOf(rs.getString("role")));
    }
}
