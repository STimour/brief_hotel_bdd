CREATE TABLE `enseigne` (
  `id_enseigne` int PRIMARY KEY,
  `id_hotel` int,
  `nom_societe` varchar(255),
  `nom_enseigne` varchar(255)
);

CREATE TABLE `hotel` (
  `id_hotel` int PRIMARY KEY,
  `id_chambre` int,
  `nb_chambre` int NOT NULL,
  `nb_chambre_disponible` int,
  `pays` varchar(255),
  `ville` varchar(255),
  `code_postal` varchar(255),
  `numero_rue` varchar(255),
  `nom_rue` varchar(255)
);

CREATE TABLE `chambre` (
  `id_chambre` int PRIMARY KEY,
  `id_prix` int,
  `numero_chambre` int,
  `type_chambre` ENUM ('normal', 'business', 'luxe'),
  `nb_lit` int,
  `date_arrive` date,
  `date_depart` date
);

CREATE TABLE `prix` (
  `id_prix` int PRIMARY KEY,
  `saison` ENUM ('haute_saison', 'basse_saison'),
  `prix` money
);

CREATE TABLE `option` (
  `id_option` int PRIMARY KEY,
  `titre_option` varchar(255),
  `prix` money
);

CREATE TABLE `reservation` (
  `id_reservation` int PRIMARY KEY,
  `id_chambre` int,
  `id_client` int,
  `id_option` int,
  `id_prix` int
);

CREATE TABLE `facture` (
  `id_facture` int PRIMARY KEY,
  `id_reservation` int,
  `montant_total` int
);

CREATE TABLE `client` (
  `id_client` int PRIMARY KEY,
  `id_facture` int,
  `id_client_pro` int,
  `nom_societe` varchar(255),
  `nom` varchar(255),
  `prenom` varchar(255),
  `genre` enum,
  `tel` varchar(255),
  `numero_cb` varchar(255)
);

ALTER TABLE `hotel` ADD FOREIGN KEY (`id_hotel`) REFERENCES `enseigne` (`id_hotel`);

ALTER TABLE `chambre` ADD FOREIGN KEY (`id_chambre`) REFERENCES `hotel` (`id_chambre`);

ALTER TABLE `prix` ADD FOREIGN KEY (`id_prix`) REFERENCES `chambre` (`id_prix`);

ALTER TABLE `chambre` ADD FOREIGN KEY (`id_chambre`) REFERENCES `reservation` (`id_chambre`);

CREATE TABLE `client_reservation` (
  `client_id_client` int,
  `reservation_id_client` int,
  PRIMARY KEY (`client_id_client`, `reservation_id_client`)
);

ALTER TABLE `client_reservation` ADD FOREIGN KEY (`client_id_client`) REFERENCES `client` (`id_client`);

ALTER TABLE `client_reservation` ADD FOREIGN KEY (`reservation_id_client`) REFERENCES `reservation` (`id_client`);


CREATE TABLE `option_reservation` (
  `option_id_option` int,
  `reservation_id_option` int,
  PRIMARY KEY (`option_id_option`, `reservation_id_option`)
);

ALTER TABLE `option_reservation` ADD FOREIGN KEY (`option_id_option`) REFERENCES `option` (`id_option`);

ALTER TABLE `option_reservation` ADD FOREIGN KEY (`reservation_id_option`) REFERENCES `reservation` (`id_option`);


ALTER TABLE `reservation` ADD FOREIGN KEY (`id_prix`) REFERENCES `prix` (`id_prix`);

ALTER TABLE `reservation` ADD FOREIGN KEY (`id_reservation`) REFERENCES `facture` (`id_reservation`);

ALTER TABLE `facture` ADD FOREIGN KEY (`id_facture`) REFERENCES `client` (`id_facture`);