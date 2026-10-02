package ma.youcode.klinikus.dao;

import java.util.List;
import java.util.Optional;

import ma.youcode.klinikus.model.Consultation;

public interface ConsultationDAO {

    Consultation save(Consultation consultation);

    Optional findById(Long id);

    Optional findByPatientId(Long patientId);

    List<Consultation> findAll();

    List<Long> findPatientIdsWithConsultation();
}