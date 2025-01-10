package model;

public class Produit {
    private int idProduit;
    private String nom;
    private String description;
    private double prix;
    private int idCategorie;
    private int stock;
    private String image;

    // Constructeur par défaut (nécessaire pour certains frameworks ou utilisations)
    public Produit() {}

    // Constructeur complet (utilisé pour modifier ou récupérer des produits)
    public Produit(int idProduit, String nom, String description, double prix, int idCategorie, int stock, String image) {
        this.idProduit = idProduit;
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.idCategorie = idCategorie;
        this.stock = stock;
        this.image = image;
    }

    // Constructeur sans idProduit (utilisé pour ajouter un produit)
    public Produit(String nom, String description, double prix, int idCategorie, int stock, String image) {
        this.nom = nom;
        this.description = description;
        this.prix = prix;
        this.idCategorie = idCategorie;
        this.stock = stock;
        this.image = image;
    }

    // Getters et Setters
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

    public int getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(int idCategorie) {
        this.idCategorie = idCategorie;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    // Méthode utilitaire pour afficher les informations du produit
    @Override
    public String toString() {
        return "Produit{" +
                "idProduit=" + idProduit +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", prix=" + prix +
                ", idCategorie=" + idCategorie +
                ", stock=" + stock +
                ", image='" + image + '\'' +
                '}';
    }
}
