package ma.youcode.klinikus.service;

import java.time.LocalDateTime;

import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Consultation;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

public class ConsultationService {

    private final ConsultationDAO consultationDAO;
    private final PatientDAO patientDAO;

    public ConsultationService(ConsultationDAO consultationDAO, PatientDAO patientDAO) {
        this.consultationDAO = consultationDAO;
        this.patientDAO = patientDAO;
    }

    public Consultation cloturer(Long patientId, String motif, String observations, String diagnostic,
            String traitement, Long medecinId) {
        if (patientId == null || isBlank(motif) || isBlank(observations) || isBlank(diagnostic)
                || isBlank(traitement)) {
            throw new IllegalArgumentException("Tous les champs du formulaire sont obligatoires.");
        }

        Patient patient = patientDAO.findById(patientId)
                .orElseThrow(() -> new IllegalArgumentException("Patient introuvable."));

        if (consultationDAO.findByPatientId(patientId).isPresent()) {
            throw new IllegalStateException("Ce patient a déjà été consulté.");
        }

        Consultation consultation = new Consultation();
        consultation.setPatientId(patient.getId());
        consultation.setMedecinId(medecinId);
        consultation.setMotif(motif.trim());
        consultation.setObservations(observations.trim());
        consultation.setDiagnostic(diagnostic.trim());
        consultation.setTraitement(traitement.trim());
        consultation.setCout(Consultation.COUT_FIXE); // 150.0 DH
        consultation.setStatus(ConsultationStatus.TERMINEE);
        consultation.setDateConsultation(LocalDateTime.now());

        return consultationDAO.save(consultation);
    }

    private boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }
}