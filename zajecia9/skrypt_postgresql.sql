CREATE DATABASE TabelaGeochronologiczna;

CREATE TABLE GeoEon (
	id_eon INTEGER PRIMARY KEY,
	nazwa_eon VARCHAR(25) NOT NULL
);

CREATE TABLE GeoEra (
	id_era INTEGER PRIMARY KEY,
	id_eon INTEGER REFERENCES geoeon(id_eon),
	nazwa_era VARCHAR(25) NOT NULL
);

CREATE TABLE GeoOkres (
	id_okres INTEGER PRIMARY KEY,
	id_era INTEGER REFERENCES geoera(id_era),
	nazwa_okres VARCHAR(25) NOT NULL
);

CREATE TABLE GeoEpoka (
	id_epoka INTEGER PRIMARY KEY,
	id_okres INTEGER REFERENCES geookres(id_okres),
	nazwa_epoka VARCHAR(25) NOT NULL
);

CREATE TABLE GeoPietro (
	id_pietro INTEGER PRIMARY KEY,
	id_epoka INTEGER REFERENCES geoepoka(id_epoka),
	nazwa_p VARCHAR(25) NOT NULL
);

ALTER TABLE GeoEra
    ADD FOREIGN KEY (id_eon)
    REFERENCES GeoEon (id_eon);

ALTER TABLE GeoOkres
    ADD FOREIGN KEY (id_era)
    REFERENCES GeoEra (id_era);

ALTER TABLE GeoEpoka
    ADD FOREIGN KEY (id_okres)
    REFERENCES GeoOkres (id_okres);

ALTER TABLE GeoPietro
    ADD FOREIGN KEY (id_epoka)
    REFERENCES GeoEpoka (id_epoka);

INSERT INTO GeoEon VALUES
	(1, 'Fanerozoik');

INSERT INTO GeoEra VALUES
	(1, 1, 'kenozoik'),
	(2, 1, 'mezozoik'),
	(3, 1, 'paleozoik');

INSERT INTO GeoOkres VALUES
	(1, 1, 'czwartorzęd'),
	(2, 1, 'neogen'),
	(3, 1, 'paleogen'),
	(4, 2, 'kreda'),
	(5, 2, 'jura'),
	(6, 2, 'trias'),
	(7, 3, 'perm'),
	(8, 3, 'karbon'),
	(9, 3, 'dewon');

INSERT INTO GeoEpoka VALUES
	(1, 1, 'Holocen'),
	(2, 1, 'Plejstocen'),
	(3, 2, 'Pliocen'),
	(4, 2, 'Miocen'),
	(5, 3, 'Oligocen'),
	(6, 3, 'Eocen'),
	(7, 3, 'Paleocen'),
	(8, 4, 'Póżna kreda'),
	(9, 4, 'Wczesna kreda'),
	(10, 5, 'Jura późna'),
	(11, 5, 'Jura środkowa'),
	(12, 5, 'Jura wczesna'),
	(13, 6, 'Późny trias'),
	(14, 6, 'Środkowy trias'),
	(15, 6, 'Wczesny trias'),
	(16, 7, 'Póżny perm'),
	(17, 7, 'Wczesny perm'),
	(18, 8, 'Późny karbon'),
	(19, 8, 'Wczesny karbon'),
	(20, 9, 'Późny dewon'),
	(21, 9, 'Środkowy dewon'),
	(22, 9, 'Dolny dewon');

