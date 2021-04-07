CREATE DATABASE firma;

CREATE SCHEMA rozliczenia;

CREATE TABLE rozliczenia.godziny (
    id_godziny serial  PRIMARY KEY NOT NULL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL
);

CREATE TABLE rozliczenia.pensje (
    id_pensji serial PRIMARY KEY  NOT NULL,
    stanowisko varchar(60)  NOT NULL,
    kwota float(2)  NOT NULL,
    id_premii int  NOT NULL
);

CREATE TABLE rozliczenia.pracownicy (
    id_pracownika serial  PRIMARY KEY NOT NULL,
    imie varchar(60)  NOT NULL,
    nazwisko varchar(60)  NOT NULL,
    adres varchar(80),
    telefon varchar(15)
);

CREATE TABLE rozliczenia.premie (
    rodzaj varchar(60),
    kwota float(2) ,
    id_premii serial PRIMARY KEY NOT NULL
);

ALTER TABLE rozliczenia.godziny
    ADD FOREIGN KEY (id_pracownika)
    REFERENCES rozliczenia.pracownicy (id_pracownika);

ALTER TABLE rozliczenia.pensje
    ADD FOREIGN KEY (id_premii)
    REFERENCES rozliczenia.premie (id_premii);

insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Ettore', 'Bussen', '4 Service Point', '215-396-1026');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Aland', 'Lusty', '880 Sullivan Way', '189-431-4850');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Dallis', 'Bolsteridge', '3 Manley Terrace', '253-245-2206');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Constance', 'Capozzi', '787 Sauthoff Lane', '249-817-1704');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Kippar', 'Tomasian', '53101 Sherman Court', '593-527-5559');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Jacinda', 'Paynton', '53 Old Shore Road', '296-639-8942');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Jodie', 'Diamant', '750 Birchwood Way', '963-787-6629');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Stevana', 'Ungaretti', '1 Almo Street', '208-661-2313');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Belinda', 'Everest', '4673 Union Plaza', '551-791-0794');
insert into rozliczenia.pracownicy (imie, nazwisko, adres, telefon) values ('Jecho', 'Leggate', '82765 Farwell Way', '591-817-3268');

insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('6/18/2020', 71, 3);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('1/12/2021', 97, 4);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('3/11/2021', 96, 8);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('7/19/2020', 91, 8);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('5/27/2020', 5, 2);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('12/12/2020', 32, 2);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('8/5/2020', 73, 5);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('8/19/2020', 59, 4);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('8/3/2020', 54, 6);
insert into rozliczenia.godziny (data, liczba_godzin, id_pracownika) values ('8/20/2020', 21, 4);

insert into rozliczenia.premie (rodzaj, kwota) values ('Uznaniowa', 1178);
insert into rozliczenia.premie (rodzaj, kwota) values ('Regulaminowa', 1477);
insert into rozliczenia.premie (rodzaj, kwota) values ('Regulaminowa', 722);
insert into rozliczenia.premie (rodzaj, kwota) values ('Regulaminowa', 995);
insert into rozliczenia.premie (rodzaj, kwota) values ('Uznaniowa', 544);
insert into rozliczenia.premie (rodzaj, kwota) values ('Regulaminowa', 1379);
insert into rozliczenia.premie (rodzaj, kwota) values ('Uznaniowa', 747);
insert into rozliczenia.premie (rodzaj, kwota) values ('Regulaminowa', 1286);
insert into rozliczenia.premie (rodzaj, kwota) values ('Uznaniowa', 1369);
insert into rozliczenia.premie (rodzaj, kwota) values ('Uznaniowa', 901);

insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Operator', 5168, 7);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Compensation Analyst', 13698, 5);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Librarian', 10237, 7);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Data Coordiator', 3796, 5);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Accounting Assistant IV', 9653, 5);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Executive Secretary', 12413, 1);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Computer Systems Analyst III', 13747, 8);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Junior Executive', 13215, 3);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Chief Design Engineer', 10756, 7);
insert into rozliczenia.pensje (stanowisko, kwota, id_premii) values ('Software Engineer I', 5271, 4);


SELECT (nazwisko, adres) FROM rozliczenia.pracownicy;

SELECT
       date_part('day', data) AS Dzien,
       date_part('month', data) AS Miesiac
FROM rozliczenia.godziny;

ALTER TABLE rozliczenia.pensje
RENAME kwota to kwota_brutto;

ALTER TABLE rozliczenia.pensje
ADD COLUMN kwota_netto float(2);

UPDATE rozliczenia.pensje
SET kwota_netto = rozliczenia.pensje.kwota_brutto*0.81;