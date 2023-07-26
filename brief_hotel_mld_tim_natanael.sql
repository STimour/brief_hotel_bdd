CREATE TYPE "niveau_comfort" AS ENUM (
  'normal',
  'business',
  'luxe'
);

CREATE TYPE "periode_annee" AS ENUM (
  'haute_saison',
  'basse_saison'
);

CREATE TABLE "societe" (
  "id_societe" int PRIMARY KEY,
  "id_enseigne" int,
  "nom_societe" varchar
);

CREATE TABLE "enseigne" (
  "id_enseigne" int PRIMARY KEY,
  "id_societe" int,
  "id_hotel" int,
  "nom_enseigne" varchar
);

CREATE TABLE "hotel" (
  "id_hotel" int PRIMARY KEY,
  "id_enseigne" int,
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
  "id_chambre" int PRIMARY KEY,
  "id_hotel" int,
  "id_prix" int,
  "type_chambre" niveau_comfort,
  "nb_lit" int
);

CREATE TABLE "prix" (
  "id_prix" int PRIMARY KEY,
  "id_chambre" int,
  "saison" periode_annee,
  "prix" money
);

CREATE TABLE "option" (
  "id_option" int PRIMARY KEY,
  "titre_option" varchar,
  "prix" money
);

CREATE TABLE "reservation" (
  "id_reservation" int PRIMARY KEY,
  "id_chambre" int,
  "id_client" int,
  "id_option" int,
  "id_prix" int
);

CREATE TABLE "facture" (
  "id_facture" int PRIMARY KEY,
  "id_reservation" int,
  "montant_total" int
);

CREATE TABLE "client" (
  "id_client" int PRIMARY KEY,
  "id_reservation" int,
  "id_facture" int,
  "id_client_pro" int,
  "nom_societe" varchar,
  "nom" varchar,
  "prenom" varchar,
  "genre" enum,
  "tel" varchar,
  "numero_cb" varchar
);

ALTER TABLE "enseigne" ADD FOREIGN KEY ("id_enseigne") REFERENCES "societe" ("id_enseigne");

ALTER TABLE "enseigne" ADD FOREIGN KEY ("id_societe") REFERENCES "societe" ("id_societe");

ALTER TABLE "hotel" ADD FOREIGN KEY ("id_hotel") REFERENCES "enseigne" ("id_hotel");

ALTER TABLE "hotel" ADD FOREIGN KEY ("id_enseigne") REFERENCES "enseigne" ("id_enseigne");

ALTER TABLE "chambre" ADD FOREIGN KEY ("id_chambre") REFERENCES "hotel" ("id_chambre");

ALTER TABLE "chambre" ADD FOREIGN KEY ("id_hotel") REFERENCES "hotel" ("id_hotel");

ALTER TABLE "prix" ADD FOREIGN KEY ("id_prix") REFERENCES "chambre" ("id_prix");

ALTER TABLE "prix" ADD FOREIGN KEY ("id_chambre") REFERENCES "chambre" ("id_chambre");

CREATE TABLE "client_reservation" (
  "client_id_client" int,
  "reservation_id_chambre" int,
  PRIMARY KEY ("client_id_client", "reservation_id_chambre")
);

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("client_id_client") REFERENCES "client" ("id_client");

ALTER TABLE "client_reservation" ADD FOREIGN KEY ("reservation_id_chambre") REFERENCES "reservation" ("id_chambre");


CREATE TABLE "client_reservation(1)" (
  "client_id_client" int,
  "reservation_id_client" int,
  PRIMARY KEY ("client_id_client", "reservation_id_client")
);

ALTER TABLE "client_reservation(1)" ADD FOREIGN KEY ("client_id_client") REFERENCES "client" ("id_client");

ALTER TABLE "client_reservation(1)" ADD FOREIGN KEY ("reservation_id_client") REFERENCES "reservation" ("id_client");


CREATE TABLE "option_reservation" (
  "option_id_option" int,
  "reservation_id_option" int,
  PRIMARY KEY ("option_id_option", "reservation_id_option")
);

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("option_id_option") REFERENCES "option" ("id_option");

ALTER TABLE "option_reservation" ADD FOREIGN KEY ("reservation_id_option") REFERENCES "reservation" ("id_option");


ALTER TABLE "reservation" ADD FOREIGN KEY ("id_prix") REFERENCES "prix" ("id_prix");

ALTER TABLE "reservation" ADD FOREIGN KEY ("id_reservation") REFERENCES "facture" ("id_reservation");

ALTER TABLE "reservation" ADD FOREIGN KEY ("id_reservation") REFERENCES "client" ("id_reservation");

ALTER TABLE "facture" ADD FOREIGN KEY ("id_facture") REFERENCES "client" ("id_facture");
