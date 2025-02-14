package model;

import java.sql.Timestamp;

public class HistoriquePrix {
    private int idHistoriquePrix; // Ajoutez cet ID si nécessaire
    private int idProduit;
    private double ancienPrix;
    private double nouveauPrix;
    private Timestamp dateModification;

    // Constructeur avec 5 paramètres
    public HistoriquePrix(int idHistoriquePrix, int idProduit, double ancienPrix, double nouveauPrix, Timestamp dateModification) {
        this.idHistoriquePrix = idHistoriquePrix;
        this.idProduit = idProduit;
        this.ancienPrix = ancienPrix;
        this.nouveauPrix = nouveauPrix;
        this.dateModification = dateModification;
    }

    // Getters
    public int getIdHistoriquePrix() { return idHistoriquePrix; }
    public int getIdProduit() { return idProduit; }
    public double getAncienPrix() { return ancienPrix; }
    public double getNouveauPrix() { return nouveauPrix; }
    public Timestamp getDateModification() { return dateModification; }
}
