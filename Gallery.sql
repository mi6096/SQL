DROP DATABASE IF EXISTS gallery;
CREATE DATABASE gallery;
USE gallery;

CREATE TABLE goods(
good_no INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
name VARCHAR(100),
type ENUM('1','2','3') NOT NULL,
price DECIMAL NULL DEFAULT NULL,
size VARCHAR(100) NULL DEFAULT NULL,
year YEAR NULL DEFAULT NULL,
artist_id INT NULL DEFAULT NULL
);

CREATE TABLE person(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
address VARCHAR(255),
phone VARCHAR(20),
isArtist BOOLEAN DEFAULT NULL
);

ALTER TABLE goods
ADD CONSTRAINT FOREIGN KEY (artist_id) REFERENCES person(id);

CREATE TABLE services(
id INT AUTO_INCREMENT PRIMARY KEY,
finalPrice DECIMAL NULL DEFAULT NULL,
type ENUM('1','2','3') NOT NULL,
dateCreated DATETIME NOT NULL,
endDate DATETIME NULL DEFAULT NULL,
comment VARCHAR(255) NULL DEFAULT NULL,
size VARCHAR(200) NULL DEFAULT NULL,
empl_name VARCHAR(200) NOT NULL,
isReady BOOLEAN DEFAULT NULL,
isReceived BOOLEAN DEFAULT NULL,
good_id INT NULL DEFAULT NULL,
CONSTRAINT FOREIGN KEY (good_id) REFERENCES goods(good_no),
customer_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (customer_id) REFERENCES person(id),
artist_id INT NULL DEFAULT NULL,
CONSTRAINT FOREIGN KEY (artist_id) REFERENCES person(id)
);


INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Ivan Ivanov', 'Sofia', '0894512', '0');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`) 
VALUES ('Georgi Martinov', 'Sofia', '087452', '1');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Stefan Dimov', 'Sofia', '0785421', '1');
INSERT INTO `gallery`.`person` (`name`, `address`, `phone`, `isArtist`)
VALUES ('Iordan Metodioev', 'Sofia', '0874512', '0');


INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`)
 VALUES ('Mona Liza', '4500', '77X53', '1',null);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`, `artist_id`) 
VALUES ('Kone na vodopoi', '250', '40X80', '1', 2000, '2');
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`, `type`, `year`) 
VALUES ('Ramka ot dyb', '100', '20X22', '2', 2015);
INSERT INTO `gallery`.`goods` (`name`, `price`,`type`, `year`) 
VALUES ('Vaza - monblan', '100','3', 2015);
INSERT INTO `gallery`.`goods` ( `name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot bor', '80', 'y X y cm' ,'2', 2016);
INSERT INTO `gallery`.`goods` (`name`, `price`, `size`,`type`, `year`) 
VALUES ('Ramka ot qsen', '90', 'y X y cm','2', 2016);


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `comment`, `empl_name`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('250', '3', '2016-04-08 17:10:22', 'Vaza-1br', 'Ivan', '1', '4', '1');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`) 
VALUES ('115', '1', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'Risunkata e v profil', '200X150', 'Ivan', '0', '0', '5', '1');
UPDATE `gallery`.`services` SET `endDate`='2016-04-08 17:10:22' WHERE `id`='1';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('200', '2', '2016-04-08 17:10:22', '2016-05-08 17:10:22', 'risuwane w profil', '200x200', 'Ivan', '0', '0', '6', '1', '2');
UPDATE `gallery`.`services` SET `comment`='ramkata e staral' WHERE `id`='2';

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-08 17:10:22', '2016-06-08 17:10:22', 'sds', '200X300', 'Ivan', '0', '0', '6', '1', '3');

INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('280', '2', '2016-04-08 17:10:22', '2016-04-11 17:10:22', 'nqma', '80X200 cm', 'Petar', '1', '1', '3', '1', '2');
INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('300', '2', '2016-04-01 17:10:22', '2016-04-11 17:10:22', 'profil', '180X250', 'Petar', '1', '1', '3', '4', '3');


INSERT INTO `gallery`.`services` (`finalPrice`, `type`, `dateCreated`, `endDate`, `comment`, `size`, `empl_name`, `isReady`, `isReceived`, `good_id`, `customer_id`, `artist_id`) 
VALUES ('310', '2', '2016-04-01 17:10:22', '2016-04-10 17:10:22', 'portret', '200X250', 'Petar', '1', '1', '3', '1', '3');


USE gallery;

SELECT  serv.*,
		customer.name AS custName, 
		artist.name AS artistName
FROM person AS customer JOIN services AS serv
ON serv.customer_id = customer.id
JOIN person AS artist
ON serv.artist_id = artist.id
WHERE serv.type = 2
AND customer.name = 'Ivan Ivanov'
AND serv.isReady = 1 
AND serv.isReceived = 1;

USE gallery;

SELECT customer.name AS CustomerName,
		SUM(serv.finalPrice) AS sumByCust
FROM person AS customer JOIN  services AS serv
ON customer.id = serv.customer_id
WHERE serv.isReady = 1
AND serv.isReceived = 1
GROUP BY serv.customer_id
HAVING sumByCust > (SELECT AVG(finalPrice)
					FROM services)
ORDER BY CustomerName
LIMIT 6;