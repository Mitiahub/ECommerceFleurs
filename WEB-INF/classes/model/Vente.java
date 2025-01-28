package model;

import java.util.Date;

public class Vente {
    private int idVente;
    private int idUtilisateur;
    private int idProduit;
    private int quantite;
    private double montant;
    private Date dateVente;

    public Vente(int idVente, int idUtilisateur, int idProduit, int quantite, double montant, Date dateVente) {
        this.idVente = idVente;
        this.idUtilisateur = idUtilisateur;
        this.idProduit = idProduit;
        this.quantite = quantite;
        this.montant = montant;
        this.dateVente = dateVente;
    }

    public int getIdVente() { return idVente; }
    public int getIdUtilisateur() { return idUtilisateur; }
    public int getIdProduit() { return idProduit; }
    public int getQuantite() { return quantite; }
    public double getMontant() { return montant; }
    public Date getDateVente() { return dateVente; }
}
