package ma.youcode.klinikus.dao.implementation.jdbc;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import ma.youcode.klinikus.dao.PatientDAO;
import ma.youcode.klinikus.model.Patient;
public class JdbcPatientDAO implements PatientDAO{
    private final DataSource dataSource;
    public JdbcPatientDAO(DataSource dataSource){
        this.dataSource = dataSource;
    }


    @Override 
    public Patient save(Patient p){
        String sql = "INSERT INTO patient (nom, prenom, date_naissance, num_secu, tension, frequence_cardiaque, temperatue, frequence_respiratoire, date_arrivee) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = dataSource.getConnection()){
            PreparedStatement
        } catch (Exception e) {
            // TODO: handle exception
        }
    }
}
