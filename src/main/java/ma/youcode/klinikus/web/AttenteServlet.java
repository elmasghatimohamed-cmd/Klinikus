package ma.youcode.klinikus.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.service.ConsultationService;

@WebServlet("/generaliste/attente")
public class AttenteServlet extends HttpServlet {

    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        PatientDAO patientDAO = (PatientDAO) getServletContext().getAttribute("patientDAO");
        ConsultationDAO consultationDAO = (ConsultationDAO) getServletContext().getAttribute("consultationDAO");

        this.consultationService = new ConsultationService(consultationDAO, patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Patient> patientsEnAttente = consultationService.getPatientsEnAttenteDuJour();

        req.setAttribute("patientsEnAttente", patientsEnAttente);
        req.getRequestDispatcher("/WEB-INF/views/generaliste/attente.jsp").forward(req, resp);
    }
}