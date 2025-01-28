package model;

import java.sql.Timestamp;

public class Commande {
    private int idCommande;
    private Timestamp date;
    private String statut;
    private int idUtilisateur;
    private String utilisateurNom;
    private boolean paiement;

    // Constructeurs
    public Commande() {}

    public Commande(int idCommande, Timestamp date, String statut, int idUtilisateur, String utilisateurNom) {
        this.idCommande = idCommande;
        this.date = date;
        this.statut = statut;
        this.idUtilisateur = idUtilisateur;
        this.utilisateurNom = utilisateurNom;
    }

    public Commande(int idCommande, Timestamp date, String statut, int idUtilisateur, String utilisateurNom, boolean paiement) {
        this.idCommande = idCommande;
        this.date = date;
        this.statut = statut;
        this.idUtilisateur = idUtilisateur;
        this.utilisateurNom = utilisateurNom;
        this.paiement = paiement;
    }

    // Getters et setters
    public int getIdCommande() {
        return idCommande;
    }

    public void setIdCommande(int idCommande) {
        this.idCommande = idCommande;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public int getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(int idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getUtilisateurNom() {
        return utilisateurNom;
    }

    public void setUtilisateurNom(String utilisateurNom) {
        this.utilisateurNom = utilisateurNom;
    }

    public boolean isPaiement() {
        return paiement;
    }

    public void setPaiement(boolean paiement) {
        this.paiement = paiement;
    }
}
