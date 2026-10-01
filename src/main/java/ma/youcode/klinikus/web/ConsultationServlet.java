package ma.youcode.klinikus.web;

import java.io.IOException;
import java.util.Optional;

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
import ma.youcode.klinikus.model.User;
import ma.youcode.klinikus.service.ConsultationService;
import ma.youcode.klinikus.service.PatientService;

@WebServlet("/generaliste/consultation")
public class ConsultationServlet extends HttpServlet {

    private ConsultationService consultationService;
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        PatientDAO patientDAO = new JdbcPatientDAO(DatabaseConnection.getDataSource());
        ConsultationDAO consultationDAO = new JdbcConsultationDAO(DatabaseConnection.getDataSource());

        this.patientService = new PatientService(patientDAO , consultationDAO);
        this.consultationService = new ConsultationService(consultationDAO, patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String patientIdParam = req.getParameter("patientId");

        if (patientIdParam == null || patientIdParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/generaliste/patients?error=missing_id");
            return;
        }

        try {
            Long patientId = Long.parseLong(patientIdParam);
            Optional patientOpt = patientService.trouverParId(patientId);

            if (patientOpt.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/generaliste/patients?error=not_found");
                return;
            }

            req.setAttribute("patient", patientOpt.get());
            req.getRequestDispatcher("/WEB-INF/views/generaliste/consultation-form.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/generaliste/patients?error=invalid_id");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User medecin = (session != null) ? (User) session.getAttribute("utilisateur") : null;

        if (medecin == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String patientIdStr = req.getParameter("patientId");
        String motif = req.getParameter("motif");
        String observations = req.getParameter("observations");
        String diagnostic = req.getParameter("diagnostic");
        String traitement = req.getParameter("traitement");

        try {
            Long patientId = Long.parseLong(patientIdStr);
            consultationService.cloturer(patientId, motif, observations, diagnostic, traitement, medecin.getId());

            resp.sendRedirect(req.getContextPath() + "/generaliste/patients?success=cloturee");

        } catch (IllegalArgumentException | IllegalStateException e) {
            req.setAttribute("errorMessage", e.getMessage());

            if (patientIdStr != null && !patientIdStr.isEmpty()) {
                try {
                    patientService.trouverParId(Long.parseLong(patientIdStr))
                            .ifPresent(p -> req.setAttribute("patient", p));
                } catch (NumberFormatException ignored) {
                }
            }

            req.setAttribute("motif", motif);
            req.setAttribute("observations", observations);
            req.setAttribute("diagnostic", diagnostic);
            req.setAttribute("traitement", traitement);

            req.getRequestDispatcher("/WEB-INF/views/generaliste/consultation-form.jsp").forward(req, resp);
        }
    }
}