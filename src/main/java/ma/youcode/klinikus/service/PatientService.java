package ma.youcode.klinikus.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import ma.youcode.klinikus.config.DatabaseConnection;
import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcConsultationDAO;
import ma.youcode.klinikus.dao.implementation.jdbc.JdbcPatientDAO;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

public class PatientService {

    private final PatientDAO patientDAO;
    private final ConsultationDAO consultationDAO;

    // No-arg constructor fallback using Hikari DataSource
    public PatientService() {
        this(
                new JdbcPatientDAO(DatabaseConnection.getDataSource()),
                new JdbcConsultationDAO(DatabaseConnection.getDataSource()));
    }

    public PatientService(PatientDAO patientDAO, ConsultationDAO consultationDAO) {
        if (patientDAO == null || consultationDAO == null) {
            throw new IllegalArgumentException("PatientDAO et ConsultationDAO ne peuvent pas être null");
        }
        this.patientDAO = patientDAO;
        this.consultationDAO = consultationDAO;
    }

    public Patient enregistrerPatient(Patient p) {
        if (p.getNom() == null || p.getNom().isBlank()
                || p.getPrenom() == null || p.getPrenom().isBlank()
                || p.getNumSecu() == null || p.getNumSecu().isBlank()
                || p.getDateNaissance() == null) {
            throw new IllegalArgumentException(
                    "Nom, prenom, date de naissance et numero de securite sociale sont obligatoires");
        }
        p.setDateArrivee(LocalDateTime.now());
        return patientDAO.save(p);
    }

    public List<Patient> getPatientsDuJour() {
        LocalDate today = LocalDate.now();
        Set<Long> patientsTermines = Set.copyOf(
                consultationDAO.findPatientIdsByStatus(ConsultationStatus.TERMINEE));

        return patientDAO.findAll().stream()
                .filter(p -> p.getDateArrivee() != null && p.getDateArrivee().toLocalDate().equals(today))
                .filter(p -> !patientsTermines.contains(p.getId()))
                .sorted(Comparator.comparing(Patient::getDateArrivee))
                .collect(Collectors.toList());
    }
}