package ma.youcode.klinikus.service;

import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class PatientService {

    private PatientDAO patientDAO;
    private ConsultationDAO consultationDAO;

    public PatientService(PatientDAO patientDAO, ConsultationDAO consultationDAO) {
        this.patientDAO = patientDAO;
        this.consultationDAO = consultationDAO;
    }

    public Patient enregistrerPatient(Patient p) {
        if (p.getNom() == null || p.getNom().isBlank()
                || p.getPrenom() == null || p.getPrenom().isBlank()
                || p.getNumSecu() == null || p.getNumSecu().isBlank()
                || p.getDateNaissance() == null) {
            throw new IllegalArgumentException("Nom, prenom, date de naissance et numero de securite sociale sont obligatoires");
        }
        p.setDateArrivee(LocalDateTime.now());
        return patientDAO.save(p);
    }

    public List<Patient> getPatientsDuJour() {
        LocalDate today = LocalDate.now();
        Set<Long> patientsTermines = Set.copyOf(
                consultationDAO.findPatientIdsByStatus(ConsultationStatus.TERMINEE));

        return patientDAO.findAll().stream()
                .filter(p -> p.getDateArrivee().toLocalDate().equals(today))
                .filter(p -> !patientsTermines.contains(p.getId()))
                .sorted(Comparator.comparing(Patient::getDateArrivee))
                .collect(Collectors.toList());
    }
}