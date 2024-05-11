-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-05-11 16:26:54.41

CREATE DATABASE OlympicsDb;
GO

-- tables
-- Table: Dyscyplina
CREATE TABLE OlympicsDb..Dyscyplina (
    id int  NOT NULL,
    sport varchar(10)  NOT NULL,
    event varchar(15)  NOT NULL,
    CONSTRAINT Dyscyplina_pk PRIMARY KEY (id)
);

-- Table: DyscyplinaT
CREATE TABLE OlympicsDb..DyscyplinaT (
    id int identity primary key,
    sport varchar(10)  NOT NULL,
    event varchar(15)  NOT NULL,
);

-- Table: Medal
CREATE TABLE OlympicsDb..Medal (
    id int  NOT NULL,
    kolor varchar(10)  NOT NULL,
    CONSTRAINT Medal_pk PRIMARY KEY (id)
);

-- Table: MedalT
CREATE TABLE OlympicsDb..MedalT (
    id int identity primary key,
    kolor varchar(10)  NOT NULL,
);

-- Table: Olimpiada
CREATE TABLE OlympicsDb..Olimpiada (
    id int  NOT NULL,
    rok varchar(4)  NOT NULL,
    miasto int  NOT NULL,
    kraj int  NOT NULL,
    pora_roku varchar(10)  NOT NULL,
    CONSTRAINT Olimpiada_pk PRIMARY KEY (id)
);

-- Table: OlimpiadaT
CREATE TABLE OlympicsDb..OlimpiadaT (
    id int identity primary key,
    rok varchar(4)  NOT NULL,
    miasto int  NOT NULL,
    kraj int  NOT NULL,
    pora_roku varchar(10)  NOT NULL,
);

-- Table: Uczestnik_stale
CREATE TABLE OlympicsDb..Uczestnik_stale (
    id int  NOT NULL,
    imie_nazwisko int  NOT NULL,
    plec varchar(1)  NOT NULL,
    CONSTRAINT Uczestnik_stale_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_staleT
CREATE TABLE OlympicsDb..Uczestnik_staleT (
    id int identity primary key,
    imie_nazwisko int  NOT NULL,
    plec varchar(1)  NOT NULL,
);

-- Table: Uczestnik_zmienne
CREATE TABLE OlympicsDb..Uczestnik_zmienne (
    id int  NOT NULL,
    wiek int  NOT NULL,
    waga int  NOT NULL,
    wzrost int  NOT NULL,
    CONSTRAINT Uczestnik_zmienne_pk PRIMARY KEY (id)
);

-- Table: Uczestnik_zmienneT
CREATE TABLE OlympicsDb..Uczestnik_zmienneT (
    id int identity primary key,
    wiek int  NOT NULL,
    waga int  NOT NULL,
    wzrost int  NOT NULL,
);

-- Table: Wystep_na_olimpiadzie
CREATE TABLE OlympicsDb..Wystep_na_olimpiadzie (
    Dyscyplina_id int  NOT NULL,
    Medal_id int  NOT NULL,
    Oplimpiada_id int  NOT NULL,
    Zespol_id int  NOT NULL,
    Uczestnik_id int  NOT NULL,
    Uczestnik_zmienne_id int  NOT NULL,
    CONSTRAINT Wystep_na_olimpiadzie_pk PRIMARY KEY (Dyscyplina_id,Medal_id,Oplimpiada_id,Zespol_id,Uczestnik_id)
);

-- Table: Wystep_na_olimpiadzieT
CREATE TABLE OlympicsDb..Wystep_na_olimpiadzieT (
    Dyscyplina_id int identity primary key,
    Medal_id int  NOT NULL,
    Oplimpiada_id int  NOT NULL,
    Zespol_id int  NOT NULL,
    Uczestnik_id int  NOT NULL,
    Uczestnik_zmienne_id int  NOT NULL,
);

-- Table: Zespol
CREATE TABLE OlympicsDb..Zespol (
    id int  NOT NULL,
    nazwa varchar(15)  NOT NULL,
    skrot varchar(3)  NOT NULL,
    region varchar(10)  NOT NULL,
    CONSTRAINT Zespol_pk PRIMARY KEY (id)
);

-- Table: ZespolT
CREATE TABLE OlympicsDb..ZespolT (
    id int identity primary key,
    nazwa varchar(15)  NOT NULL,
    skrot varchar(3)  NOT NULL,
    region varchar(10)  NOT NULL,
);

-- Table: Tmp
CREATE TABLE OlympicsDb..Tmp (
    id int primary key,
    nazwa varchar(40)  NOT NULL,
    plec varchar(1)  NOT NULL,
    wiek int NOT NULL,
    wzrost int  NOT NULL,
    waga int  NOT NULL,
    druzyna varchar(40)  NOT NULL,
    druzyna_kod varchar(3)  NOT NULL,
    zawody varchar(45)  NOT NULL,
    rok varchar(4)  NOT NULL,
    tryb varchar(20)  NOT NULL,
    miasto varchar(30)  NOT NULL,
    sport varchar(30)  NOT NULL,
    wydarzenie varchar(40)  NOT NULL,
    medal varchar(20)  NOT NULL,
);

-- foreign keys
-- Reference: Wystep_na_olimpiadzie_Uczestnik_zmienne (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_na_olimpiadzie_Uczestnik_zmienne
    FOREIGN KEY (Uczestnik_zmienne_id)
    REFERENCES Uczestnik_zmienne (id)  
;

-- Reference: Wystep_olimpiada_Dyscyplina (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Dyscyplina
    FOREIGN KEY (Dyscyplina_id)
    REFERENCES Dyscyplina (id)  
;

-- Reference: Wystep_olimpiada_Medal (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Medal
    FOREIGN KEY (Medal_id)
    REFERENCES Medal (id)  
;

-- Reference: Wystep_olimpiada_Oplimpiada (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Oplimpiada
    FOREIGN KEY (Oplimpiada_id)
    REFERENCES Olimpiada (id)  
;

-- Reference: Wystep_olimpiada_Uczestnik (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Uczestnik
    FOREIGN KEY (Uczestnik_id)
    REFERENCES Uczestnik_stale (id)  
;

-- Reference: Wystep_olimpiada_Zespol (table: Wystep_na_olimpiadzie)
ALTER TABLE OlympicsDb..Wystep_na_olimpiadzie ADD CONSTRAINT Wystep_olimpiada_Zespol
    FOREIGN KEY (Zespol_id)
    REFERENCES Zespol (id)  
;

-- End of file.

