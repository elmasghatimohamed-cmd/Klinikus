package ma.youcode.klinikus.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Patient {
    private Long id;
    private String nom;
    private String prenom;
    private LocalDate dateNaissance;
    private String numSecu;

    // vital signs stored directly in Patient (per the brief)
    private String tension;
    private Integer frequenceCardiaque;
    private Double temperature;
    private Integer frequenceRespiratoire;

    private LocalDateTime dateArrivee;

    public Patient() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getNumSecu() {
        return numSecu;
    }

    public void setNumSecu(String numSecu) {
        this.numSecu = numSecu;
    }

    public String getTension() {
        return tension;
    }

    public void setTension(String tension) {
        this.tension = tension;
    }

    public Integer getFrequenceCardiaque() {
        return frequenceCardiaque;
    }

    public void setFrequenceCardiaque(Integer f) {
        this.frequenceCardiaque = f;
    }

    public Double getTemperature() {
        return temperature;
    }

    public void setTemperature(Double temperature)

    {
        this.temperature = temperature;
    }

    public Integer getFrequenceRespiratoire() {
        return frequenceRespiratoire;
    }

    public void setFrequenceRespiratoire(Integer f) {
        this.frequenceRespiratoire = f;
    }

    public LocalDateTime getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(LocalDateTime dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

}