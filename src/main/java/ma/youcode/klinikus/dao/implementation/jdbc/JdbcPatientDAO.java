package ma.youcode.klinikus.dao.implementation;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.sql.DataSource;

import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;

public class JdbcPatientDAO implements PatientDAO {

    private final DataSource dataSource;

    public JdbcPatientDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Patient save(Patient p) {
        String sql = "INSERT INTO patient (nom, prenom, date_naissance, num_secu, tension, " +
                "frequence_cardiaque, temperature, frequence_respiratoire, date_arrivee) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setString(1, p.getNom());
            prpr.setString(2, p.getPrenom());
            prpr.setDate(3, Date.valueOf(p.getDateNaissance()));
            prpr.setString(4, p.getNumSecu());
            prpr.setString(5, p.getTension());
            prpr.setObject(6, p.getFrequenceCardiaque(), Types.INTEGER);
            prpr.setObject(7, p.getTemperature(), Types.NUMERIC);
            prpr.setObject(8, p.getFrequenceRespiratoire(), Types.INTEGER);
            prpr.setTimestamp(9, Timestamp.valueOf(p.getDateArrivee()));
            prpr.executeUpdate();

            try (ResultSet keys = prpr.getGeneratedKeys()) {
                if (keys.next())
                    p.setId(keys.getLong(1));
            }
            return p;

        } catch (SQLException e) {
            throw new RuntimeException("Error saving patient", e);
        }
    }

    @Override
    public Optional<Patient> findById(Long id) {
        String sql = "SELECT * FROM patient WHERE id = ?";

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, id);

            try (ResultSet rs = prpr.executeQuery()) {
                return rs.next()
                        ? Optional.of(mapRow(rs))
                        : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding patient", e);
        }
    }

    
    @Override
    public List<Patient> findAll() {
        List<Patient> list = new ArrayList<>();
        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement("SELECT * FROM patient");
                ResultSet rs = prpr.executeQuery()) {

            while (rs.next())
                list.add(mapRow(rs));
            return list;

        } catch (SQLException e) {
            throw new RuntimeException("Error listing patients", e);
        }
    }

    private Optional<Patient> findOne(String sql, Object param) {
        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setObject(1, param);
            try (ResultSet rs = prpr.executeQuery()) {
                return rs.next() ? Optional.of(mapRow(rs)) : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding patient", e);
        }
    }

    private Patient mapRow(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setId(rs.getLong("id"));
        p.setNom(rs.getString("nom"));
        p.setPrenom(rs.getString("prenom"));
        p.setDateNaissance(rs.getDate("date_naissance").toLocalDate());
        p.setNumSecu(rs.getString("num_secu"));
        p.setTension(rs.getString("tension"));
        p.setFrequenceCardiaque((Integer) rs.getObject("frequence_cardiaque"));
        p.setTemperature(rs.getObject("temperature") == null ? null : rs.getDouble("temperature"));
        p.setFrequenceRespiratoire((Integer) rs.getObject("frequence_respiratoire"));
        p.setDateArrivee(rs.getTimestamp("date_arrivee").toLocalDateTime());
        return p;
    }
}