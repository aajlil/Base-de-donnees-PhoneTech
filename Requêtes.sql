-- 1) Montant total d'une commande
SELECT lc.id_commande, SUM(lc.prix * lc.quantite) AS montant_total
FROM ligne_commande lc
GROUP BY lc.id_commande;

/*  id_commande |   montant_total    
-------------+--------------------
           9 |             559.99
           3 |             359.98
           5 | 4019.9700000000003
           4 |             599.99
          10 |             339.99
           6 |             299.99
           2 |             489.99
           7 |             489.99
           1 |             299.99
           8 |             179.99
(10 lignes)
*/

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- 2) Donne le chiffre d’affaires d’aujourd'hui
SELECT SUM(prix * quantite) AS CA_jour
FROM ligne_commande lc
JOIN commande c ON lc.id_commande = c.id_commande
WHERE date_achat = CURRENT_DATE;

/*
 ca_jour 
---------
(CA selon le jour)    

*/

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- 3) Retourne la liste des commandes à expédier aujourd'hui
SELECT c.id_commande, u.nom AS client, u.email, COUNT(lc.id_telephone) AS nb_articles, SUM(lc.prix * lc.quantite) AS montant_total
FROM commande c INNER JOIN utilisateur u ON c.id_utilisateur = u.id_utilisateur
INNER JOIN ligne_commande lc ON c.id_commande = lc.id_commande
WHERE c.id_etat = 2 
GROUP BY (c.id_commande, u.nom, u.email);

/*
 id_commande | client  |        email         | nb_articles | montant_total 
-------------+---------+----------------------+-------------+---------------
           2 | Henry   | gwen07@yahoo.com     |           1 |        489.99
           6 | Barbier | quincy17@gmail.com   |           1 |        299.99
          10 | Faure   | julien10@hotmail.com |           1 |        339.99
(3 lignes)
*/

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- 4) Le nom, email des utilisateurs ayant ajouté un téléphone à leur panier
SELECT u.nom, u.email, tp.nom_telephone
FROM utilisateur u INNER JOIN ligne_panier lp ON u.id_utilisateur = lp.id_utilisateur
INNER JOIN telephone tp ON lp.id_telephone = tp.id_telephone;

/*
   nom    |         email         |    nom_telephone     
----------+-----------------------+----------------------
 Martin   | bob02@gmail.com       | iPhone 14 Pro
 Noel     | laura38@outlook.com   | Samsung Galaxy S23
 Petit    | carla03@gmail.com     | Google Pixel 7
 Lefevre  | david04@gmail.com     | Xiaomi 13 Pro
 Mercier  | olivier15@hotmail.com | OnePlus 11
 Moreau   | felix06@gmail.com     | iPhone 13
 Perrot   | tina20@gmail.com      | Samsung A54
 Gauthier | hugo08@hotmail.com    | Google Pixel 6a
 Langlois | victor48@gmail.com    | Xiaomi Redmi Note 12
 Barbier  | quincy17@gmail.com    | OnePlus Nord CE 3
(10 lignes)
*/

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- 5) Crée une vue qui calcule la moyenne des prix des téléphones pour chaque type de téléphone. Sélectionne le nom et prix des télephones dont le prix est supérieur à la moyenne pour leur type de téléphone respectif
CREATE VIEW moyenne_prix_par_type AS
SELECT t.id_type_telephone, AVG(t.prix_telephone) AS prix_moyen
FROM telephone t
GROUP BY t.id_type_telephone;

SELECT t.nom_telephone, t.prix_telephone
FROM telephone t INNER JOIN moyenne_prix_par_type mp ON t.id_type_telephone = mp.id_type_telephone
WHERE t.prix_telephone > mp.prix_moyen;

