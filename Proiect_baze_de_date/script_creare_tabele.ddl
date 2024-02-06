CREATE TABLE bilet (
    id_bilet                       NUMBER(9) NOT NULL,
    id_client                      NUMBER(7) NOT NULL,
    suma_jucata                    NUMBER(8, 2) NOT NULL,
    cota_totala                    NUMBER(8, 2) NOT NULL,
    castig_potential               NUMBER(8, 2) NOT NULL,
    data_si_ora_plasarii_biletului DATE NOT NULL
)
LOGGING;

ALTER TABLE bilet
    ADD CONSTRAINT bilet_suma_jucata_ck CHECK ( suma_jucata BETWEEN 2 AND 495049.50 );

ALTER TABLE bilet
    ADD CONSTRAINT bilet_cota_totala_ck CHECK ( cota_totala BETWEEN 1.01 AND 250000 );

ALTER TABLE bilet
    ADD CONSTRAINT bilet_castig_potential_ck CHECK ( castig_potential BETWEEN 2.02 AND 500000 );

ALTER TABLE bilet ADD CONSTRAINT bilet_pk PRIMARY KEY ( id_bilet );

CREATE TABLE client (
    id_client NUMBER(7) NOT NULL,
    nume      VARCHAR2(15) NOT NULL,
    prenume   VARCHAR2(30) NOT NULL,
    cnp       CHAR(13) NOT NULL
)
LOGGING;

ALTER TABLE client
    ADD CONSTRAINT client_cnp_ck CHECK ( REGEXP_LIKE ( cnp,
                                                       '^[1-9]([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])(0[1-9]|[123][0-9]|4[0-8])([0-9]{3})([0-9])$'
                                                       ) );

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( id_client );

ALTER TABLE client ADD CONSTRAINT client_cnp_un UNIQUE ( cnp );

CREATE TABLE competitie (
    id_competitie   NUMBER(2) NOT NULL,
    nume            VARCHAR2(30) NOT NULL,
    tara            VARCHAR2(13),
    data_incepere   DATE NOT NULL,
    data_finalizare DATE NOT NULL
)
LOGGING;

ALTER TABLE competitie ADD CONSTRAINT competitie_pk PRIMARY KEY ( id_competitie );

ALTER TABLE competitie ADD CONSTRAINT competitie_nume_un UNIQUE ( nume );

CREATE TABLE cota_eveniment (
    id_eveniment NUMBER(10) NOT NULL,
    id_pariu     NUMBER(2) NOT NULL,
    cota         NUMBER(4, 2) NOT NULL
)
LOGGING;

ALTER TABLE cota_eveniment
    ADD CONSTRAINT cota_eveniment_cota_ck CHECK ( cota >= 1.01 );

CREATE TABLE detalii_client (
    id_client     NUMBER(7) NOT NULL,
    numar_telefon VARCHAR2(10),
    adresa_email  VARCHAR2(40)
)
LOGGING;

ALTER TABLE detalii_client
    ADD CONSTRAINT detalii_client_telefon_ck CHECK ( REGEXP_LIKE ( numar_telefon,
                                                                   '^0[2-7][0-9]{8}$' ) );

ALTER TABLE detalii_client
    ADD CONSTRAINT detalii_client_email_ck CHECK ( REGEXP_LIKE ( adresa_email,
                                                                 '[a-z0-9._%-]+@[a-z0-9._%-]+\.[a-z]{2,4}' ) );

CREATE UNIQUE INDEX detalii_client__idx ON
    detalii_client (
        id_client
    ASC )
        LOGGING;

CREATE TABLE echipa (
    id_echipa NUMBER(4) NOT NULL,
    nume      VARCHAR2(30) NOT NULL,
    tara      VARCHAR2(30) NOT NULL,
    oras      VARCHAR2(58) NOT NULL
)
LOGGING;

ALTER TABLE echipa ADD CONSTRAINT echipa_pk PRIMARY KEY ( id_echipa );

ALTER TABLE echipa ADD CONSTRAINT echipa_nume_un UNIQUE ( nume );

CREATE TABLE eveniment (
    id_eveniment          NUMBER(10) NOT NULL,
    id_competitie         NUMBER(2) NOT NULL,
    id_echipa_gazda       NUMBER(4) NOT NULL,
    id_echipa_deplasare   NUMBER(4) NOT NULL,
    data_si_ora_eveniment DATE NOT NULL
)
LOGGING;

ALTER TABLE eveniment ADD CONSTRAINT echipa_duplicata_ck CHECK ( id_echipa_gazda != id_echipa_deplasare );

ALTER TABLE eveniment ADD CONSTRAINT eveniment_pk PRIMARY KEY ( id_eveniment );

ALTER TABLE eveniment ADD CONSTRAINT ev_echipa_deplasare_data_uk UNIQUE ( id_echipa_deplasare,
                                                                          data_si_ora_eveniment );

ALTER TABLE eveniment ADD CONSTRAINT ev_echipa_gazda_data_uk UNIQUE ( id_echipa_gazda,
                                                                      data_si_ora_eveniment );

