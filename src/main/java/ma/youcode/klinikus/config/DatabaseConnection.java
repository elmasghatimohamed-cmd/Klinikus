package ma.youcode.klinikus.config;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import io.github.cdimascio.dotenv.Dotenv;

public class DatabaseConnection {

    private static final HikariDataSource dataSource;

    static {
        try {
            Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();

            String dbUrl = getEnvOrProperty(dotenv, "DB_URL");
            String dbUsername = getEnvOrProperty(dotenv, "DB_USERNAME");
            String dbPassword = getEnvOrProperty(dotenv, "DB_PASSWORD");

            if (dbUrl == null || dbUsername == null || dbPassword == null) {
                throw new IllegalStateException(
                        "Missing required database configuration (DB_URL, DB_USERNAME, DB_PASSWORD).");
            }

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(dbUrl);
            config.setUsername(dbUsername);
            config.setPassword(dbPassword);

            config.setMaximumPoolSize(Integer.parseInt(getEnvOrProperty(dotenv, "DB_MAX_POOL_SIZE")));
            config.setMinimumIdle(Integer.parseInt(getEnvOrProperty(dotenv, "DB_MIN_IDLE")));
            config.setIdleTimeout(Long.parseLong(getEnvOrProperty(dotenv, "DB_IDLE_TIMEOUT")));
            config.setConnectionTimeout(Long.parseLong(getEnvOrProperty(dotenv, "DB_CONNECTION_TIMEOUT")));

            dataSource = new HikariDataSource(config);
        } catch (ExceptionInInitializerError e) {
            throw new ExceptionInInitializerError(
                    "Erreur lors de l'initialisation de la base de données: " + e.getMessage());
        }
    }

    private DatabaseConnection() {
    }

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null || dataSource.isClosed()) {
            throw new SQLException("La source de donnees n'est pas initialisee ou est fermee.");
        }
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
        }
    }

    private static String getEnvOrProperty(Dotenv dotenv, String key) {
        String value = dotenv.get(key);
        if (value == null || value.trim().isEmpty()) {
            value = System.getenv(key);
        }
        return value;
    }
}