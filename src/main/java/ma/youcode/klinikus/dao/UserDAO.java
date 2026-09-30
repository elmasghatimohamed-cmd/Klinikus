package ma.youcode.klinikus.dao;

import java.util.Optional;

import ma.youcode.klinikus.model.User;

public interface UserDAO {

    Optional<User> findByEmail(String email);

    Optional<User> findById(Long id);

    User save(User user);
}