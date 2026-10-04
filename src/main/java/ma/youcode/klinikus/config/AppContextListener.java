package ma.youcode.klinikus.config;

import javax.sql.DataSource;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.dao.UserDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcConsultationDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcPatientDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcUserDAO;
import ma.youcode.klinikus.service.AuthService;
import ma.youcode.klinikus.service.ConsultationService;
import ma.youcode.klinikus.service.PatientService;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            DataSource ds = DatabaseConnection.getDataSource();

            UserDAO userDAO = new JdbcUserDAO(ds);
            PatientDAO patientDAO = new JdbcPatientDAO(ds);
            ConsultationDAO consultationDAO = new JdbcConsultationDAO(ds);

            AuthService authService = new AuthService(userDAO);
            PatientService patientService = new PatientService(patientDAO, consultationDAO);
            ConsultationService consultationService = new ConsultationService(consultationDAO, patientDAO);

            sce.getServletContext().setAttribute("userDAO", userDAO);
            sce.getServletContext().setAttribute("patientDAO", patientDAO);
            sce.getServletContext().setAttribute("consultationDAO", consultationDAO);

            sce.getServletContext().setAttribute("authService", authService);
            sce.getServletContext().setAttribute("patientService", patientService);
            sce.getServletContext().setAttribute("consultationService", consultationService);

            System.out.println("[INFO] Context listener successfully bound all DAOs and Services.");
        } catch (Exception e) {
            System.err.println("[ERROR] Exception in AppContextListener during startup:");
            e.printStackTrace();
            throw new IllegalStateException("Application startup failed", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            DatabaseConnection.closePool();
        } catch (Exception e) {
            System.err.println("[WARN] Error while closing connection pool:");
            e.printStackTrace();
        }
    }
}