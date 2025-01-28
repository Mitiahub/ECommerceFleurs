package model;

public class CommandeStatut {
    public static final String EN_COURS = "en cours";
    public static final String LIVRE = "livré";
    public static final String ANNULE = "annulé";

    // Méthode utilitaire pour valider si un statut est valide
    public static boolean isValidStatut(String statut) {
        return EN_COURS.equals(statut) || LIVRE.equals(statut) || ANNULE.equals(statut);
    }
}
