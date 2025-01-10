CREATE OR REPLACE FUNCTION update_stock_after_order()
RETURNS TRIGGER AS $$
BEGIN
    -- Réduit le stock du produit commandé
    UPDATE Produit
    SET stock = stock - NEW.quantite
    WHERE id_produit = NEW.id_produit;

    -- Vérifie si le stock devient négatif (ne devrait jamais arriver)
    IF (SELECT stock FROM Produit WHERE id_produit = NEW.id_produit) < 0 THEN
        RAISE EXCEPTION 'Stock insuffisant pour le produit %', NEW.id_produit;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_stock_after_order
AFTER INSERT ON Contient
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_order();


CREATE OR REPLACE FUNCTION check_stock_before_order()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifie le stock disponible
    IF (SELECT stock FROM Produit WHERE id_produit = NEW.id_produit) < NEW.quantite THEN
        RAISE EXCEPTION 'Stock insuffisant pour le produit %', NEW.id_produit;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_stock_before_order
BEFORE INSERT ON Contient
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_order();


CREATE OR REPLACE FUNCTION log_user_actions()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Logs (action, id_utilisateur, date)
    VALUES (TG_OP || ' sur ' || TG_TABLE_NAME, NEW.id_utilisateur, CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_user_actions
AFTER INSERT OR UPDATE ON Commande
FOR EACH ROW
EXECUTE FUNCTION log_user_actions();

CREATE TRIGGER trigger_log_user_reviews
AFTER INSERT OR UPDATE ON Avis
FOR EACH ROW
EXECUTE FUNCTION log_user_actions();

CREATE OR REPLACE FUNCTION archive_completed_orders()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.statut = 'livré' THEN
        INSERT INTO Archives_Commande
        SELECT * FROM Commande WHERE id_commande = NEW.id_commande;

        DELETE FROM Commande WHERE id_commande = NEW.id_commande;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION archive_completed_orders()
RETURNS TRIGGER AS $$
BEGIN
    -- Insérer la commande dans la table d'archives
    INSERT INTO Archives_Commande (id_commande, date, id_utilisateur, statut)
    SELECT id_commande, date, id_utilisateur, statut
    FROM Commande
    WHERE id_commande = NEW.id_commande;

    -- Supprimer la commande de la table actuelle
    DELETE FROM Commande WHERE id_commande = NEW.id_commande;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_archive_completed_orders
AFTER UPDATE OF statut ON Commande
FOR EACH ROW
WHEN (NEW.statut = 'livré')
EXECUTE FUNCTION archive_completed_orders();

