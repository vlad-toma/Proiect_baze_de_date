//Tipuri de PARIU
INSERT INTO Tip_Pariu VALUES (NULL, 'Castiga echipa gazda');
INSERT INTO Tip_Pariu VALUES (NULL, 'Egal');
INSERT INTO Tip_Pariu VALUES (NULL, 'Castiga echipa deplasare');
INSERT INTO Tip_Pariu VALUES (NULL, 'Marcheaza ambele echipe');
INSERT INTO Tip_Pariu VALUES (NULL, 'Sub 0.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Sub 1.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Sub 2.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Sub 3.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Peste 0.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Peste 1.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Peste 2.5 goluri');
INSERT INTO Tip_Pariu VALUES (NULL, 'Peste 3.5 goluri');

// Competii de fotbal
INSERT INTO COMPETITIE VALUES (NULL, 'Champions League', NULL, 
TO_DATE('2023-09-19 10:00:00', 'YYYY-MM-DD HH:MI:SS'),
TO_DATE('2024-06-01 10:00:00', 'YYYY-MM-DD HH:MI:SS'));
INSERT INTO COMPETITIE VALUES (NULL, 'Superliga', 'Romania',
TO_DATE('2023-07-14 6:00:00', 'YYYY-MM-DD HH:MI:SS'),
TO_DATE('2024-06-24 9:30:00', 'YYYY-MM-DD HH:MI:SS')); 
INSERT INTO COMPETITIE VALUES (NULL, 'Premier League', 'Anglia',
TO_DATE('2023-08-23 10:00:00', 'YYYY-MM-DD HH:MI:SS'),
TO_DATE('2024-05-24 6:00:00', 'YYYY-MM-DD HH:MI:SS')); 
INSERT INTO COMPETITIE VALUES (NULL, 'La Liga', 'Spania',
TO_DATE('2023-08-11 6:00:00', 'YYYY-MM-DD HH:MI:SS'),
TO_DATE('2024-05-24 10:00:00', 'YYYY-MM-DD HH:MI:SS')); 
INSERT INTO COMPETITIE VALUES (NULL, 'Bundesliga', 'Germania',
TO_DATE('2023-08-18 10:00:00', 'YYYY-MM-DD HH:MI:SS'),
TO_DATE('2024-05-18 6:00:00', 'YYYY-MM-DD HH:MI:SS'));

// Echipe din Superliga
INSERT INTO ECHIPA VALUES (NULL, 'FCSB', 'Romania', 'Bucuresti');
INSERT INTO ECHIPA VALUES (NULL, 'Dinamo Bucuresti', 'Romania', 'Bucuresti');
INSERT INTO ECHIPA VALUES (NULL, 'CFR Cluj', 'Romania', 'Cluj');

// Echipe din Premier League
INSERT INTO ECHIPA VALUES (NULL, 'Tottenham Hotspur', 'Regatul Unit al Marii Britanii', 'Londra');
INSERT INTO ECHIPA VALUES (NULL, 'Manchester City', 'Regatul Unit al Marii Britanii', 'Manchester');
INSERT INTO ECHIPA VALUES (NULL, 'Liverpool', 'Regatul Unit al Marii Britanii', 'Liverpool');


// Echipe din La Liga
INSERT INTO ECHIPA VALUES (NULL, 'Real Madrid', 'Spania', 'Madrid');
INSERT INTO ECHIPA VALUES (NULL, 'Atletico Madrid', 'Spania', 'Madrid');
INSERT INTO ECHIPA VALUES (NULL, 'Barcelona', 'Spania', 'Barcelona');

// Echipe din Bundesliga
INSERT INTO ECHIPA VALUES (NULL, 'Bayern Munchen', 'Germania', 'Munchen');
INSERT INTO ECHIPA VALUES (NULL, 'Borussia Dortmund', 'Germania', 'Dortmund');
INSERT INTO ECHIPA VALUES (NULL, 'Red Bull Leipzig', 'Germania', 'Leipzig');

