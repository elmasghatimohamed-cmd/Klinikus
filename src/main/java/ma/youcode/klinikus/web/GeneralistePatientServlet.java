package ma.youcode.klinikus.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import ma.youcode.klinikus.config.DatabaseConnection;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcConsultationDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcPatientDAO;
import ma.youcode.klinikus.service.PatientService;

@WebServlet("/generaliste/patients")
public class GeneralistePatientServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {
        PatientDAO patientDAO = new JdbcPatientDAO(DatabaseConnection.getDataSource());
        ConsultationDAO consultationDAO = new JdbcConsultationDAO(DatabaseConnection.getDataSource());
        this.patientService = new PatientService(patientDAO, consultationDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("patients", patientService.getPatientsDuJour());
        req.getRequestDispatcher("/WEB-INF/views/generaliste/attente.jsp").forward(req, resp);
    }
}