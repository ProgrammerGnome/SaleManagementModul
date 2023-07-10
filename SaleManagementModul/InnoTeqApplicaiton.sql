/*
 * Adatbázis létrehozó DDL fájl az InnoTeqApplication SpringBoot projekthez.
 * 
 * (Használata nem feltétlen szükséges, mivel a model osztályok alapján a
 * Hibernate létrehozza az adatbázis táblákat, kapcsolatokat és jogosultságaikat.)
 * 
 * Azonban a fájl végefelé láthatunk példát az adatbeszúrásra is.
*/

-- 'product_info' tábla létrehozása
CREATE TABLE product_info (
    product_name VARCHAR(255) PRIMARY KEY,
    unit_price INTEGER
);

-- 'item' tábla létrehozása
CREATE TABLE item (
    item_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255),
    quantity INTEGER,
    price INTEGER
);

-- 'person' tábla létrehozása
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    person_name VARCHAR(200)
);

-- 'sale' tábla létrehozása
CREATE TABLE sale (
    sale_id SERIAL PRIMARY KEY,
    person_id INTEGER,
    item_id INTEGER,
    datetime DATE,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES item (item_id) ON DELETE CASCADE
);

-- Kapcsolótábla a 'item' és 'product_info' táblák közötti many-to-many kapcsolathoz
CREATE TABLE item_product (
    item_id INTEGER,
    product_name VARCHAR(255),
    PRIMARY KEY (item_id, product_name),
    FOREIGN KEY (item_id) REFERENCES item (item_id),
    FOREIGN KEY (product_name) REFERENCES product_info (product_name)
);

-- 'closed' tábla létrehozása
CREATE TABLE closed (
	sale_id SERIAL PRIMARY KEY,
	person_name VARCHAR(200),
	product_name VARCHAR(255),
	quantity INTEGER,
	price INTEGER,
	person_id SERIAL,
	datetime DATE,
	closed_date DATE
);

/* 
 * PÉLDA RANDOM ADATOK BESZÚRÁSA AZ ADATBÁZISBA:
*/

-- Termékek és egységáraik beszúrása a DB-be
INSERT INTO product_info (product_name, unit_price) VALUES ('KANIA Majonéz 620g', '799');
INSERT INTO product_info (product_name, unit_price) VALUES ('HAZÁNK KINCSEI Szeletelt szalámi 100g', '489');
INSERT INTO product_info (product_name, unit_price) VALUES ('Kígyóuborka 1db', '188');

-- Minta (aktív) értékesítések beszúrása a DB-be
INSERT INTO person (person_id, person_name) VALUES ('31','Minta Anita');
INSERT INTO item (item_id, product_name, quantity, price) VALUES ('23','KANIA Majonéz 620g','7','5593');
INSERT INTO sale (sale_id, datetime, person_id, item_id) VALUES ('96','2023-04-23 08:50:18.104','31','23');

INSERT INTO person (person_id, person_name) VALUES ('160','Teszt Elek');
INSERT INTO item (item_id, product_name, quantity, price) VALUES ('203','KANIA Majonéz 620g','2','1598');
INSERT INTO sale (sale_id, datetime, person_id, item_id) VALUES ('9','2022-09-23 10:10:18.104','160','203');

INSERT INTO person (person_id, person_name) VALUES ('32','Bud Spencer');
INSERT INTO item (item_id, product_name, quantity, price) VALUES ('51','HAZÁNK KINCSEI Szeletelt szalámi 100g','4','1956');
INSERT INTO sale (sale_id, datetime, person_id, item_id) VALUES ('182','2023-05-20 16:05:18.104','32','51');

-- Minta (lezárt) értékesítések beszúrása a DB-be
INSERT INTO closed (sale_id, person_name, product_name, quantity, price, person_id, datetime, closed_date) VALUES ('6','Leteszt Ellek','KANIA Majonéz 620g','2','1598','8','2022-10-29 14:58:18.104','2023-05-22 14:58:18.104');
INSERT INTO closed (sale_id, person_name, product_name, quantity, price, person_id, datetime, closed_date) VALUES ('10','John Doe','KANIA Majonéz 620g','4','3196','17','2022-07-12 14:19:18.104','2023-05-22 14:51:18.102');
INSERT INTO closed (sale_id, person_name, product_name, quantity, price, person_id, datetime, closed_date) VALUES ('16','Példa Béla','Kígyóuborka 1db','5','940','3','2022-03-20 12:04:18.154','2022-11-23 10:50:18.104');
