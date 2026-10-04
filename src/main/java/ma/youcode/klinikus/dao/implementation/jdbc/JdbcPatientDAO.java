package ma.youcode.klinikus.dao.implementation.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.sql.DataSource;

import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

public class JdbcPatientDAO implements PatientDAO {

    private final DataSource dataSource;

    public JdbcPatientDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Patient save(Patient p) {
        String patientSql = "INSERT INTO patient (nom, prenom, date_naissance, num_secu, tension, "
                + "frequence_cardiaque, temperature, frequence_respiratoire, date_arrivee) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String consultationSql = "INSERT INTO consultation (patient_id, statut, date_consultation) "
                + "VALUES (?, ?, ?)";

        try (Connection con = dataSource.getConnection()) {
            con.setAutoCommit(false);
            try {
                try (PreparedStatement ps = con.prepareStatement(patientSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, p.getNom());
                    ps.setString(2, p.getPrenom());
                    ps.setDate(3, Date.valueOf(p.getDateNaissance()));
                    ps.setString(4, p.getNumSecu());
                    ps.setString(5, p.getTension());
                    ps.setInt(6, p.getFrequenceCardiaque());
                    ps.setDouble(7, p.getTemperature());
                    ps.setInt(8, p.getFrequenceRespiratoire());
                    ps.setTimestamp(9, Timestamp.valueOf(p.getDateArrivee()));
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (keys.next()) {
                            p.setId(keys.getLong(1));
                        } else {
                            throw new SQLException("Aucun ID genere pour le patient");
                        }
                    }
                }

                try (PreparedStatement ps = con.prepareStatement(consultationSql)) {
                    ps.setLong(1, p.getId());
                    ps.setString(2, ConsultationStatus.EN_ATTENT.name());
                    ps.setTimestamp(3, Timestamp.valueOf(p.getDateArrivee()));
                    ps.executeUpdate();
                }

                con.commit();
                return p;

            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error while saving patient and its initial consultation", e);
        }
    }

    @Override
    public Optional<Patient> findById(Long id) {
        String sql = "SELECT * FROM patient WHERE id = ?";

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, id);
            try (ResultSet res = prpr.executeQuery()) {
                if (res.next()) {
                    return Optional.of(mapRow(res));
                }
            }
            return Optional.empty();

        } catch (SQLException e) {
            throw new RuntimeException("Error while finding patient", e);
        }
    }

    @Override
    public List<Patient> findAll() {
        String sql = "SELECT * FROM patient";
        List<Patient> patients = new ArrayList<>();

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql);
                ResultSet res = prpr.executeQuery()) {

            while (res.next()) {
                patients.add(mapRow(res));
            }
            return patients;

        } catch (SQLException e) {
            throw new RuntimeException("Error while listing patients", e);
        }
    }

    private Patient mapRow(ResultSet res) throws SQLException {
        Patient p = new Patient();
        p.setId(res.getLong("id"));
        p.setNom(res.getString("nom"));
        p.setPrenom(res.getString("prenom"));
        p.setDateNaissance(res.getDate("date_naissance").toLocalDate());
        p.setNumSecu(res.getString("num_secu"));
        p.setTension(res.getString("tension"));
        p.setFrequenceCardiaque(res.getInt("frequence_cardiaque"));
        p.setTemperature(res.getDouble("temperature"));
        p.setFrequenceRespiratoire(res.getInt("frequence_respiratoire"));
        p.setDateArrivee(res.getTimestamp("date_arrivee").toLocalDateTime());
        return p;
    }
}