CREATE TABLE pariu (
    id_bilet     NUMBER(9) NOT NULL,
    id_eveniment NUMBER(10) NOT NULL,
    id_pariu     NUMBER(2) NOT NULL
)
LOGGING;

CREATE TABLE tip_pariu (
    id_pariu   NUMBER(2) NOT NULL,
    nume_pariu VARCHAR2(24) NOT NULL
)
LOGGING;

ALTER TABLE tip_pariu
    ADD CONSTRAINT tip_pariu_nume_ck CHECK ( nume_pariu IN ( 'Castiga echipa deplasare', 'Castiga echipa gazda', 'Egal', 'Marcheaza ambele echipe'
    , 'Peste 0.5 goluri',
                                                             'Peste 1.5 goluri', 'Peste 2.5 goluri', 'Peste 3.5 goluri', 'Sub 0.5 goluri'
                                                             , 'Sub 1.5 goluri',
                                                             'Sub 2.5 goluri', 'Sub 3.5 goluri' ) );

ALTER TABLE tip_pariu ADD CONSTRAINT tip_pariu_pk PRIMARY KEY ( id_pariu );

ALTER TABLE bilet
    ADD CONSTRAINT bilet_client_fk FOREIGN KEY ( id_client )
        REFERENCES client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE cota_eveniment
    ADD CONSTRAINT cota_eveniment_eveniment_fk FOREIGN KEY ( id_eveniment )
        REFERENCES eveniment ( id_eveniment )
    NOT DEFERRABLE;

ALTER TABLE cota_eveniment
    ADD CONSTRAINT cota_eveniment_tip_pariu_fk FOREIGN KEY ( id_pariu )
        REFERENCES tip_pariu ( id_pariu )
    NOT DEFERRABLE;

ALTER TABLE detalii_client
    ADD CONSTRAINT detalii_client_client_fk FOREIGN KEY ( id_client )
        REFERENCES client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE eveniment
    ADD CONSTRAINT eveniment_competitie_fk FOREIGN KEY ( id_competitie )
        REFERENCES competitie ( id_competitie )
    NOT DEFERRABLE;

ALTER TABLE eveniment
    ADD CONSTRAINT eveniment_echipa_deplasare_fk FOREIGN KEY ( id_echipa_deplasare )
        REFERENCES echipa ( id_echipa )
    NOT DEFERRABLE;

ALTER TABLE eveniment
    ADD CONSTRAINT eveniment_echipa_gazda_fkv2 FOREIGN KEY ( id_echipa_gazda )
        REFERENCES echipa ( id_echipa )
    NOT DEFERRABLE;

ALTER TABLE pariu
    ADD CONSTRAINT pariu_bilet_fk FOREIGN KEY ( id_bilet )
        REFERENCES bilet ( id_bilet )
    NOT DEFERRABLE;

ALTER TABLE pariu
    ADD CONSTRAINT pariu_eveniment_fk FOREIGN KEY ( id_eveniment )
        REFERENCES eveniment ( id_eveniment )
    NOT DEFERRABLE;

ALTER TABLE pariu
    ADD CONSTRAINT pariu_tip_pariu_fk FOREIGN KEY ( id_pariu )
        REFERENCES tip_pariu ( id_pariu )
    NOT DEFERRABLE;

CREATE SEQUENCE bilet_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bilet_id_trg BEFORE
    INSERT ON bilet
    FOR EACH ROW
    WHEN ( new.id_bilet IS NULL )
BEGIN
    :new.id_bilet := bilet_id_seq.nextval;
END;
/

CREATE SEQUENCE client_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER client_id_trg BEFORE
    INSERT ON client
    FOR EACH ROW
    WHEN ( new.id_client IS NULL )
BEGIN
    :new.id_client := client_id_seq.nextval;
END;
/

CREATE SEQUENCE competitie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER competitie_id_trg BEFORE
    INSERT ON competitie
    FOR EACH ROW
    WHEN ( new.id_competitie IS NULL )
BEGIN
    :new.id_competitie := competitie_id_seq.nextval;
END;
/

CREATE SEQUENCE echipa_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER echipa_id_trg BEFORE
    INSERT ON echipa
    FOR EACH ROW
    WHEN ( new.id_echipa IS NULL )
BEGIN
    :new.id_echipa := echipa_id_seq.nextval;
END;
/

CREATE SEQUENCE eveniment_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER eveniment_id_trg BEFORE
    INSERT ON eveniment
    FOR EACH ROW
    WHEN ( new.id_eveniment IS NULL )
BEGIN
    :new.id_eveniment := eveniment_id_seq.nextval;
END;
/

CREATE SEQUENCE tip_pariu_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tip_pariu_id_trg BEFORE
    INSERT ON tip_pariu
    FOR EACH ROW
    WHEN ( new.id_pariu IS NULL )
BEGIN
    :new.id_pariu := tip_pariu_id_seq.nextval;
END;
/