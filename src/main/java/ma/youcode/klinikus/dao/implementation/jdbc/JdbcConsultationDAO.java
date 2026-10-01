package ma.youcode.klinikus.dao.implementation.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.sql.DataSource;

import ma.youcode.klinikus.dao.ConsultationDAO;
import ma.youcode.klinikus.model.Consultation;
import ma.youcode.klinikus.model.enums.ConsultationStatus;

public class JdbcConsultationDAO implements ConsultationDAO {

    private final DataSource dataSource;

    public JdbcConsultationDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public Consultation save(Consultation consultation) {
        String sql = "INSERT INTO consultation (patient_id, medecin_id, motif, observations, diagnostic, traitement, cout, status, date_consultation) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            prpr.setLong(1, consultation.getPatientId());
            prpr.setLong(2, consultation.getMedecinId());
            prpr.setString(3, consultation.getMotif());
            prpr.setString(4, consultation.getObservations());
            prpr.setString(5, consultation.getDiagnostic());
            prpr.setString(6, consultation.getTraitement());
            prpr.setDouble(7, consultation.getCout());
            prpr.setString(8, consultation.getStatus().name());
            prpr.setTimestamp(9, Timestamp.valueOf(consultation.getDateConsultation()));

            prpr.executeUpdate();

            try (ResultSet keys = prpr.getGeneratedKeys()) {
                if (keys.next()) {
                    consultation.setId(keys.getLong(1));
                }
            }
            return consultation;

        } catch (SQLException e) {
            throw new RuntimeException("Error saving consultation", e);
        }
    }

    @Override
    public Optional findById(Long id) {
        String sql = "SELECT * FROM consultation WHERE id = ?";
        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, id);

            try (ResultSet rs = prpr.executeQuery()) {
                return rs.next() ? Optional.of(mapRow(rs)) : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding consultation by id", e);
        }
    }

    @Override
    public Optional findByPatientId(Long patientId) {
        String sql = "SELECT * FROM consultation WHERE patient_id = ?";
        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, patientId);

            try (ResultSet rs = prpr.executeQuery()) {
                return rs.next() ? Optional.of(mapRow(rs)) : Optional.empty();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error finding consultation by patientId", e);
        }
    }

    @Override
    public List findAll() {
        List list = new ArrayList<>();
        String sql = "SELECT * FROM consultation";

        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql);
                ResultSet rs = prpr.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
            return list;

        } catch (SQLException e) {
            throw new RuntimeException("Error listing consultations", e);
        }
    }

    private Consultation mapRow(ResultSet rs) throws SQLException {
        Consultation c = new Consultation();
        c.setId(rs.getLong("id"));
        c.setPatientId(rs.getLong("patient_id"));
        c.setMedecinId(rs.getLong("medecin_id"));
        c.setMotif(rs.getString("motif"));
        c.setObservations(rs.getString("observations"));
        c.setDiagnostic(rs.getString("diagnostic"));
        c.setTraitement(rs.getString("traitement"));
        c.setCout(rs.getDouble("cout"));
        c.setStatus(ConsultationStatus.valueOf(rs.getString("status")));
        c.setDateConsultation(rs.getTimestamp("date_consultation").toLocalDateTime());
        return c;
    }
}