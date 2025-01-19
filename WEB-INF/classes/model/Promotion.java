package model;

import java.util.Date;

public class Promotion {
    private int idPromotion;      // Identifiant de la promotion
    private int idProduit;        // Identifiant du produit
    private String nom;           // Nom du produit
    private String description;   // Description du produit
    private double prix;          // Prix du produit
    private double reduction;     // Pourcentage de réduction
    private Date dateDebut;       // Date de début de la promotion
    private Date dateFin;         // Date de fin de la promotion
    private String image;         // Image associée au produit

    // Constructeurs
    public Promotion() {
        // Constructeur vide
    }

    public Promotion(int idPromotion, int idProduit, String nom, String description, double prix, double reduction, Date dateDebut, Date dateFin, String image) {
        this.idPromotion = idPromotion;
        this.idProduit = idProduit;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.reduction = reduction;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.image = image;
    }

    public Promotion(int idProduit, String nom, String description, double prix, double reduction, Date dateDebut, Date dateFin, String image) {
        this.idProduit = idProduit;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.reduction = reduction;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.image = image;
    }

    // Getters et Setters
    public int getIdPromotion() {
        return idPromotion;
    }

    public void setIdPromotion(int idPromotion) {
        this.idPromotion = idPromotion;
    }

    public int getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(int idProduit) {
        this.idProduit = idProduit;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        if (reduction > 0 && reduction <= 100) {
            this.reduction = reduction;
        } else {
            throw new IllegalArgumentException("La réduction doit être comprise entre 0 et 100.");
        }
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        if (dateFin != null && dateFin.after(dateDebut)) {
            this.dateFin = dateFin;
        } else {
            throw new IllegalArgumentException("La date de fin doit être postérieure à la date de début.");
        }
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // Méthode toString pour afficher les détails de la promotion
    @Override
    public String toString() {
        return "Promotion{" +
                "idPromotion=" + idPromotion +
                ", idProduit=" + idProduit +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", prix=" + prix +
                ", reduction=" + reduction +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                ", image='" + image + '\'' +
                '}';
    }
}
