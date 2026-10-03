package ma.youcode.klinikus.dao;

import java.util.List;
import java.util.Optional;

import ma.youcode.klinikus.model.Consultation;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

public interface ConsultationDAO {

    Consultation save(Consultation consultation);
    
    Consultation update(Consultation consultation);

    Optional<Consultation> findById(Long id);

    Optional<Consultation> findByPatientId(Long patientId);

    List<Consultation> findAll();

    List<Long> findPatientIdsWithConsultation();


    List<Long> findPatientIdsByStatus(ConsultationStatus status);

}