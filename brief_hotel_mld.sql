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
  "id_hotel" int UNIQUE NOT NULL,
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
  "id_chambre" int UNIQUE NOT NULL,
  "id_prix" int,
  "numero_chambre" int,
  "type_chambre" niveau_comfort,
  "nb_lit" int,
  "date_arrive" date,
  "date_depart" date
);

CREATE TABLE "prix" (
  "id_prix" int UNIQUE NOT NULL,
  "saison" periode_annee,
  "prix" money
);

CREATE TABLE "option" (
  "id_option" int UNIQUE NOT NULL,
  "titre_option" varchar,
  "prix" money
);

CREATE TABLE "reservation" (
  "id_reservation" int UNIQUE NOT NULL,
  "id_chambre" int,
  "id_client" int,
  "id_option" int,
  "id_prix" int
);

CREATE TABLE "facture" (
  "id_facture" int UNIQUE NOT NULL,
  "id_reservation" int,
  "montant_total" int
);

CREATE TABLE "client" (
  "id_client" int UNIQUE NOT NULL,
  "id_facture" int,
  "id_client_pro" int,
  "nom_societe" varchar,
  "nom" varchar,
  "prenom" varchar,
  "genre" sexe,
  "tel" varchar,
  "numero_cb" varchar
);

ALTER TABLE "hotel" ADD FOREIGN KEY ("id_hotel") REFERENCES "enseigne" ("id_hotel");

ALTER TABLE "chambre" ADD FOREIGN KEY ("id_chambre") REFERENCES "hotel" ("id_chambre");

ALTER TABLE "prix" ADD FOREIGN KEY ("id_prix") REFERENCES "chambre" ("id_prix");

ALTER TABLE "chambre" ADD FOREIGN KEY ("id_chambre") REFERENCES "reservation" ("id_chambre");

CREATE TABLE "client_reservation" (
  "client_id_client" int,
  "reservation_id_client" int,
  PRIMARY KEY ("client_id_client", "reservation_id_client")
);

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("client_id_client") REFERENCES "client" ("id_client");

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("reservation_id_client") REFERENCES "reservation" ("id_client");


CREATE TABLE "option_reservation" (
  "option_id_option" int,
  "reservation_id_option" int,
  PRIMARY KEY ("option_id_option", "reservation_id_option")
);

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("option_id_option") REFERENCES "option" ("id_option");

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("reservation_id_option") REFERENCES "reservation" ("id_option");


ALTER TABLE "reservation" ADD FOREIGN KEY ("id_prix") REFERENCES "prix" ("id_prix");

ALTER TABLE "reservation" ADD FOREIGN KEY ("id_reservation") REFERENCES "facture" ("id_reservation");

ALTER TABLE "facture" ADD FOREIGN KEY ("id_facture") REFERENCES "client" ("id_facture");
