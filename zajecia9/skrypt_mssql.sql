create database TabelaGeochronologiczna;

use TabelaGeochronologiczna;

create table GeoEon(id_eon int primary key,nazwa_eon varchar(30));

create table GeoEra( id_era int primary key, nazwa_era varchar(30),
		id_eon int foreign key references GeoEon(id_eon));

create table GeoOkres(id_okres int primary key, nazwa_okres varchar(30),
		id_era int foreign key references GeoEra(id_era))

create table GeoEpoka( id_epoka int primary key, nazwa_epoka varchar(30),
		id_okres int foreign key references GeoOkres(id_okres));

create table GeoPietro(id_pietro int primary key, nazwa_pietro varchar(30),
		id_epoka int foreign key references GeoEpoka(id_epoka));

insert into GeoEon values(1,'fanerozoik');

insert into GeoEra values
	(1,'paleozoik',1),
	(2,'mezozoik',1),
	,(3,'kenozoik',1);

insert into GeoOkres values
	(1, 'dewon',1),
	(2, 'karbon',1),
	(3, 'perm',1),
	(4, 'trias',2),
	(5, 'jura',2),
	(6, 'kreda',2),
	(7, 'palogen',3),
	(8, 'neogen',3),
	(9, 'czwartorzad',3);

insert into GeoEpoka values
	(1, 'dolny', 1),
	(2, 'srodkowy', 1),
	(3, 'gorny', 1),
	(4, 'dolny', 2),
	(5, 'gorny', 2),
	(6, 'dolny', 3),
	(7, 'gorny', 3),
	(8, 'dolny', 4),
	(9, 'srodkowy', 4),
	(10, 'gorny', 4),
	(11, 'dolna', 5),
	(12, 'srodkowa', 5),
	(13, 'gorna', 5),
	(14, 'dolna', 6),
	(15, 'gorna', 6),
	(16, 'paleocen', 7),
	(17, 'eocen', 7),
	(18, 'oligocen', 7),
	(19, 'miocen', 8),
	(20, 'pliocen', 8),
	(21, 'plejstocen', 9),
	(22, 'holocen', 9);

insert into GeoPietro values (1,'megalaj',1),
(2,'northgrip',1),
(3,'grenland',1),
(4,'pozny[b]',2),
(5,'chiban',2),
(6,'kalabr',2),
(7,'gelas',2),
(8,'piacent',3),
(9,'zankl',3),
(10,'messyn',4),
(11,'torton',4),
(12,'serrawal',4),
(13,'lang',4),
(14,'burdyga³',4),
(15,'akwitan',4),
(16,'szat',5),
(17,'rupel',5),
(18,'priabon',6),
(19,'barton',6),
(20,'lutet',6),
(21,'iprez',6),
(22,'tanet',7),
(23,'zeland',7),
(24,'dan',7),
(25,'mastrycht',8),
(26,'kampan',8),
(27,'santon',8),
(28,'koniak',8),
(29,'turon',8),
(30,'cenoman',8),
(31,'alb',9),
(32,'apt',9),
(33,'barrem',9),
(34,'hoteryw',9),
(35,'walan¿yn',9),
(36,'berrias',9),
(37,'tyton',10),
(38,'kimeryd',10),
(39,'oksford',10),
(40,'kelowej',11),
(41,'baton',11),
(42,'bajos',11),
(43,'aalen',11),
(44,'toark',12),
(45,'pliensbach',12),
(46,'synemur',12),
(47,'hettang',12),
(48,'retyk',13),
(49,'noryk',13),
(50,'karnik',13),
(51,'ladyn',14),
(52,'anizyk',14),
(53,'olenek',15),
(54,'ind',15),
(55,'czangsing',16),
(56,'wucziaping',16),
(57,'kapitan',16),
(58,'word',16),
(59,'road',17),
(60,'kungur',17),
(61,'artinsk',17),
(62,'sakmar',17),
(63,'assel',17),
(64,'g¿el',18),
(65,'kasimow',18),
(66,'moskow',18),
(67,'baszkir',18),
(68,'serpuchow',19),
(69,'wizen',19),
(70,'turnej',19),
(71,'famen',20),
(72,'fran',20),
(73,'¿ywet',21),
(74,'eifel',21),
(75,'ems',22),
(76,'prag',22),
(77,'lochkow',22);

create table Dziesiec(cyfra int,bit int),
create table Milion(liczba int,cyfra int, bit int);

insert into Dziesiec values 
	(0,1),
	(1,1),
	(2,1),
	(3,1),
	(4,1),
	(5,1),
	(6,1),
	(7,1),
	(8,1),
	(9,1);

insert into Milion select a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra as liczba , a1.cyfra as cyfra, a1.bit as bit
from Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

-- GeoTabela zdenormalizowana
select GeoPietro.id_pietro,GeoPietro.nazwa_pietro,
GeoEpoka.id_epoka,GeoEpoka.nazwa_epoka,
GeoOkres.id_okres,GeoOkres.nazwa_okres,
GeoEra.id_era,GeoEra.nazwa_era,
GeoEon.id_eon,GeoEon.nazwa_eon
into GeoTabela from GeoEon inner join GeoEra on GeoEon.id_eon=GeoEra.id_eon
inner join GeoOkres on GeoEra.id_era=GeoOkres.id_era
inner join GeoEpoka on GeoOkres.id_okres=GeoEpoka.id_okres
inner join GeoPietro on GeoEpoka.id_epoka=GeoPietro.id_epoka

alter table GeoTabela add primary key(id_pietro);

--Z1
select COUNT(*) from Milion INNER JOIN GeoTabela on Milion.liczba%77 = GeoTabela.id_pietro;

--Z2
select COUNT(*) from Milion inner join GeoPietro on
(Milion.liczba%77=GeoPietro.id_pietro)
inner join GeoEpoka on GeoPietro.id_epoka =GeoEpoka.id_epoka
inner join GeoOkres on GeoEpoka.id_okres = GeoOkres.id_okres
inner join GeoEra on GeoEra.id_era = GeoOkres.id_era
inner join GeoEon on GeoEon.id_eon = GeoEra.id_eon

--Z3
select COUNT(*) from Milion where Milion.liczba%77 = 
(select id_pietro from GeoTabela where Milion.liczba%77=id_pietro)

--Z4
select COUNT(*) from Milion where Milion.liczba%77 in
(select GeoPietro.id_pietro from GeoPietro 
inner join GeoEpoka on GeoPietro.id_epoka = GeoEpoka.id_epoka 
inner join GeoOkres on GeoEpoka.id_okres = GeoOkres.id_okres
inner join GeoEra on GeoEra.id_era = GeoOkres.id_era
inner join GeoEon on GeoEon.id_eon = GeoEra.id_eon)

-- IDX
create index indxEon on GeoEon(id_eon);
create index indxEra on GeoEra(id_era, id_eon);
create index indxOkres on GeoOkres(id_okres, id_era);
create index indxEpoka on GeoEpoka(id_epoka, id_okres);
create index indxPietro on GeoPietro(id_pietro, id_epoka);
create index indxLiczba on Milion(liczba);
create index indxGeoTabela on GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);