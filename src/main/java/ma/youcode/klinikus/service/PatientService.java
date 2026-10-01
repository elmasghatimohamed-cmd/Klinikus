package ma.youcode.klinikus.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Consultation;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

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
            throw new IllegalArgumentException(
                    "Nom, prenom, date de naissance et numero de securite sociale sont obligatoires");
        }
        p.setDateArrivee(LocalDateTime.now());
        return patientDAO.save(p);
    }

    public List<Patient> getPatientsDuJour() {
        LocalDate today = LocalDate.now();

        Predicate<Consultation> enAttente =
                c -> c.getStatus() == ConsultationStatus.EN_ATTENT;

        return consultationDAO.findAll().stream()
                .filter(enAttente)
                .filter(c -> c.getDateConsultation() != null
                        && c.getDateConsultation().toLocalDate().equals(today))
                .sorted(Comparator.comparing(Consultation::getDateConsultation))
                .map(Consultation::getPatientId)
                .distinct()
                .map(patientDAO::findById)
                .filter(Optional::isPresent)
                .map(Optional::get)
                .collect(Collectors.toList());
    }

    public Optional<Patient> trouverParId(Long id) {
        return patientDAO.findById(id);
    }
}