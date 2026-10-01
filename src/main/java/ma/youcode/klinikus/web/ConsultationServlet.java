package ma.youcode.klinikus.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.klinikus.config.DatabaseConnection;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcConsultationDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcPatientDAO;
import ma.youcode.klinikus.filter.AuthenticationFilter;
import ma.youcode.klinikus.model.Consultation;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.User;
import ma.youcode.klinikus.service.ConsultationService;

@WebServlet("/generaliste/consultation")
public class ConsultationServlet extends HttpServlet {

    private static final String VUE_FORMULAIRE = "/WEB-INF/views/generaliste/consultation-form.jsp";

    private ConsultationService consultationService;

    @Override
    public void init() throws ServletException {
        PatientDAO patientDAO = new JdbcPatientDAO(DatabaseConnection.getDataSource());
        ConsultationDAO consultationDAO = new JdbcConsultationDAO(DatabaseConnection.getDataSource());
        this.consultationService = new ConsultationService(consultationDAO, patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long patientId = parseId(req.getParameter("patientId"));

        try {
            Patient patient = consultationService.getPatientAConsulter(patientId);
            afficherFormulaire(req, resp, patient);
        } catch (IllegalArgumentException e) {
            // ID absent, patient inconnu ou déjà consulté : retour à la salle d'attente
            resp.sendRedirect(req.getContextPath() + "/generaliste/attente");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        User medecin = utilisateurConnecte(req);
        if (medecin == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Long patientId = parseId(req.getParameter("patientId"));
        String motif = nettoyer(req.getParameter("motif"));
        String observations = nettoyer(req.getParameter("observations"));
        String diagnostic = nettoyer(req.getParameter("diagnostic"));
        String traitement = nettoyer(req.getParameter("traitement"));

        try {
            consultationService.cloturer(patientId, motif, observations, diagnostic, traitement, medecin.getId());
            resp.sendRedirect(req.getContextPath() + "/generaliste/attente?success=1");

        } catch (IllegalArgumentException e) {
            Patient patient;
            try {
                patient = consultationService.getPatientAConsulter(patientId);
            } catch (IllegalArgumentException ex) {
                resp.sendRedirect(req.getContextPath() + "/generaliste/attente");
                return;
            }

            // On réaffiche le formulaire avec ce que le médecin avait déjà saisi
            req.setAttribute("erreur", e.getMessage());
            req.setAttribute("motif", motif);
            req.setAttribute("observations", observations);
            req.setAttribute("diagnostic", diagnostic);
            req.setAttribute("traitement", traitement);
            afficherFormulaire(req, resp, patient);
        }
    }

    private void afficherFormulaire(HttpServletRequest req, HttpServletResponse resp, Patient patient)
            throws ServletException, IOException {
        req.setAttribute("patient", patient);
        req.setAttribute("cout", Consultation.COUT_FIXE);
        req.getRequestDispatcher(VUE_FORMULAIRE).forward(req, resp);
    }

    private static User utilisateurConnecte(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        return session == null ? null : (User) session.getAttribute(AuthenticationFilter.SESSION_USER);
    }

    private static Long parseId(String valeur) {
        try {
            return valeur == null ? null : Long.valueOf(valeur.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static String nettoyer(String valeur) {
        return valeur == null ? "" : valeur.trim();
    }
}