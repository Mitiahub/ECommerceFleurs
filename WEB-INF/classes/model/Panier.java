package model;

import java.util.HashMap;
import java.util.Map;

public class Panier {
    private Map<Produit, Integer> produits;

    public Panier() {
        this.produits = new HashMap<>();
    }

    // Ajouter un produit au panier
    public void ajouterProduit(Produit produit, int quantite) {
        this.produits.put(produit, this.produits.getOrDefault(produit, 0) + quantite);
    }

    // Supprimer un produit du panier
    public void supprimerProduit(Produit produit) {
        this.produits.remove(produit);
    }

    // Obtenir le contenu du panier
    public Map<Produit, Integer> getProduits() {
        return produits;
    }

    // Calculer le prix total
    public double calculerPrixTotal() {
        double total = 0.0;
        for (Map.Entry<Produit, Integer> entry : produits.entrySet()) {
            total += entry.getKey().getPrix() * entry.getValue();
        }
        return total;
    }
}
