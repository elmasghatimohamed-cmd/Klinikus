package ma.youcode.klinikus.config;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DatabaseConnection {

    private static final HikariDataSource dataSource;

    static {
        try {

            Class.forName("org.postgresql.Driver");
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:postgresql://localhost:5432/klinikus_db");
            config.setUsername("mohamed");
            config.setPassword("admin123");

            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(300000L);
            config.setConnectionTimeout(30000L);

            dataSource = new HikariDataSource(config);
            System.out.println("HikariCP DataSource successfully initialized.");
        } catch (Exception e) {
            System.err.println(" Failed to initialize HikariCP connection pool: " + e.getMessage());
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
            throw new SQLException("La source de données n'est pas initialisée ou est fermée.");
        }
        return dataSource.getConnection();
    }

    public static void closePool() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("[INFO] HikariCP connection pool closed.");
        }
    }
}