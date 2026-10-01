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
    public Consultation save(Consultation c) {
        String sql = "INSERT INTO consultation (patient_id, medecin_id, motif, observations, diagnostic, traitement, cout, statut, date_consultation) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, c.getPatientId());
            ps.setLong(2, c.getMedecinId());
            ps.setString(3, c.getMotif());
            ps.setString(4, c.getObservations());
            ps.setString(5, c.getDiagnostic());
            ps.setString(6, c.getTraitement());
            ps.setDouble(7, c.getCout());
            ps.setString(8, c.getStatus() != null ? c.getStatus().name() : ConsultationStatus.EN_ATTENT.name());
            ps.setTimestamp(9, c.getDateConsultation() != null ? Timestamp.valueOf(c.getDateConsultation())
                    : new Timestamp(System.currentTimeMillis()));

            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    c.setId(rs.getLong(1));
                }
            }
            return c;

        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la sauvegarde de la consultation", e);
        }
    }

    @Override
    public Optional<Consultation> findById(Long id) {
        String sql = "SELECT * FROM consultation WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToConsultation(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la recherche de la consultation par ID", e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<Consultation> findByPatientId(Long patientId) {
        String sql = "SELECT * FROM consultation WHERE patient_id = ?";
        try (Connection con = dataSource.getConnection();
                PreparedStatement prpr = con.prepareStatement(sql)) {

            prpr.setLong(1, patientId);
            try (ResultSet rs = prpr.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToConsultation(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la recherche de la consultation par ID patient", e);
        }
        return Optional.empty();
    }

    @Override
    public List<Consultation> findAll() {
        List<Consultation> list = new ArrayList<>();
        String sql = "SELECT * FROM consultation";
        try (Connection conn = dataSource.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapResultSetToConsultation(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la récupération des consultations", e);
        }
        return list;
    }

    @Override
    public List findPatientIdsWithConsultation() {
        List patientIds = new ArrayList<>();
        String sql = "SELECT DISTINCT patient_id FROM consultation";
        try (Connection conn = dataSource.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                patientIds.add(rs.getLong("patient_id"));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erreur lors de la récupération des IDs des patients avec consultation", e);
        }
        return patientIds;
    }

    private Consultation mapResultSetToConsultation(ResultSet rs) throws SQLException {
        Consultation c = new Consultation();
        c.setId(rs.getLong("id"));
        c.setPatientId(rs.getLong("patient_id"));
        c.setMedecinId(rs.getLong("medecin_id"));
        c.setMotif(rs.getString("motif"));
        c.setObservations(rs.getString("observations"));
        c.setDiagnostic(rs.getString("diagnostic"));
        c.setTraitement(rs.getString("traitement"));
        c.setCout(rs.getDouble("cout"));
        c.setStatus(ConsultationStatus.valueOf(rs.getString("statut")));

        Timestamp ts = rs.getTimestamp("date_consultation");
        if (ts != null) {
            c.setDateConsultation(ts.toLocalDateTime());
        }
        return c;
    }
}