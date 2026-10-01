package ma.youcode.klinikus.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

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

    /**
     * Clôture la consultation pour un patient donné
     */
    public Consultation cloturer(Long patientId, String motif, String observations, String diagnostic,
            String traitement, Long medecinId) {
        if (patientId == null || motif == null || motif.isBlank() || diagnostic == null || diagnostic.isBlank()) {
            throw new IllegalArgumentException("Le patient, le motif et le diagnostic sont obligatoires.");
        }

        patientDAO.findById(patientId)
                .orElseThrow(() -> new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId));

        Consultation consultation = new Consultation();
        consultation.setPatientId(patientId);
        consultation.setMedecinId(medecinId);
        consultation.setMotif(motif);
        consultation.setObservations(observations);
        consultation.setDiagnostic(diagnostic);
        consultation.setTraitement(traitement);
        consultation.setCout(Consultation.COUT_FIXE);
        consultation.setStatus(ConsultationStatus.TERMINEE);
        consultation.setDateConsultation(LocalDateTime.now());

        return consultationDAO.save(consultation);
    }

    public List<Patient> getPatientsEnAttenteDuJour() {
        Set<Long> patientIdsTraites = new HashSet<>(consultationDAO.findPatientIdsWithConsultation());
        LocalDate aujourdhui = LocalDate.now();

        return patientDAO.findAll().stream()
                .filter(p -> p.getDateArrivee() != null
                        && p.getDateArrivee().toLocalDate().equals(aujourdhui))
                .filter(p -> !patientIdsTraites.contains(p.getId()))
                .sorted(Comparator.comparing(Patient::getDateArrivee))
                .collect(Collectors.toList());
    }
}