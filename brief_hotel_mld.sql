CREATE TYPE "periode_annee" AS ENUM (
  'haute_saison',
  'basse_saison'
);

CREATE TYPE "sexe" AS ENUM (
  'homme',
  'femme'
);

CREATE TABLE "enseigne" (
  "id_enseigne" int PRIMARY KEY,
  "id_hotel" int NOT NULL ,
  "nom_societe" varchar NOT NULL,
  "nom_enseigne" varchar NOT NULL
);

CREATE TABLE "hotel" (
  "id_hotel" int PRIMARY KEY NOT NULL,
  "id_chambre" int,
  "nb_chambre" int NOT NULL,
  "nb_chambre_disponible" int,
  "pays" varchar NOT NULL,
  "ville" varchar NOT NULL,
  "code_postal" varchar NOT NULL,
  "numero_rue" varchar NOT NULL,
  "nom_rue" varchar NOT NULL
);

CREATE TABLE "chambre" (
  "id_chambre" int PRIMARY KEY NOT NULL,
  "id_prix" int,
  "numero_chambre" int NOT NULL,
  "type_chambre" niveau_comfort,
  "nb_lit" int NOT NULL,
  "date_arrive" date NOT NULL,
  "date_depart" date NOT NULL
);

CREATE TABLE "prix" (
  "id_prix" int PRIMARY KEY NOT NULL,
  "saison" periode_annee NOT NULL,
  "prix" money NOT NULL
);

CREATE TABLE "option" (
  "id_option" int PRIMARY KEY NOT NULL,
  "titre_option" varchar NOT NULL,
  "prix" money NOT NULL
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
  "montant_total" int NOT NULL
);

CREATE TABLE "client" (
  "id_client" int PRIMARY KEY NOT NULL,
  "id_facture" int,
  "id_client_pro" int,
  "nom_societe" varchar,
  "nom" varchar NOT NULL,
  "prenom" varchar NOT NULL,
  "genre" sexe NOT NULL,
  "tel" varchar NOT NULL,
  "numero_cb" varchar NOT NULL
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