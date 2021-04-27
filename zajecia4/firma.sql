CREATE DATABASE firma;

CREATE SCHEMA ksiegowosc;

CREATE TABLE ksiegowosc.godziny (
    id_godziny serial  PRIMARY KEY NOT NULL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL
);

CREATE TABLE ksiegowosc.pensje (
    id_pensji serial PRIMARY KEY  NOT NULL,
    stanowisko varchar(60)  NOT NULL,
    kwota float(2)  NOT NULL,
    id_premii int  NOT NULL
);

CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika serial  PRIMARY KEY NOT NULL,
    imie varchar(60)  NOT NULL,
    nazwisko varchar(60)  NOT NULL,
    adres varchar(80),
    telefon varchar(15)
);

CREATE TABLE ksiegowosc.premie (
    rodzaj varchar(60),
    kwota float(2) ,
    id_premii serial PRIMARY KEY NOT NULL
);

CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia serial PRIMARY KEY NOT NULL,
    data date NOT NULL,
    id_pracownika int NOT NULL,
    id_godziny int NOT NULL,
    id_pensji int NOT NULL,
    id_premii int NOT NUll
);

ALTER TABLE ksiegowosc.godziny
    ADD FOREIGN KEY (id_pracownika)
    REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.pensje
    ADD FOREIGN KEY (id_premii)
    REFERENCES ksiegowosc.premie (id_premii);

