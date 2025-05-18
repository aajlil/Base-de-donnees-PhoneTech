------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------

drop schema if exists phoneTech cascade;
create schema phoneTech;
set search_path to phoneTech;

-- +----------------------------------------------------------------------------------------------+
-- | Tables drop                                                                                  |
-- +----------------------------------------------------------------------------------------------

drop table if exists utilisateur;
drop table if exists etat;
drop table if exists commande;
drop table if exists couleur;
drop table if exists type_telephone;
drop table if exists telephone;
drop table if exists effectuer;
drop table if exists ligne_panier;
drop table if exists ligne_commande;



------------------------------------------------------------
-- Table: utilisateur
------------------------------------------------------------
CREATE TABLE utilisateur(
	id_utilisateur   SERIAL NOT NULL ,
	login            VARCHAR (50) NOT NULL ,
	email            VARCHAR (50) NOT NULL ,
	nom              VARCHAR (50) NOT NULL ,
	pwd         VARCHAR (32) NOT NULL ,
	user_role        VARCHAR (32) NOT NULL  ,
	CONSTRAINT utilisateur_PK PRIMARY KEY (id_utilisateur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: etat
------------------------------------------------------------
CREATE TABLE etat(
	id_etat   SERIAL NOT NULL ,
	libelle   VARCHAR (32) NOT NULL  ,
	CONSTRAINT etat_PK PRIMARY KEY (id_etat)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: commande
------------------------------------------------------------
CREATE TABLE commande(
	id_commande      SERIAL NOT NULL ,
	date_achat       DATE  NOT NULL ,
	id_utilisateur   INT  NOT NULL ,
	id_etat          INT  NOT NULL  ,
	CONSTRAINT commande_PK PRIMARY KEY (id_commande)

	,CONSTRAINT commande_utilisateur_FK FOREIGN KEY (id_utilisateur) REFERENCES  utilisateur(id_utilisateur)
	,CONSTRAINT commande_etat0_FK FOREIGN KEY (id_etat) REFERENCES etat(id_etat)
)WITHOUT OIDS;



------------------------------------------------------------
-- Table: couleur
------------------------------------------------------------
CREATE TABLE couleur(
	id_couleur        SERIAL NOT NULL ,
	libelle_couleur   VARCHAR (32) NOT NULL  ,
	CONSTRAINT couleur_PK PRIMARY KEY (id_couleur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: type_telephone
------------------------------------------------------------
CREATE TABLE type_telephone(
	id_type_telephone        SERIAL NOT NULL ,
	libelle_type_telephone   VARCHAR (32) NOT NULL  ,
	CONSTRAINT type_telephone_PK PRIMARY KEY (id_type_telephone)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: telephone
------------------------------------------------------------
CREATE TABLE telephone(
	id_telephone        SERIAL NOT NULL ,
	nom_telephone       VARCHAR (32) NOT NULL ,
	poids               FLOAT8  NOT NULL ,
	taille              INTEGER  NOT NULL ,
	prix_telephone      FLOAT8  NOT NULL ,
	fournisseur         VARCHAR (32) NOT NULL ,
	marque              VARCHAR (32) NOT NULL ,
	id_couleur          INT  NOT NULL ,
	id_type_telephone   INT  NOT NULL  ,
	CONSTRAINT telephone_PK PRIMARY KEY (id_telephone)

	,CONSTRAINT telephone_couleur_FK FOREIGN KEY (id_couleur) REFERENCES couleur(id_couleur)
	,CONSTRAINT telephone_type_telephone0_FK FOREIGN KEY (id_type_telephone) REFERENCES type_telephone(id_type_telephone)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: effectuer
------------------------------------------------------------
CREATE TABLE effectuer(
	id_commande      INT  NOT NULL ,
	id_utilisateur   INT  NOT NULL  ,
	CONSTRAINT effectuer_PK PRIMARY KEY (id_commande,id_utilisateur)

	,CONSTRAINT effectuer_commande_FK FOREIGN KEY (id_commande) REFERENCES commande(id_commande)
	,CONSTRAINT effectuer_utilisateur0_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: ligne_panier
------------------------------------------------------------
CREATE TABLE ligne_panier(
	id_telephone     INT  NOT NULL ,
	id_utilisateur   INT  NOT NULL ,
	quantite         INTEGER  NOT NULL ,
	date_ajout       DATE  NOT NULL  ,
	CONSTRAINT ligne_panier_PK PRIMARY KEY (id_telephone,id_utilisateur)

	,CONSTRAINT ligne_panier_telephone_FK FOREIGN KEY (id_telephone) REFERENCES telephone(id_telephone)
	,CONSTRAINT ligne_panier_utilisateur0_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: ligne_commande
------------------------------------------------------------
CREATE TABLE ligne_commande(
	id_telephone   INT  NOT NULL ,
	id_commande    INT  NOT NULL ,
	prix           FLOAT8  NOT NULL ,
	quantite       INTEGER  NOT NULL  ,
	CONSTRAINT ligne_commande_PK PRIMARY KEY (id_telephone,id_commande)

	,CONSTRAINT ligne_commande_telephone_FK FOREIGN KEY (id_telephone) REFERENCES telephone(id_telephone)
	,CONSTRAINT ligne_commande_commande0_FK FOREIGN KEY (id_commande) REFERENCES commande(id_commande)
)WITHOUT OIDS;



-- +----------------------------------------------------------------------------------------------+
-- | Insertions                                                                                 |
-- +----------------------------------------------------------------------------------------------


-- Insertion des couleur
INSERT INTO couleur (id_couleur, libelle_couleur) VALUES 
(1, 'Noir'), 
(2, 'Blanc'), 
(3, 'Bleu'), 
(4, 'Rouge'), 
(5, 'Vert'),
(6, 'Rose'),
(7, 'gris');



-- Insertion des types
INSERT INTO type_telephone (id_type_telephone, libelle_type_telephone) VALUES 
(1, 'Clapet'), 
(2, 'Smartphone'), 
(3, 'Fixe');


-- Insertion des utilisateurs
INSERT INTO utilisateur(id_utilisateur, login, email, nom, pwd, user_role) VALUES
(1, 'alice01', 'alice01@gmail.com', 'Dupont', 'dupontdu92', 'client'),
(2, 'bob02', 'bob02@gmail.com', 'Martin', 'bobb124', 'client'),
(3, 'carla03', 'carla03@gmail.com', 'Petit', '1234', 'admin'),
(4, 'david04', 'david04@gmail.com', 'Lefevre', 'davlefevre93', 'admin'),
(5, 'emma05', 'emma05@gmail.com', 'Lemoine', 'emma44', 'client'),
(6, 'felix06', 'felix06@gmail.com', 'Moreau', 'felmor77', 'client'),
(7, 'gwen07', 'gwen07@yahoo.com', 'Henry', 'bbd11', 'client'),
(8, 'hugo08', 'hugo08@hotmail.com', 'Gauthier', 'mont54d', 'client'),
(9, 'ines09', 'ines09@gmail.com', 'Garnier', 'ooutty', 'client'),
(10, 'julien10', 'julien10@hotmail.com', 'Faure', 'yess855', 'client'),
(11, 'kevin11', 'kevin11@gmail.com', 'Girard', 'number1', 'client'),
(12, 'lea12', 'lea12@outlook.com', 'Chevalier', 'sffef', 'client'),
(13, 'mathis13', 'mathis13@gmail.com', 'Roger', 'pass123', 'client'),
(14, 'nina14', 'nina14@hotmail.com', 'André', 'pass173', 'client'),
(15, 'olivier15', 'olivier15@hotmail.com', 'Mercier', 'pass123', 'admin'),
(16, 'paul16', 'paul16@gmail.com', 'Lefevre', 'pass5553', 'client'),
(17, 'quincy17', 'quincy17@gmail.com', 'Barbier', 'pwd723', 'client'),
(18, 'rose18', 'rose18@hotmail.com', 'Meunier', 'qdqe', 'client'),
(19, 'sami19', 'sami19@yahoo.com', 'Marchand', '4455f', 'client'),
(20, 'tina20', 'tina20@gmail.com', 'Perrot', 'dfee4', 'client'),
(21, 'ugo21', 'ugo21@gmail.com', 'Giraud', 'qDSdsqf5', 'client'),
(22, 'val22', 'val22@gmail.com', 'Noel', 'sfvsdqfd', 'client'),
(23, 'willy23', 'willy23@gmail.com', 'Texier', 'vvv41d', 'client'),
(24, 'xena24', 'xena24@yahoo.com', 'Moulin', 'dfdfqq56', 'client'),
(25, 'yani25', 'yani25@gmail.com', 'Collin', 'hjthr11', 'client'),
(26, 'zoe26', 'zoe26@gmail.com', 'Lopes', 'rfgrg84', 'client'),
(27, 'alex27', 'alex27@gmail.com', 'Henry', 'dsgr41', 'client'),
(28, 'bella28', 'bella28@icloud.com', 'Rousseau', 'sgs30', 'admin'),
(29, 'charles29', 'charles29@icloud.com', 'Blin', 'charles44', 'client'),
(30, 'diane30', 'diane30@icloud.com', 'Adam', 'dianeeee1', 'client'),
(31, 'eliott31', 'eliott31@yahoo.com', 'Dubois', 'fqsfqsdf', 'client'),
(32, 'fanny32', 'fanny32@icloud.com', 'Clement', 'qgrg', 'client'),
(33, 'gael33', 'gael33@gmail.com', 'Pires', 'rthrg', 'client'),
(34, 'hana34', 'hana34@outlook.com', 'Cohen', 'rgrrgr', 'client'),
(35, 'ian35', 'ian35@gmail.com', 'Navarro', 'grgsd', 'client'),
(36, 'jade36', 'jade36@yahoo.com', 'Poirier', 'cccc12d', 'client'),
(37, 'karim37', 'karim37@icloud.com', 'Muller', 'sgdg', 'client'),
(38, 'laura38', 'laura38@outlook.com', 'Noel', 'dgfsg', 'client'),
(39, 'max39', 'max39@gmail.com', 'Renard', 'dfddssss', 'client'),
(40, 'nora40', 'nora40@outlook.com', 'Leclerc', 'dfdfdc', 'client'),
(41, 'omar41', 'omar41@hotmail.com', 'Robin', 'ddfdf511', 'client'),
(42, 'paula42', 'paula42@outlook.com', 'Marin', 'oujko65', 'client'),
(43, 'quentin43', 'quentin43@yahoo.com', 'Bailly', 'hhgbvb3', 'client'),
(44, 'romy44', 'romy44@gmail.com', 'Pelletier', 'bnghf001', 'client'),
(45, 'sam45', 'sam45@yahoo.com', 'Roussel', '0025g', 'client'),
(46, 'thais46', 'thais46@gmail.com', 'Masson', 'ghg5', 'client'),
(47, 'ursula47', 'ursula47@yahoo.com', 'Charpentier', 'ggh565', 'admin'),
(48, 'victor48', 'victor48@gmail.com', 'Langlois', 'ghg20', 'client'),
(49, 'wassim49', 'wassim49@gmail.com', 'Germain', 'ghgt7', 'client'),
(50, 'yasmine50', 'yasmine50@gmail.com', 'Rey', 'ghg21', 'client');


-- Insertion des téléphones
INSERT INTO telephone(id_telephone, nom_telephone, poids, taille, prix_telephone, fournisseur, marque, id_couleur, id_type_telephone) VALUES
(1, 'iPhone 14 Pro', 206.0, 6, 1329.99, 'Apple Inc.', 'Apple', 1, 2),
(2, 'Samsung Galaxy S23', 168.0, 6, 959.99, 'Boulanger', 'Samsung', 2, 2),
(3, 'Google Pixel 7', 197.0, 6, 649.99, 'Fnac', 'Google', 3, 2),
(4, 'Xiaomi 13 Pro', 210.0, 6, 899.99, 'Xiaomi', 'Xiaomi', 4, 2),
(5, 'OnePlus 11', 205.0, 6, 749.99, 'Amazon', 'OnePlus', 5, 1),
(6, 'iPhone 13', 174.0, 6, 909.99, 'Apple Inc.', 'Apple', 1, 1),
(7, 'Samsung A54', 189.0, 6, 499.99, 'Samsung', 'Samsung', 2, 2),
(8, 'Google Pixel 6a', 178.0, 6, 459.99, 'Google', 'Google', 3, 2),
(9, 'Xiaomi Redmi Note 12', 190.0, 6, 249.99, 'Darty', 'Xiaomi', 4, 2),
(10, 'OnePlus Nord CE 3', 184.0, 6, 329.99, 'OnePlus', 'OnePlus', 5, 2),
(11, 'iPhone SE 2022', 144.0, 5, 559.99, 'Apple Inc.', 'Apple', 1, 2),
(12, 'Samsung Z Flip 4', 187.0, 6, 1059.99, 'Darty', 'Samsung', 2, 3),
(13, 'Google Pixel Fold', 283.0, 6, 1799.99, 'Google', 'Google', 3, 3),
(14, 'Xiaomi Mix Fold 2', 262.0, 6, 1499.99, 'Fnac', 'Xiaomi', 4, 3),
(15, 'OnePlus Open', 239.0, 6, 1399.99, 'OnePlus', 'OnePlus', 5, 3),
(16, 'iPhone XR', 194.0, 6, 489.99, 'Apple Inc.', 'Apple', 1, 2),
(17, 'Samsung Galaxy S20 FE', 190.0, 6, 399.99, 'Samsung', 'Samsung', 2, 2),
(18, 'Google Pixel 5', 151.0, 6, 379.99, 'Darty', 'Google', 3, 2),
(19, 'Xiaomi Poco X5 Pro', 181.0, 6, 299.99, 'Xiaomi', 'Xiaomi', 4, 2),
(20, 'OnePlus 8T', 188.0, 6, 349.99, 'OnePlus', 'OnePlus', 5, 2),
(21, 'iPhone 12 Mini', 135.0, 5, 659.99, 'Apple Inc.', 'Apple', 1, 2),
(22, 'Samsung Galaxy A14', 201.0, 6, 179.99, 'Fnac', 'Samsung', 2, 2),
(23, 'Google Pixel 4a', 143.0, 5, 299.99, 'Google', 'Google', 3, 2),
(24, 'Xiaomi Redmi 10C', 190.0, 6, 159.99, 'Xiaomi', 'Xiaomi', 4, 2),
(25, 'OnePlus Nord N200', 189.0, 6, 199.99, 'OnePlus', 'OnePlus', 5, 2),
(26, 'iPhone 11', 194.0, 6, 589.99, 'Apple Inc.', 'Apple', 1, 2),
(27, 'Samsung Galaxy S21', 169.0, 6, 699.99, 'Fnac', 'Samsung', 2, 2),
(28, 'Google Pixel 3a', 147.0, 5, 229.99, 'Google', 'Google', 3, 2),
(29, 'Xiaomi Mi 11 Lite', 157.0, 6, 319.99, 'Xiaomi', 'Xiaomi', 4, 2),
(30, 'OnePlus 9', 183.0, 6, 549.99, 'Fnac', 'OnePlus', 5, 2),
(31, 'iPhone X', 174.0, 5, 399.99, 'Boulanger', 'Apple', 1, 2),
(32, 'Samsung Galaxy Note 20', 208.0, 6, 849.99, 'Samsung', 'Samsung', 2, 2),
(33, 'Google Pixel 2', 143.0, 5, 199.99, 'Google', 'Google', 3, 2),
(34, 'Xiaomi Mi 9T Pro', 191.0, 6, 289.99, 'Xiaomi', 'Xiaomi', 4, 2),
(35, 'OnePlus 7T', 190.0, 6, 329.99, 'Darty', 'OnePlus', 5, 2),
(36, 'iPhone 6s', 143.0, 5, 139.99, 'Apple Inc.', 'Apple', 1, 2),
(37, 'Samsung Galaxy A32', 184.0, 6, 229.99, 'Samsung', 'Samsung', 2, 2),
(38, 'Google Nexus 5X', 136.0, 5, 99.99, 'Google', 'Google', 3, 2),
(39, 'Xiaomi Redmi Note 8', 190.0, 6, 149.99, 'Xiaomi', 'Xiaomi', 4, 2),
(40, 'OnePlus X', 138.0, 5, 129.99, 'OnePlus', 'OnePlus', 5, 2),
(41, 'iPhone 7', 138.0, 4, 199.99, 'Apple Inc.', 'Apple', 1, 2),
(42, 'Samsung Galaxy J7', 181.0, 5, 159.99, 'Samsung', 'Samsung', 2, 2),
(43, 'Google Pixel 1', 143.0, 5, 179.99, 'Google', 'Google', 3, 2),
(44, 'Xiaomi Mi A3', 173.0, 6, 189.99, 'Fnac', 'Xiaomi', 4, 2),
(45, 'OnePlus 5', 153.0, 5, 199.99, 'Fnac', 'OnePlus', 5, 2),
(46, 'Motorola Edge 30', 155.0, 6, 449.99, 'Motorola', 'Motorola', 6, 2),
(47, 'Realme GT 2', 194.0, 6, 379.99, 'Carrefour', 'Realme', 7, 2),
(48, 'Honor Magic 5 Lite', 173.0, 6, 299.99, 'Honor', 'Honor', 4, 3),
(49, 'Asus ROG Phone 6', 239.0, 6, 999.99, 'Asus', 'Asus', 3, 2),
(50, 'Fairphone 4', 225.0, 6, 579.99, 'Fnac', 'Fairphone', 1, 3);

-- Insertion des états
INSERT INTO etat (id_etat, libelle)
VALUES 
(1, 'En attente'),
(2, 'En cours de traitement'),
(3, 'Expédiée'),
(4, 'Livrée');


-- Insertion des commandes
INSERT INTO commande (id_commande, id_utilisateur, date_achat, id_etat)
VALUES 
(1, 4, '2025-04-15', 1),
(2, 7, '2025-04-20', 2),
(3, 32, '2025-04-19', 3),
(4, 24, '2025-04-25', 1),
(5, 36, '2025-04-26', 4),
(6, 17, '2025-04-29', 2),
(7, 48, '2025-04-07', 3),
(8, 8, '2025-04-30', 1),
(9, 3, '2025-05-02', 4),
(10, 10, '2025-05-03', 2);

-- Insertion des relations effectuer
INSERT INTO effectuer (id_commande, id_utilisateur) VALUES
(1, 5),
(2, 5),
(3, 16),
(4, 8),
(5, 16),
(6, 39),
(7, 40),
(8, 27),
(9, 38),
(10, 34);

-- Insertion des lignes de commande
INSERT INTO ligne_commande (id_telephone, id_commande, prix, quantite) VALUES
(1, 1, 299.99, 1),
(2, 2, 489.99, 1),
(3, 3, 179.99, 2),
(4, 4, 599.99, 1),
(5, 5, 1339.99, 3),
(1, 6, 299.99, 1),
(2, 7, 489.99, 1),
(3, 8, 179.99, 1),
(4, 9, 559.99, 1),
(5, 10, 339.99, 1);

--Insertion des lignes de panier
INSERT INTO ligne_panier (id_telephone, id_utilisateur, quantite, date_ajout)
VALUES 
(1, 2, 1, '2025-04-05'),
(2, 38, 2, '2025-04-05'),
(3, 3, 1, '2025-04-06'),
(4, 4, 1, '2025-04-07'),
(5, 15, 3, '2025-04-07'),
(6, 6, 1, '2025-04-08'),
(7, 20, 2, '2025-04-08'),
(8, 8, 1, '2025-04-09'),
(9, 48, 2, '2025-04-09'),
(10, 17, 1, '2025-04-10');






