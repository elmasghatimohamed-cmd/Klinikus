package ma.youcode.klinikus.web;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.service.PatientService;

@WebServlet("/infirmier/patients")
public class PatientServlet extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() {
        this.patientService = (PatientService) getServletContext().getAttribute("patientService");
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

            String freqCardStr = req.getParameter("frequenceCardiaque");
            if (freqCardStr != null && !freqCardStr.isBlank()) {
                p.setFrequenceCardiaque(Integer.valueOf(freqCardStr));
            }

            String tempStr = req.getParameter("temperature");
            if (tempStr != null && !tempStr.isBlank()) {
                p.setTemperature(Double.valueOf(tempStr));
            }

            String freqRespStr = req.getParameter("frequenceRespiratoire");
            if (freqRespStr != null && !freqRespStr.isBlank()) {
                p.setFrequenceRespiratoire(Integer.valueOf(freqRespStr));
            }

            patientService.enregistrerPatient(p);
            resp.sendRedirect(req.getContextPath() + "/infirmier/patients?success=1");

        } catch (IllegalArgumentException | DateTimeParseException | NullPointerException e) {
            req.setAttribute("error", "Donnees invalides, verifiez le formulaire");
            req.setAttribute("patient", p);
            req.getRequestDispatcher("/WEB-INF/views/infirmier/patient-form.jsp").forward(req, resp);
        }
    }
}