ALTER TABLE ksiegowosc.wynagrodzenie
    ADD FOREIGN KEY (id_pracownika)
    REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
    ADD FOREIGN KEY (id_godziny)
    REFERENCES ksiegowosc.godziny (id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie
    ADD FOREIGN KEY (id_pensji)
    REFERENCES ksiegowosc.pensje (id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
    ADD FOREIGN KEY (id_premii)
    REFERENCES ksiegowosc.premie (id_premii);

INSERT INTO ksiegowosc.pracownicy (imie, nazwisko, adres, telefon) VALUES
    ('Ettore', 'Bussen', '4 Service Point', '215-396-1026'),
    ('Aland', 'Lusty', '880 Sullivan Way', '189-431-4850'),
    ('Dallis', 'Bolsteridge', '3 Manley Terrace', '253-245-2206'),
    ('Constance', 'Capozzi', '787 Sauthoff Lane', '249-817-1704'),
    ('Kippar', 'Tomasian', '53101 Sherman Court', '593-527-5559'),
    ('Jacinda', 'Paynton', '53 Old Shore Road', '296-639-8942'),
    ('Jodie', 'Diamant', '750 Birchwood Way', '963-787-6629'),
    ('Stevana', 'Ungaretti', '1 Almo Street', '208-661-2313'),
    ('Belinda', 'Everest', '4673 Union Plaza', '551-791-0794'),
    ('Jecho', 'Leggate', '82765 Farwell Way', '591-817-3268');

INSERT INTO ksiegowosc.godziny (data, liczba_godzin, id_pracownika) VALUES
    ('6/18/2020', 71, 3),
    ('1/12/2021', 97, 4),
    ('3/11/2021', 96, 8),
    ('7/19/2020', 91, 8),
    ('5/27/2020', 5, 2),
    ('12/12/2020', 32, 2),
    ('8/5/2020', 73, 5),
    ('8/19/2020', 59, 4),
    ('8/3/2020', 54, 6),
    ('8/20/2020', 21, 4);

INSERT INTO ksiegowosc.premie (rodzaj, kwota) VALUES
    ('Uznaniowa', 1178),
    ('Regulaminowa', 1477),
    ('Regulaminowa', 722),
    ('Regulaminowa', 995),
    ('Uznaniowa', 544),
    ('Regulaminowa', 1379),
    ('Uznaniowa', 747),
    ('Regulaminowa', 1286),
    ('Uznaniowa', 1369),
    ('Uznaniowa', 901);

INSERT INTO ksiegowosc.pensje (stanowisko, kwota, id_premii) VALUES
    ('Operator', 5168, 7),
    ('Compensation Analyst', 13698, 5),
    ('Librarian', 10237, 7),
    ('Data Coordiator', 3796, 5),
    ('Accounting Assistant IV', 9653, 5),
    ('Executive Secretary', 12413, 1),
    ('Computer Systems Analyst III', 13747, 8),
    ('Junior Executive', 13215, 3),
    ('Chief Design Engineer', 10756, 7),
    ('Software Engineer I', 5271, 4);

insert into ksiegowosc.wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) values
    ('6/15/2020', 4, 6, 8, 4),
    ('10/7/2020', 1, 4, 7, 7),
    ('7/3/2020', 10, 8, 10, 5),
    ('12/5/2020', 1, 9, 4, 5),
    ('11/17/2020', 4, 6, 8, 10),
    ('6/21/2020', 2, 3, 3, 3),
    ('9/27/2020', 4, 2, 10, 5),
    ('5/8/2020', 6, 2, 3, 10),
    ('10/3/2020', 5, 2, 1, 8),
    ('10/9/2020', 5, 10, 7, 10);


SELECT (nazwisko, adres) FROM ksiegowosc.pracownicy;

SELECT
       date_part('day', data) AS Dzien,
       date_part('month', data) AS Miesiac
FROM ksiegowosc.godziny;

ALTER TABLE ksiegowosc.pensje
RENAME kwota to kwota_brutto;

ALTER TABLE ksiegowosc.pensje
ADD COLUMN kwota_netto float(2);

UPDATE ksiegowosc.pensje
SET kwota_netto = ksiegowosc.pensje.kwota_brutto*0.81;

-- a
SELECT (id_pracownika, nazwisko) FROM ksiegowosc.pracownicy;

-- b
SELECT (ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pensje.kwota_brutto)
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
    INNER JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    WHERE ksiegowosc.pensje.kwota_brutto > 1000;

-- c
SELECT (ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pensje.kwota_brutto)
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
    INNER JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    WHERE ksiegowosc.wynagrodzenie.id_premii IS NULL
    AND ksiegowosc.premie.kwota > 2000;

-- d
SELECT (imie) FROM ksiegowosc.pracownicy
    WHERE imie LIKE 'J%';

-- e
SELECT (nazwisko) FROM ksiegowosc.pracownicy
    WHERE nazwisko LIKE '%n%a';

-- f
SELECT
       imie,
       nazwisko,
       liczba_godzin,
       liczba_godzin - 160 as liczba_nadgodzin
    FROM ksiegowosc.pracownicy INNER JOIN ksiegowosc.godziny g on pracownicy.id_pracownika = g.id_pracownika
    WHERE liczba_godzin > 160;

-- g
SELECT (imie, nazwisko, kwota_brutto)
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
    INNER JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    WHERE ksiegowosc.pensje.kwota_brutto > 1500 AND ksiegowosc.pensje.kwota_brutto < 3000;

-- h
SELECT (imie, nazwisko, ksiegowosc.godziny.liczba_godzin) - 160 AS liczba_nadgodzin, ksiegowosc.premie.kwota
FROM firma.ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON ksiegowosc.godziny.id_pracownika = ksiegowosc.pracownicy.id_pracownika
JOIN ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
JOIN ksiegowosc.premie ON premie.id_premii = ksiegowosc.wynagrodzenie.id_premii
WHERE ksiegowosc.godziny.liczba_godzin > 160 AND ksiegowosc.premie.kwota IS NULL;


-- i
SELECT (kwota_brutto, imie, nazwisko)
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
    INNER JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    ORDER BY kwota_brutto;

-- j
SELECT (kwota_brutto, kwota,  imie, nazwisko)
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie on ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
    INNER JOIN ksiegowosc.pensje on ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
    INNER JOIN ksiegowosc.premie p on p.id_premii = wynagrodzenie.id_premii
    ORDER BY kwota_brutto, kwota DESC;

-- k
SELECT stanowisko, COUNT(*)
    FROM ksiegowosc.pensje
    GROUP BY stanowisko;

-- l
SELECT AVG(kwota_brutto)
FROM ksiegowosc.pensje
WHERE stanowisko LIKE 'Data Coordiator';

SELECT MIN(kwota_brutto)
FROM ksiegowosc.pensje
WHERE stanowisko LIKE 'Data Coordiator';

SELECT MAX(kwota_brutto)
FROM ksiegowosc.pensje
WHERE stanowisko LIKE 'Data Coordiator';

-- m
SELECT SUM(kwota_brutto)
FROM ksiegowosc.pensje;

-- f
SELECT stanowisko, SUM(kwota_brutto)
FROM ksiegowosc.pensje
GROUP BY stanowisko;

-- g
SELECT stanowisko, COUNT(*)
FROM ksiegowosc.pensje INNER JOIN ksiegowosc.premie p on p.id_premii = ksiegowosc.pensje.id_premii
GROUP BY stanowisko;

-- h
DELETE FROM firma.ksiegowosc.pracownicy
USING firma.ksiegowosc.wynagrodzenie, ksiegowosc.pensje
WHERE firma.ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
AND firma.ksiegowosc.pensje.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
AND firma.ksiegowosc.pensje.kwota_netto < '3000';