/*1. la liste des services proposées dans les hôtels*/
SELECT titre_service
 FROM service;

/*2. la liste des hôtels de Paris*/
SELECT *
 FROM ville = 'Paris';

/*3.la liste des hôtels situés en italie ainsi que ceux situés en Angleterre.*/
SELECT *
 FROM hotel
  WHERE pays = 'Italie' OR pays = 'Angleterre';

/*4 Donnez la listes des factures établies entre 01 et le 31 juillet 2023.*/
SELECT *
FROM facture
WHERE date_facturation >= '2023-07-01' AND date_facturation <= '2023-07-31';

/*5.Donnez la liste des hotels classée par enseigne.*/
SELECT *
 FROM enseigne e, hotel h
  WHERE e.id_hotel = h.id_hotel
   ORDER BY id_enseigne;
   
/*6. Donnez La liste des facture d'un hotel en donnant sont nom ou sa ville.*/
SELECT * 
 FROM facture f, hotel h
  WHERE f.id_facture = h.id_facture AND h.ville = 'variable_rentré_par_user';

/*7. Donnez La liste des factures du client professionnel X (join)*/
SELECT * 
 FROM facture f, client c
  WHERE f.id_facture = c.id_facture AND c.id_client_pro = 'variable_rentré_par_user';

/*8. Ajouter un nouveau service pour les hotels.*/
INSERT INTO service (id_service, titre_service, prix)
 VALUES (1, 'coca', 15);