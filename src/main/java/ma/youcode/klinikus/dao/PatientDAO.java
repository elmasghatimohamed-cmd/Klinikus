package ma.youcode.klinikus.dao;

import ma.youcode.klinikus.model.Patient;
import java.util.List;
import java.util.Optional;

public interface PatientDAO {

    Patient save(Patient patient);
    Optional<Patient> findById(Long id);
    List<Patient> findAll();
}
