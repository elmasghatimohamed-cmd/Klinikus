package ma.youcode.klinikus.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DatabaseConnection.getDataSource();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DatabaseConnection.closePool();
    }
}