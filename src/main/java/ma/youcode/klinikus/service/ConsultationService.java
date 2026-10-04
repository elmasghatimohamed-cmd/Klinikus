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

    public Patient getPatientAConsulter(Long patientId) {
        if (patientId == null) {
            throw new IllegalArgumentException("Patient manquant.");
        }

        Patient patient = patientDAO.findById(patientId)
                .orElseThrow(() -> new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId));

        Consultation consultation = consultationDAO.findByPatientId(patientId)
                .orElseThrow(() -> new IllegalArgumentException("Aucune consultation n'existe pour ce patient."));

        if (consultation.getStatus() != ConsultationStatus.EN_ATTENT) {
            throw new IllegalArgumentException("Ce patient a déjà été consulté.");
        }
        return patient;
    }

    public Consultation cloturer(Long patientId, String motif, String observations, String diagnostic,
            String traitement, Long medecinId) {
        if (patientId == null || motif == null || motif.isBlank() || diagnostic == null || diagnostic.isBlank()) {
            throw new IllegalArgumentException("Le motif et le diagnostic sont obligatoires.");
        }
        if (medecinId == null) {
            throw new IllegalArgumentException("Médecin non identifié.");
        }
        getPatientAConsulter(patientId);

        Consultation c = consultationDAO.findByPatientId(patientId)
                .orElseThrow(() -> new IllegalArgumentException("Aucune consultation n'existe pour ce patient."));

        c.setMedecinId(medecinId);
        c.setMotif(motif);
        c.setObservations(observations);
        c.setDiagnostic(diagnostic);
        c.setTraitement(traitement);
        c.setStatus(ConsultationStatus.TERMINEE);
        c.setDateConsultation(LocalDateTime.now());

        return consultationDAO.update(c);
    }

    public List<Patient> getPatientsEnAttenteDuJour() {
        Set<Long> patientIdsEnAttente = new HashSet<>(
                consultationDAO.findPatientIdsByStatus(ConsultationStatus.EN_ATTENT));
        LocalDate aujourdhui = LocalDate.now();
        return patientDAO.findAll().stream()
                .filter(p -> p.getDateArrivee() != null
                        && p.getDateArrivee().toLocalDate().equals(aujourdhui))
                .filter(p -> patientIdsEnAttente.contains(p.getId()))
                .sorted(Comparator.comparing(Patient::getDateArrivee))
                .collect(Collectors.toList());
    }
}