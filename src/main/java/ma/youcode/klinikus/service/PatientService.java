package ma.youcode.klinikus.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;

public class PatientService {

    private PatientDAO patientDAO;

    public PatientService(PatientDAO patientDAO) {
        this.patientDAO = patientDAO;
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

    public List getPatientsDuJour() {
        LocalDate today = LocalDate.now();
        return patientDAO.findAll().stream()
                .filter(p -> p.getDateArrivee().toLocalDate().equals(today))
                .sorted(Comparator.comparing(Patient::getDateArrivee))
                .collect(Collectors.toList());
    }

    public Optional trouverParId(Long id) {
        return patientDAO.findById(id);
    }
}