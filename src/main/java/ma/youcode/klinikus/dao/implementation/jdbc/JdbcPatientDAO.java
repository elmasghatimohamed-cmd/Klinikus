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

public class JdbcPatientDAO implements PatientDAO {

    private DataSource dataSource;

    public JdbcPatientDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Patient save(Patient p) {
        String sql = "INSERT INTO patient (nom, prenom, date_naissance, num_secu, tension, "
                + "frequence_cardiaque, temperature, frequence_respiratoire, date_arrivee) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = dataSource.getConnection();
             PreparedStatement prpr = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            prpr.setString(1, p.getNom());
            prpr.setString(2, p.getPrenom());
            prpr.setDate(3, Date.valueOf(p.getDateNaissance()));
            prpr.setString(4, p.getNumSecu());
            prpr.setString(5, p.getTension());
            prpr.setInt(6, p.getFrequenceCardiaque());
            prpr.setDouble(7, p.getTemperature());
            prpr.setInt(8, p.getFrequenceRespiratoire());
            prpr.setTimestamp(9, Timestamp.valueOf(p.getDateArrivee()));

            prpr.executeUpdate();

            ResultSet keys = prpr.getGeneratedKeys();
            if (keys.next()) {
                p.setId(keys.getLong(1));
            }
            return p;

        } catch (SQLException e) {
            throw new RuntimeException("Error while saving patient", e);
        }
    }

    @Override
    public Optional<Patient> findById(Long id) {
        String sql = "SELECT * FROM patient WHERE id = ?";

        try (Connection con = dataSource.getConnection();
             PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, id);
            ResultSet res = prpr.executeQuery();

            if (res.next()) {
                return Optional.of(mapRow(res));
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