//Eveniment din Superliga
INSERT INTO EVENIMENT VALUES(NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Superliga'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Dinamo Bucuresti'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'FCSB'),
TO_DATE('2023-11-26 6:30:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 7.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 5.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 1.42);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 13.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 7.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.03);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.40);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.22);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.25);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.65);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.47);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.70);

//Eveniment din Superliga
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Superliga'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'CFR Cluj'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Dinamo Bucuresti'),
TO_DATE('2024-02-24 5:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 1.76);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.82);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 4.68);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 2.03);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 11.21);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.14);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.23);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.29);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.09);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.87);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.32);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.95);

//Eveniment din Premier League
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Premier League'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Manchester City'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Liverpool'),
TO_DATE('2023-11-25 2:30:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 1.70);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 4.20);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 4.60);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 1.82);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 14.37);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.02);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.67);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.17);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.34);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.55);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.54);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.56);

//Eveniment din Premier League
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Premier League'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Manchester City'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Tottenham Hotspur'),
TO_DATE('2024-04-20 5:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 1.56);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.20);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 6.02);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 1.75);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 15.52);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.01);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.72);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.14);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.40);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.49);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.57);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.49);

//Eveniment din La Liga
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'La Liga'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Real Madrid'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Barcelona'),
TO_DATE('2024-04-21 6:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 2.90);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.60);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 2.30);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 1.88);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 13.89);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.03);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.67);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.20);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.32);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.59);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.51);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.59);

//Eveniment din La Liga
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'La Liga'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Atletico Madrid'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Real Madrid'),
TO_DATE('2023-09-24 10:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 2.90);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.10);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 2.70);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 2.01);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 11.57);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.11);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.29);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.26);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.15);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.79);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.35);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.91);

//Eveniment din Champions League
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Champions League'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Dinamo Bucuresti'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Barcelona'),
TO_DATE('2024-02-27 10:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 9.50);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 5.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 1.25);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 3.24);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 16.25);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.01);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 5.12);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.09);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.76);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.41);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.73);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.30);

//Eveniment din Champions League
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Champions League'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Tottenham Hotspur'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'FCSB'),
TO_DATE('2024-06-1 10:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 1.80);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.40);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 4.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 1.99);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 14.29);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.03);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.89);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.17);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.54);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.55);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.69);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.45);

//Eveniment din Bundesliga
INSERT INTO EVENIMENT VALUES (NULL, 
(SELECT ID_Competitie FROM COMPETITIE where Nume = 'Bundesliga'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Borussia Dortmund'),
(SELECT ID_Echipa FROM ECHIPA where Nume = 'Bayern Munchen'),
TO_DATE('2024-03-30 6:00:00', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda'), 3.80);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Egal'), 3.20);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare'), 2.00);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe'), 1.82);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 0.5 goluri'), 15.01);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 0.5 goluri'), 1.01);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 1.5 goluri'), 4.97);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri'), 1.13);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri'), 2.65);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri'), 1.49);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 3.5 goluri'), 1.74);
INSERT INTO Cota_Eveniment VALUES(EVENIMENT_ID_SEQ.currval, (SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri'), 2.32);

//Clienti
INSERT INTO CLIENT VALUES (NULL, 'Nistor', 'Catalin', '1850731031029');
INSERT INTO DETALII_CLIENT VALUES (CLIENT_ID_SEQ.currval, '0265436652', NULL);

INSERT INTO CLIENT VALUES (NULL, 'Stanescu', 'Monica', '2990311354327');
INSERT INTO DETALII_CLIENT VALUES (CLIENT_ID_SEQ.currval, NULL, 'monica.stanescu@yahoo.ro');

INSERT INTO CLIENT VALUES (NULL, 'Dumitrescu', 'Anton', '1770920239899');
INSERT INTO DETALII_CLIENT VALUES (CLIENT_ID_SEQ.currval, '0760054785', 'anton95@gmail.com');

INSERT INTO CLIENT VALUES (NULL, 'Dragan', 'Maria', '2850822348148');
INSERT INTO DETALII_CLIENT VALUES (CLIENT_ID_SEQ.currval, '0734958734', 'maria123@yahoo.com');

INSERT INTO CLIENT VALUES (NULL, 'Georgescu', 'Andrei', '1940617375002');
INSERT INTO DETALII_CLIENT VALUES (CLIENT_ID_SEQ.currval, '0257289345', 'andrei.g@gmail.ro');

//Bilet 1
INSERT INTO BILET VALUES (NULL,
(SELECT ID_Client FROM CLIENT where CNP = '1850731031029'),
250.00,
6.81,
1702.50,
TO_DATE('2023-11-23 5:12:34', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1850731031029')
and Data_si_ora_plasarii_biletului = TO_DATE('2023-11-23 5:12:34', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Manchester City')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Liverpool')
and Data_si_ora_eveniment = TO_DATE('2023-11-25 2:30:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Sub 2.5 goluri')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1850731031029')
and Data_si_ora_plasarii_biletului = TO_DATE('2023-11-23 5:12:34', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Real Madrid')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Barcelona')
and Data_si_ora_eveniment = TO_DATE('2024-04-21 6:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1850731031029')
and Data_si_ora_plasarii_biletului = TO_DATE('2023-11-23 5:12:34', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Tottenham Hotspur')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'FCSB')
and Data_si_ora_eveniment = TO_DATE('2024-06-1 10:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 2.5 goluri')
);

//Bilet 2
INSERT INTO BILET VALUES (NULL,
(SELECT ID_Client FROM CLIENT where CNP = '1770920239899'),
50.00,
9.50,
475.00,
TO_DATE('2024-02-27 8:09:45', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1770920239899')
and Data_si_ora_plasarii_biletului = TO_DATE('2024-02-27 8:09:45', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Dinamo Bucuresti')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Barcelona')
and Data_si_ora_eveniment = TO_DATE('2024-02-27 10:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa gazda')
);

//Bilet 3
INSERT INTO BILET VALUES (NULL,
(SELECT ID_Client FROM CLIENT where CNP = '1850731031029'),
1500.00,
1.78,
2670.00,
TO_DATE('2023-09-22 7:42:32', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1850731031029')
and Data_si_ora_plasarii_biletului = TO_DATE('2023-09-22 7:42:32', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Dinamo Bucuresti')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'FCSB')
and Data_si_ora_eveniment = TO_DATE('2023-11-26 6:30:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Castiga echipa deplasare')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1850731031029')
and Data_si_ora_plasarii_biletului = TO_DATE('2023-09-22 7:42:32', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Atletico Madrid')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Real Madrid')
and Data_si_ora_eveniment = TO_DATE('2023-09-24 10:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 1.5 goluri')
);

//Bilet 4
INSERT INTO BILET VALUES (NULL,
(SELECT ID_Client FROM CLIENT where CNP = '2850822348148'),
100.00,
1.82,
182.00,
TO_DATE('2024-03-28 5:32:01', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '2850822348148')
and Data_si_ora_plasarii_biletului = TO_DATE('2024-03-28 5:32:01', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Borussia Dortmund')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Bayern Munchen')
and Data_si_ora_eveniment = TO_DATE('2024-03-30 6:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Marcheaza ambele echipe')
);

//Bilet 5
INSERT INTO BILET VALUES (NULL,
(SELECT ID_Client FROM CLIENT where CNP = '1940617375002'),
250.00,
2.49,
622.50,
TO_DATE('2024-04-20 5:48:57', 'YYYY-MM-DD HH:MI:SS')
);
INSERT INTO PARIU VALUES ((SELECT ID_Bilet FROM BILET where ID_Client = (SELECT ID_Client FROM CLIENT where CNP = '1940617375002')
and Data_si_ora_plasarii_biletului = TO_DATE('2024-04-20 5:48:57', 'YYYY-MM-DD HH:MI:SS')),
(SELECT ID_Eveniment FROM EVENIMENT
where ID_Echipa_Gazda = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Manchester City')
and ID_Echipa_Deplasare = (SELECT ID_Echipa FROM ECHIPA where Nume = 'Tottenham Hotspur')
and Data_si_ora_eveniment = TO_DATE('2024-04-20 5:00:00', 'YYYY-MM-DD HH:MI:SS')
),
(SELECT ID_Pariu from Tip_Pariu where Nume_Pariu = 'Peste 3.5 goluri')
);