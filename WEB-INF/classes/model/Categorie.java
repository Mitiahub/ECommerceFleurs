package model;

public class Categorie {
    private int idCategorie;
    private String nom;

    public Categorie(int idCategorie, String nom) {
        this.idCategorie = idCategorie;
        this.nom = nom;
    }

    public int getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(int idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
