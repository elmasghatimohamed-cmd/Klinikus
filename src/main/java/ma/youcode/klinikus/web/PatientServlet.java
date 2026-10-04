package ma.youcode.klinikus.web;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.service.PatientService;

@WebServlet("/infirmier/patients")
public class PatientServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {
        PatientDAO patientDAO = (PatientDAO) getServletContext().getAttribute("patientDAO");
        ConsultationDAO consultationDAO = (ConsultationDAO) getServletContext().getAttribute("consultationDAO");

        this.patientService = new PatientService(patientDAO, consultationDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        if ("nouveau".equals(req.getParameter("action"))) {
            req.getRequestDispatcher("/WEB-INF/views/infirmier/patient-form.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("patients", patientService.getPatientsDuJour());
        req.getRequestDispatcher("/WEB-INF/views/infirmier/patients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Patient p = new Patient();
        try {
            p.setNom(req.getParameter("nom"));
            p.setPrenom(req.getParameter("prenom"));
            p.setDateNaissance(LocalDate.parse(req.getParameter("dateNaissance")));
            p.setNumSecu(req.getParameter("numSecu"));
            p.setTension(req.getParameter("tension"));

            p.setFrequenceCardiaque(Integer.valueOf(req.getParameter("frequenceCardiaque")));
            p.setTemperature(Double.valueOf(req.getParameter("temperature")));
            p.setFrequenceRespiratoire(Integer.valueOf(req.getParameter("frequenceRespiratoire")));

            patientService.enregistrerPatient(p);
            resp.sendRedirect(req.getContextPath() + "/infirmier/patients?success=1");

        } catch (IllegalArgumentException | DateTimeParseException | NullPointerException e) {
            req.setAttribute("error", "Donnees invalides, verifiez le formulaire");
            req.setAttribute("patient", p);
            req.getRequestDispatcher("/WEB-INF/views/infirmier/patient-form.jsp").forward(req, resp);
        }
    }
}