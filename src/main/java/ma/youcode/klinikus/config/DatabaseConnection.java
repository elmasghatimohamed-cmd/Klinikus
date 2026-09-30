package ma.youcode.klinikus.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.github.cdimascio.dotenv.Dotenv;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection {

    private static HikariDataSource dataSource;

    static {
        try {

            Class.forName("org.postgresql.Driver");

            Dotenv dotenv = Dotenv.load();

            HikariConfig config = new HikariConfig();
<<<<<<< HEAD
            config.setJdbcUrl("jdbc:postgresql://localhost:5432/klinikus_db");
            config.setUsername("badr");
            config.setPassword("admin123");
=======

            config.setJdbcUrl(dotenv.get("DB_URL"));
            config.setUsername(dotenv.get("DB_USERNAME"));
            config.setPassword(dotenv.get("DB_PASSWORD"));
>>>>>>> 7284af4c79a5565d5308b7a8066f0029f4023f79

            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(30000);
            config.setConnectionTimeout(30000);

            dataSource = new HikariDataSource(config);

        } catch (ClassNotFoundException e) {

            throw new RuntimeException(
                    "Driver JDBC introuvable dans le classpath.", e);

        } catch (Exception e) {

            throw new RuntimeException(
                    "Erreur lors de l'initialisation de la base de donnees.", e);
        }
    }

    private DatabaseConnection() {
    }

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }
}