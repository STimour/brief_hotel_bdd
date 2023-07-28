CREATE TYPE "niveau_comfort" AS ENUM (
  'normal',
  'business',
  'luxe'
);

CREATE TYPE "periode_annee" AS ENUM (
  'haute_saison',
  'basse_saison'
);

CREATE TYPE "sexe" AS ENUM (
  'homme',
  'femme'
);

CREATE TABLE "enseigne" (
  "id_enseigne" int PRIMARY KEY NOT NULL,
  "id_hotel" int,
  "nom_societe" varchar,
  "nom_enseigne" varchar
);

CREATE TABLE "hotel" (
  "id_hotel" int PRIMARY KEY NOT NULL,
  "id_chambre" int,
  "nb_chambre" int NOT NULL,
  "nb_chambre_disponible" int,
  "pays" varchar,
  "ville" varchar,
  "code_postal" varchar,
  "numero_rue" varchar,
  "nom_rue" varchar
);

CREATE TABLE "chambre" (
  "id_chambre" int PRIMARY KEY NOT NULL,
  "id_prix" int,
  "numero_chambre" int,
  "type_chambre" niveau_comfort,
  "nb_lit" int,
  "date_arrive" date,
  "date_depart" date
);

CREATE TABLE "prix" (
  "id_prix" int PRIMARY KEY NOT NULL,
  "saison" periode_annee,
  "prix" money
);

CREATE TABLE "service" (
  "id_service" int PRIMARY KEY NOT NULL,
  "titre_service" varchar,
  "prix" money
);

CREATE TABLE "reservation" (
  "id_reservation" int PRIMARY KEY NOT NULL,
  "id_chambre" int,
  "id_client" int,
  "id_option" int,
  "id_prix" int
);

CREATE TABLE "facture" (
  "id_facture" int PRIMARY KEY NOT NULL,
  "id_reservation" int,
  "montant_total" int
);

CREATE TABLE "client" (
  "id_client" int PRIMARY KEY NOT NULL,
  "id_facture" int,
  "id_client_pro" int,
  "nom_societe" varchar,
  "nom" varchar,
  "prenom" varchar,
  "genre" sexe,
  "tel" varchar,
  "numero_cb" varchar
);

ALTER TABLE "enseigne" ADD FOREIGN KEY ("id_hotel") REFERENCES "hotel" ("id_hotel");

ALTER TABLE "hotel" ADD FOREIGN KEY ("id_chambre") REFERENCES "chambre" ("id_chambre");

ALTER TABLE "chambre" ADD FOREIGN KEY ("id_prix") REFERENCES "prix" ("id_prix");

ALTER TABLE "reservation" ADD FOREIGN KEY ("id_chambre") REFERENCES "chambre" ("id_chambre"); -- Correction : Le nom de la colonne doit être "id_chambre" et non "id_reservation"

CREATE TABLE "client_reservation" (
  "client_id_client" int,
  "reservation_id_reservation" int,
  PRIMARY KEY ("client_id_client", "reservation_id_reservation")
);

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("client_id_client") REFERENCES "client" ("id_client");

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("reservation_id_reservation") REFERENCES "reservation" ("id_reservation");

CREATE TABLE "option_reservation" (
  "option_id_option" int,
  "reservation_id_reservation" int,
  PRIMARY KEY ("option_id_option", "reservation_id_reservation")
);

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("option_id_option") REFERENCES "option" ("id_option");

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("reservation_id_reservation") REFERENCES "reservation" ("id_reservation");


ALTER TABLE "reservation" ADD FOREIGN KEY ("id_prix") REFERENCES "prix" ("id_prix");

ALTER TABLE "facture" ADD FOREIGN KEY ("id_reservation") REFERENCES "reservation" ("id_reservation");

ALTER TABLE "client" ADD FOREIGN KEY ("id_facture") REFERENCES "facture" ("id_facture");
