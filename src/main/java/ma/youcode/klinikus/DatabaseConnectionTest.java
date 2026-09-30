package ma.youcode.klinikus;

import java.sql.Connection;
import ma.youcode.klinikus.config.DatabaseConnection;

public class DatabaseConnectionTest {

    public static void main(String[] args) {

        try (Connection connection = DatabaseConnection.getConnection()) {

            System.out.println("Connexion PostgreSQL reussie !");
            System.out.println("Base : " + connection.getCatalog());
            System.out.println("URL : " + connection.getMetaData().getURL());

        } catch (Exception e) {

            System.out.println("Erreur de connexion !");
            e.printStackTrace();
        }
    }
    
}