/*
     nom_telephone      | prix_telephone 
------------------------+----------------
 iPhone 14 Pro          |        1329.99
 Samsung Galaxy S23     |         959.99
 Google Pixel 7         |         649.99
 Xiaomi 13 Pro          |         899.99
 iPhone 13              |         909.99
 Samsung A54            |         499.99
 Google Pixel 6a        |         459.99
 iPhone SE 2022         |         559.99
 Google Pixel Fold      |        1799.99
 Xiaomi Mix Fold 2      |        1499.99
 OnePlus Open           |        1399.99
 iPhone XR              |         489.99
 iPhone 12 Mini         |         659.99
 iPhone 11              |         589.99
 Samsung Galaxy S21     |         699.99
 OnePlus 9              |         549.99
 Samsung Galaxy Note 20 |         849.99
 Motorola Edge 30       |         449.99
 Asus ROG Phone 6       |         999.99
(19 lignes)
*/


----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- 6) Recherche le nom et email des utilisateurs qui n'ont jamais passé de commande dans un état "En cours de traitement"
SELECT u.nom, u.email
FROM utilisateur u
WHERE u.id_utilisateur NOT IN ( SELECT c.id_utilisateur
    					   FROM commande c 
					   INNER JOIN etat e ON c.id_etat = e.id_etat
    					   WHERE e.libelle = 'En cours de traitement');
    					   
/*
     nom     |         email         
-------------+-----------------------
 Dupont      | alice01@gmail.com
 Martin      | bob02@gmail.com
 Petit       | carla03@gmail.com
 Lefevre     | david04@gmail.com
 Lemoine     | emma05@gmail.com
 Moreau      | felix06@gmail.com
 Gauthier    | hugo08@hotmail.com
 Garnier     | ines09@gmail.com
 Girard      | kevin11@gmail.com
 Chevalier   | lea12@outlook.com
 Roger       | mathis13@gmail.com
 André       | nina14@hotmail.com
 Mercier     | olivier15@hotmail.com
 Lefevre     | paul16@gmail.com
 Meunier     | rose18@hotmail.com
 Marchand    | sami19@yahoo.com
 Perrot      | tina20@gmail.com
 Giraud      | ugo21@gmail.com
 Noel        | val22@gmail.com
 Texier      | willy23@gmail.com
 Moulin      | xena24@yahoo.com
 Collin      | yani25@gmail.com
 Lopes       | zoe26@gmail.com
 Henry       | alex27@gmail.com
 Rousseau    | bella28@icloud.com
 Blin        | charles29@icloud.com
 Adam        | diane30@icloud.com
 Dubois      | eliott31@yahoo.com
 Clement     | fanny32@icloud.com
 Pires       | gael33@gmail.com
 Cohen       | hana34@outlook.com
 Navarro     | ian35@gmail.com
 Poirier     | jade36@yahoo.com
 Muller      | karim37@icloud.com
 Noel        | laura38@outlook.com
 Renard      | max39@gmail.com
 Leclerc     | nora40@outlook.com
 Robin       | omar41@hotmail.com
 Marin       | paula42@outlook.com
 Bailly      | quentin43@yahoo.com
 Pelletier   | romy44@gmail.com
 Roussel     | sam45@yahoo.com
 Masson      | thais46@gmail.com
 Charpentier | ursula47@yahoo.com
 Langlois    | victor48@gmail.com
 Germain     | wassim49@gmail.com
 Rey         | yasmine50@gmail.com
(47 lignes)

*/					   
    					   
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------    					   
    					   
-- 7) Le nom et email des utilisateurs qui ont acheté un téléphone de couleur "Bleu"
SELECT u.nom, u.email
FROM utilisateur u
WHERE u.id_utilisateur IN ( SELECT c.id_utilisateur
  			    FROM commande c INNER JOIN ligne_commande lc ON c.id_commande = lc.id_commande
			    INNER JOIN telephone t ON lc.id_telephone = t.id_telephone
    		            INNER JOIN couleur co ON t.id_couleur = co.id_couleur
    		            WHERE co.libelle_couleur = 'Bleu' );
    		            
/*
   nom    |       email        
----------+--------------------
 Clement  | fanny32@icloud.com
 Gauthier | hugo08@hotmail.com
(2 lignes)
*/	
    				 
    				 
    				 
    				 
    				 
