#lab03 DF 2isi
#Zadanie 1
#1* 
create table postac (id_postaci int auto_increment primary key, nazwa varchar(40) not null, rodzaj enum('wiking','ptak','kobieta'), data_ur date, wiek int(3) unsigned);
#2*
insert into postac values(default,'Bjorn','wiking','1968-01-04',53),(default,'Drozd','ptak','2002-10-16',19),(default,'Tesciowa','kobieta','1931-06-10',90);
#3*
update postac set wiek=88 where nazwa='Tesciowa';

#Zadanie 2
#1*
create table walizka (id_walizki int auto_increment primary key,  pojemnosc int unsigned, kolor enum('rozowy', 'czerwony','teczowy','zolty'),id_wlasciciela int, foreign key (id_wlasciciela) references postac(id_postaci) on delete cascade);
#2*
alter table walizka alter kolor set default 'rozowy';
#3*
insert into walizka values(default,20,'czerwony',1);
insert into walizka values(default,25,'zolty',3);

#Zadanie 3
#1*
create table izba (adres_budynku varchar(45), nazwa_izby varchar(45), metraz int unsigned, wlasciciel int, foreign key (wlasciciel) references postac(id_postaci) on delete set null;
#2*
alter table izba add column kolor enum after metraz;
alter table izba alter kolor set default 'czarny';
#3*
insert into izba values('las 2','spizarnia',15,'czarny',1);
#Zadanie 4
#1*
create table przetwory (id_przetworu int auto_increment primary key, rok_produkcji year,id_wykonawcy int,foreign key (id_wykonawcy) references postac(id_postaci) on delete set null,zawatosc varchar(40),dodatek varchar(40), id_konsumenta int,foreign key (id_konsumenta) references postac (id_postaci));
alter table przetwory alter rok_produkcji set default 1954;
#2*
insert into przetwory values (default,'2021',1,'bigos','papryczka chilli',default);
#Zadanie 5
#1*
insert into postac values (default,'Jamir','wiking','1980-03-17',41);
insert into postac values (default,'Farben','wiking','2002-10-16',19);
insert into postac values (default,'Kir','wiking','1990-09-01',21);
insert into postac values (default,'Andrey','wiking','1975-01-01',46);
insert into postac values (default,'Wesley','wiking','1969-05-29',52);
#2*
create table statek (nazwa_statku varchar(40) primary key, rodzaj_statku enum('transportowy','wojenny'),data_wodowania date, max_ladownosc int unsigned);
#3*
insert into statek values ('Viktoria','wojenny','2020-10-20',10);
insert into statek values ('Galean','transportowy','1980-04-01',30);
#4*
alter table postac add column funkcja varchar(40) after wiek;
#5*
update postac set funkcja='kapitan' where nazwa='Bjorn';
#6*
alter table postac add column na_statku varchar(40) after funkcja;
alter table postac add foreign key (na_statku) references statek(nazwa_statku) on delete cascade;
#7*
update postac set na_statku='Viktoria' where nazwa='Bjorn';
update postac set na_statku='Viktoria' where nazwa='Drozd';
update postac set na_statku='Viktoria' where nazwa='Jamir';
update postac set na_statku='Viktoria' where nazwa='Farben';
update postac set na_statku='Viktoria' where nazwa='Kir';
update postac set na_statku='Viktoria' where nazwa='Andrey';
update postac set na_statku='Viktoria' where nazwa='Wesley';
#8*
delete from izba where nazwa_izby='spizarnia';
#9*
drop table izba;




#zajecia 05-11-2021
#Zadanie 1*
#a) 
DELETE FROM postac WHERE id_postaci IN(8,7);
#b)
SET foreign_key_checks=0;
ALTER TABLE postac MODIFY id_postaci int; 
ALTER TABLE przetwory DROP FOREIGN KEY przetwory_ibfk_1;
ALTER TABLE przetwory DROP FOREIGN KEY przetwory_ibfk_2;
ALTER TABLE walizka DROP FOREIGN KEY walizka_ibfk_1;
ALTER TABLE postac DROP PRIMARY KEY;

#Zadanie 2*
#a)
ALTER TABLE postac ADD COLUMN pesel VARCHAR(11) AFTER data_ur;
UPDATE postac SET pesel='12345678900'+ id_postaci;
ALTER TABLE postac ADD PRIMARY KEY(pesel);
#b)
ALTER TABLE postac MODIFY rodzaj enum('wiking','ptak','kobieta','syrena');
#c)
INSERT INTO postac(id_postaci, nazwa, rodzaj, data_ur, pesel, wiek) VALUES(7,'Gertruda Nieszczera','syrena','1990-12-10','12345678909',31);

#Zadanie 3*
#a)
UPDATE postac SET na_statku='Viktoria' WHERE nazwa LIKE'%a%';
#b)
UPDATE statek SET max_ladownosc=max_ladownosc*0.7 WHERE data_wodowania between '1900-01-01' and '2000-12-31';
#c)
ALTER TABLE postac ADD CONSTRAINT wiekszy_od_1000 CHECK(wiek<1000);

#Zadanie 4*
#a)
ALTER TABLE postac MODIFY rodzaj enum('wiking','ptak','kobieta','syrena','waz');
INSERT INTO postac(id_postaci, nazwa, rodzaj, data_ur, pesel, wiek) VALUES(8,'Loko','waz','2010-10-10','12345678911',11);
#b)
CREATE TABLE marynarz LIKE postac;
INSERT INTO marynarz SELECT*FROM postac WHERE na_statku IS NOT NULL;
#c)
ALTER TABLE marynarz ADD FOREIGN KEY (na_statku) REFERENCES statek(nazwa_statku) ON DELETE CASCADE;

#Zadanie 5*
#a)
UPDATE postac SET na-statku=NULL;
UPDATE marynarz SET na-statku=NULL;
#b)
DELETE FROM postac WHERE id_postaci=5;
#c)
DELETE FROM statek WHERE nazwa_statku = 'Viktoria';
DELETE FROM statek WHERE nazwa_statku = 'Galean';
#d)
ALTER TABLE postac DROP FOREIGN KEY postac_ibfk_1;
ALTER TABLE marynarz DROP FOREIGN KEY marynarz_ibfk_1;
ALTER TABLE postac DROP FOREIGN KEY postac_ibfk_2;
DROP TABLE statek;
#e)
CREATE TABLE zwierz(id INT AUTO_INCREMENT PRIMARY KEY,nazwa VARCHAR(40) NOT NULL, wiek int(3) NOT NULL);
#f)
INSERT INTO zwierz SELECT id_postaci, nazwa, wiek FROM postac WHERE rodzaj='ptak';
INSERT INTO zwierz SELECT id_postaci, nazwa, wiek FROM postac WHERE rodzaj='waz';



#Zajecia 12-11-2021
#Zadanie 1 
#a)
#1 przypadek aktywna baza to baza imienna
CREATE TABLE kreatura SELECT*FROM wikingowie.kreatura;
#2 przypadek aktywna baza to baza wikingowie
CREATE TABLE franczakd.kreatura SELECT*FROM kreatura;

CREATE TABLE franczakd.zasob SELECT*FROM zasob;
CREATE TABLE franczakd.ekwipunek SELECT*FROM ekwipunek;
#b)
SELECT*FROM zasob;
#c)
SELECT*FROM zasob WHERE rodzaj='jedzenie'; 
#d)
SELECT idZasobu, ilosc FROM ekwipunek WHERE idKreatury IN(1,3,5);

#Zadanie 2
#a)
SELECT*FROM kreatura WHERE rodzaj!='wiedzma' and udzwig>=50;
#b)
SELECT*FROM zasob WHERE waga>=2 and waga<=5;
#c)
SELECT*FROM kreatura WHERE nazwa LIKE '%or%' and udzwig>=30 and udzwig<=70;
udzwig>=30 and udzwig<=70;

#Zadanie 3
#a)
SELECT dataPozyskania FROM zasob WHERE MONTH(dataPozyskania) IN(7,8);
#b)
SELECT nazwa, rodzaj FROM zasob WHERE rodzaj IS NOT NULL;
#c)
SELECT*FROM kreatura ORDER BY dataUr ASC LIMIT 5; 
#np limit 5,5; indeks start, indeks elementow

#Zadanie 4
#a)
SELECT DISTINCT rodzaj FROM zasob; #wypisywanie wartosci bez powtorzen
#b)
#CONCAT(lancuch znakow, lancuch znakow,...)
SELECT CONCAT(nazwa,rodzaj) FROM kreatura WHERE rodzaj LIKE '%wi%';
#c)
SELECT CONCAT(nazwa,'  ','calkowita waga','  ',ilosc*waga) FROM zasob WHERE YEAR(dataPozyskania) IN (2000,2001,2002,2003,2004,2005,2006,2007);

#Zadanie 5
#a)
SELECT CONCAT(nazwa,'  ','waga netto','  ',ilosc*waga*0.7,'  ','waga odpadkow','  ',ilosc*waga*0.3) FROM zasob;
#b)
SELECT*FROM zasob WHERE rodzaj is NULL;
#c)
SELECT DISTINCT nazwa,rodzaj FROM zasob WHERE nazwa LIKE'Ba%' OR nazwa LIKE '%os' ORDER BY nazwa ASC;


#AVG()-srednia
#COUNT()-zlicza ilosc elementow
#SUM()- suma wartosci(liczbowych)
#MIN()-minimum
#MAX()-maksimum

#zajecia 19-11-2021
#Zadanie 1*
#a) 
SELECT round(AVG(udzwig),0) FROM kreatura WHERE rodzaj='wiking';
#b)
SELECT rodzaj,AVG(waga), COUNT(nazwa) FROM kreatura GROUP BY rodzaj;
#c)
#now()- dzisiejsza data i czas 
#CURDATE()- dzisiejsza data
SELECT rodzaj, AVG(2021-YEAR(dataUr)) AS 'sredni wiek' FROM kreatura GROUP BY rodzaj;
SELECT rodzaj, AVG(YEAR(CURDATE())-YEAR(dataUr)) AS 'sredni_wiek' FROM kreatura GROUP BY rodzaj;

#Zadanie 2*
#a) 
SELECT rodzaj,SUM(waga)AS 'suma_wag' FROM zasob GROUP BY rodzaj;
#b)
SELECT nazwa, AVG(waga) AS 'srednia_waga' FROM zasob WHERE ilosc>=4 GROUP BY nazwa HAVING SUM(waga)>10;
#c)
SELECT DISTINCT nazwa, COUNT(nazwa) AS 'ilosc_roznych_nazw' FROM zasob  GROUP BY nazwa HAVING SUM(ilosc)>1;
SELECT COUNT(DISTINCT(nazwa)) FROM zasob;

#złączanie wewnetrze where
SELECT*FROM kreatura, ekwipunek WHERE kreatura.idKreatury=ekwipunek.IdKreatury; 
#zlączanie za pomoca INNER JOIN
SELECT*FROM kreatura INNER JOIN ekwipunek ON kreatura.idKreatury=ekwipunek.IdKreatury;

#Zadanie 3*
#a) 
SELECT*FROM kreatura INNER JOIN ekwipunek ON kreatura.idKreatury=ekwipunek.IdKreatury;

SELECT kreatura.nazwa SUM(ekwipunek.ilosc) AS 'ilosc zasobow' FROM kreatura, ekwipunek WHERE kreatura.idKreatury=ekwipunek.IdKreatury GROUP BY kreatura.nazwa;
SELECT kreatura.nazwa, SUM(ekwipunek.ilosc) FROM kreatura INNER JOIN ekwipunek ON kreatura.idKreatury=ekwipunek.IdKreatury GROUP BY kreatura.IdKreatury;

#b)
SELECT*FROM kreatura INNER JOIN ekwipunek ON kreatura.idKreatury=ekwipunek.IdKreatury INNER JOIN zasob ON ekwipunek.idZasobu=zasob.idZasobu;

SELECT kreatura.nazwa, zasob.nazwa FROM kreatura INNER JOIN ekwipunek ON kreatura.idKreatury=ekwipunek.IdKreatury INNER JOIN zasob ON ekwipunek.idZasobu=zasob.idZasobu;

#c)
SELECT k.idKreatury, k.nazwa, e.idKreatury, e.idZasobu FROM kreatura k LEFT JOIN ekwipunek e ON k.idKreatury=e.idKreatury WHERE e.idKreatury IS NULL;

#podzapytanie
SELECT idKreatury, kreatura.nazwa FROM kreatura WHERE idKreatury NOT IN(SELECT DISTINCT idKreatury FROM ekwipunek WHERE idKreatury IS NOT NULL);


#Zadanie 4*
#a) 
SELECT*FROM kreatura natural join ekwipunek, zasob;
SELECT k.nazwa, z.nazwa FROM kreatura k INNER JOIN ekwipunek e ON k.idKreatury=e.idKreatury INNER JOIN zasob z ON e.idZasobu=z.idZasobu where k.rodzaj = 'wiking' and k.dataUr > '1669.12.31' and k.dataUr < '1680.01.01'; 
#b)
SELECT k.nazwa from kreatura k INNER JOIN ekwipunek e ON k.idKreatury=e.idKreatury INNER JOIN zasob z ON e.idZasobu=z.idZasobu where z.rodzaj = 'jedzenie' order by dataUr desc LIMIT 5;
#c)
SELECT j.nazwa, j.idKreatury, k.nazwa, k.idKreatury from kreatura k INNER JOIN kreatura j ON k.idKreatury=j.idKreatury+5;

#Zadanie 5*
#a) 

#b)

#c)
