-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-11 16:26:54.41

-- tables
-- Table: Dyscyplina
CREATE TABLE Dyscyplina (
    id int  NOT NULL,
    sport varchar(10)  NOT NULL,
    event varchar(15)  NOT NULL,
    CONSTRAINT Dyscyplina_pk PRIMARY KEY (id)
);

-- Table: DyscyplinaT
CREATE TABLE DyscyplinaT (
    id int  NOT NULL,
    sport varchar(10)  NOT NULL,
    event varchar(15)  NOT NULL,
    CONSTRAINT Dyscyplina_pk PRIMARY KEY (id)
);

-- Table: Medal
CREATE TABLE Medal (
    id int  NOT NULL,
    kolor varchar(10)  NOT NULL,
    CONSTRAINT Medal_pk PRIMARY KEY (id)
);

-- Table: MedalT
CREATE TABLE MedalT (
    id int  NOT NULL,
    kolor varchar(10)  NOT NULL,
    CONSTRAINT Medal_pk PRIMARY KEY (id)
);

-- Table: Olimpiada
CREATE TABLE Olimpiada (
    id int  NOT NULL,
    rok varchar(4)  NOT NULL,
    miasto int  NOT NULL,
    kraj int  NOT NULL,
    pora_roku varchar(10)  NOT NULL,
    CONSTRAINT Olimpiada_pk PRIMARY KEY (id)
);

-- Table: OlimpiadaT
CREATE TABLE OlimpiadaT (
    id int  NOT NULL,
    rok varchar(4)  NOT NULL,
    miasto int  NOT NULL,
    kraj int  NOT NULL,
    pora_roku varchar(10)  NOT NULL,
    CONSTRAINT Olimpiada_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_stale
CREATE TABLE Uczestnik_stale (
    id int  NOT NULL,
    imie_nazwisko int  NOT NULL,
    plec varchar(1)  NOT NULL,
    CONSTRAINT Uczestnik_stale_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_staleT
CREATE TABLE Uczestnik_staleT (
    id int  NOT NULL,
    imie_nazwisko int  NOT NULL,
    plec varchar(1)  NOT NULL,
    CONSTRAINT Uczestnik_stale_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_zmienne
CREATE TABLE Uczestnik_zmienne (
    id int  NOT NULL,
    wiek int  NOT NULL,
    waga int  NOT NULL,
    wzrost int  NOT NULL,
    CONSTRAINT Uczestnik_zmienne_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_zmienneT
CREATE TABLE Uczestnik_zmienneT (
    id int  NOT NULL,
    wiek int  NOT NULL,
    waga int  NOT NULL,
    wzrost int  NOT NULL,
    CONSTRAINT Uczestnik_zmienne_pk PRIMARY KEY (id)
);

-- Table: Wystep_na_olimpiadzie
CREATE TABLE Wystep_na_olimpiadzie (
    Dyscyplina_id int  NOT NULL,
    Medal_id int  NOT NULL,
    Oplimpiada_id int  NOT NULL,
    Zespol_id int  NOT NULL,
    Uczestnik_id int  NOT NULL,
    Uczestnik_zmienne_id int  NOT NULL,
    CONSTRAINT Wystep_na_olimpiadzie_pk PRIMARY KEY (Dyscyplina_id,Medal_id,Oplimpiada_id,Zespol_id,Uczestnik_id)
);

-- Table: Wystep_na_olimpiadzieT
CREATE TABLE Wystep_na_olimpiadzieT (
    Dyscyplina_id int  NOT NULL,
    Medal_id int  NOT NULL,
    Oplimpiada_id int  NOT NULL,
    Zespol_id int  NOT NULL,
    Uczestnik_id int  NOT NULL,
    Uczestnik_zmienne_id int  NOT NULL,
    CONSTRAINT Wystep_na_olimpiadzie_pk PRIMARY KEY (Dyscyplina_id,Medal_id,Oplimpiada_id,Zespol_id,Uczestnik_id)
);

-- Table: Zespol
CREATE TABLE Zespol (
    id int  NOT NULL,
    nazwa varchar(15)  NOT NULL,
    skrot varchar(3)  NOT NULL,
    region varchar(10)  NOT NULL,
    CONSTRAINT Zespol_pk PRIMARY KEY (id)
);

-- Table: ZespolT
CREATE TABLE ZespolT (
    id int  NOT NULL,
    nazwa varchar(15)  NOT NULL,
    skrot varchar(3)  NOT NULL,
    region varchar(10)  NOT NULL,
    CONSTRAINT Zespol_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: Wystep_na_olimpiadzie_Uczestnik_zmienne (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_na_olimpiadzie_Uczestnik_zmienne
    FOREIGN KEY (Uczestnik_zmienne_id)
    REFERENCES Uczestnik_zmienne (id)  
;

-- Reference: Wystep_olimpiada_Dyscyplina (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Dyscyplina
    FOREIGN KEY (Dyscyplina_id)
    REFERENCES Dyscyplina (id)  
;

-- Reference: Wystep_olimpiada_Medal (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Medal
    FOREIGN KEY (Medal_id)
    REFERENCES Medal (id)  
;

-- Reference: Wystep_olimpiada_Oplimpiada (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Oplimpiada
    FOREIGN KEY (Oplimpiada_id)
    REFERENCES Olimpiada (id)  
;

-- Reference: Wystep_olimpiada_Uczestnik (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Uczestnik
    FOREIGN KEY (Uczestnik_id)
    REFERENCES Uczestnik_stale (id)  
;

-- Reference: Wystep_olimpiada_Zespol (table: Wystep_na_olimpiadzie)
ALTER TABLE Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Zespol
    FOREIGN KEY (Zespol_id)
    REFERENCES Zespol (id)  
;

-- End of file.