INSERT INTO GeoPietro VALUES
	(1,1,'megalaj'),
	(2,1,'northgrip'),
	(3,1,'grenland'),
	(4,2,'późny[b]'),
	(5,2,'chiban'),
	(6,2,'kalabr'),
	(7,2,'gelas'),
	(8,3,'piacent'),
	(9,3,'zankl'),
	(10,4,'messyn'),
	(11,4,'torton'),
	(12,4,'serrawal'),
	(13,4,'lang'),
	(14,4,'burdygał'),
	(15,4,'akwitan'),
	(16,5,'szat'),
	(17,5,'rupel'),
	(18,6,'priabon'),
	(19,6,'barton'),
	(20,6,'lutet'),
	(21,6,'iprez'),
	(22,7,'tanet'),
	(23,7,'zeland'),
	(24,7,'dan'),
	(25,8,'mastrycht'),
	(26,8,'kampan'),
	(27,8,'santon'),
	(28,8,'koniak'),
	(29,8,'turon'),
	(30,8,'cenoman'),
	(31,9,'alb'),
	(32,9,'apt'),
	(33,9,'barrem'),
	(34,9,'hoteryw'),
	(35,9,'walanżyn'),
	(36,9,'berrias'),
	(37,10,'tyton'),
	(38,10,'kimeryd'),
	(39,10,'oksford'),
	(40,11,'kelowej'),
	(41,11,'baton'),
	(42,11,'bajos'),
	(43,11,'aalen'),
	(44,12,'toark'),
	(45,12,'pliensbach'),
	(46,12,'synemur'),
	(47,12,'hettang'),
	(48,13,'retyk'),
	(49,13,'noryk'),
	(50,13,'karnik'),
	(51,14,'ladyn'),
	(52,14,'anizyk'),
	(53,15,'olenek'),
	(54,15,'ind'),
	(55,16,'czangsing'),
	(56,16,'wucziaping'),
	(57,16,'kapitan'),
	(58,16,'word'),
	(59,16,'road'),
	(60,17,'kungur'),
	(61,17,'artinsk'),
	(62,17,'sakmar'),
	(63,17,'assel'),
	(64,18,'gżel'),
	(65,18,'kasimow'),
	(66,18,'moskow'),
	(67,18,'baszkir'),
	(68,19,'serpuchow'),
	(69,19,'wizen'),
	(70,19,'turnej'),
	(71,20,'famen'),
	(72,20,'fran'),
	(73,21,'żywet'),
	(74,21,'eifel'),
	(75,22,'ems'),
	(76,22,'prag'),
	(77,22,'lochkow');

CREATE TABLE GeoTabela AS (SELECT * FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL
JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon );

CREATE TABLE Dziesiec(cyfra int, bit int);

INSERT INTO Dziesiec VALUES
	                        (0, 1),
                            (1, 1),
                            (2, 1),
                            (3, 1),
                            (4, 1),
                            (5, 1),
                            (6, 1),
                            (7, 1),
                            (8, 1),
                            (9, 1);

CREATE TABLE Milion(liczba int,cyfra int, bit int);
INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6;

CREATE UNIQUE INDEX IF NOT EXISTS liczba_idx ON milion (liczba);
CREATE UNIQUE INDEX IF NOT EXISTS id_pietro_idx ON geotabela (id_pietro);
CREATE UNIQUE INDEX IF NOT EXISTS id_eon_idx ON geoeon (id_eon);
CREATE UNIQUE INDEX IF NOT EXISTS id_era_idx ON geoera (id_era);
CREATE UNIQUE INDEX IF NOT EXISTS id_okres_idx ON geookres (id_okres);
CREATE UNIQUE INDEX IF NOT EXISTS id_epoka_idx ON geoepoka (id_epoka);
CREATE UNIQUE INDEX IF NOT EXISTS id_pietroG_idx ON geopietro (id_pietro);


EXPLAIN ANALYSE
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON
(mod(Milion.liczba,68)=(GeoTabela.id_pietro));

EXPLAIN ANALYSE
SELECT COUNT(*) FROM Milion INNER JOIN GeoPietro ON
(mod(Milion.liczba,68)=GeoPietro.id_pietro) NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon;

EXPLAIN ANALYSE
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68)=
(SELECT id_pietro FROM GeoTabela
WHERE mod(Milion.liczba,68)=(id_pietro));

EXPLAIN ANALYSE
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68) IN (SELECT GeoPietro.id_pietro FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL JOIN
GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon);