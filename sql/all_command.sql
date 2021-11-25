CREATE DATABASE Outstagram;

GRANT ALL PRIVILEGES ON Outstagram.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
USE Outstagram;

show databases;
SHOW  tables;


GRANT FILE ON *.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
---------------

CREATE TABLE user(
  id VARCHAR(10) NOT NULL,
  national_id VARCHAR(13) NOT NULL,
  username VARCHAR(64) NOT NULL,
  email VARCHAR(64) DEFAULT NULL,
  password VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (id)
);
 
CREATE TABLE customer(
  c_id VARCHAR(10) NOT NULL REFERENCES user(id) ON DELETE CASCADE,
  credit_card VARCHAR(128) DEFAULT NULL,
  PRIMARY KEY (c_id)
);

CREATE TABLE user_national_id(
  national_id VARCHAR(13) NOT NULL REFERENCES user(national_id) ON DELETE CASCADE,
  birthdate DATETIME DEFAULT NULL,
  gender VARCHAR(64) DEFAULT NULL,
  firstname VARCHAR(64) DEFAULT NULL,
  lastname VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (national_id)
);

-- ---------------


DROP TABLE user;
DROP TABLE customer;
DROP TABLE user_national_id;

DROP database outstagram;



-- ---------------
show tables;

select * from user;
select * from photographer;
select * from customer;
select * from user_national_id;

-- ---------------

INSERT INTO user
VALUES
    ('0000000110', '1234567890090', 'phu0', 'phu0@gmail.com', 'phu0'),
    ('0000000111', '1234567890091', 'phu1', 'phu1@gmail.com', 'phu1'),
    ('0000000112', '1234567890092', 'phu2', 'phu2@gmail.com', 'phu2'),
    ('0000000113', '1234567890093', 'phu3', 'phu3@gmail.com', 'phu3'),
    ('0000000114', '1234567890094', 'phu4', 'phu4@gmail.com', 'phu4'),
    ('0000000115', '1234567890095', 'phu5', 'phu5@gmail.com', 'phu5');

INSERT INTO photographer
    (p_id,matching_count,price_min,price_max,bank_name, bank_account)
VALUES
    ('0000000110', 0, 100, 100, 'KBANK', '1000000005'),
    ('0000000111', 0, 100, 100, 'KBANK', '1000000006'),
    ('0000000112', 0, 100, 100, 'KBANK', '1000000007'),
    ('0000000113', 0, 100, 100, 'KBANK', '1000000008'),
    ('0000000114', 0, 100, 100, 'KBANK', '1000000009'),
    ('0000000115', 0, 100, 100, 'KBANK', '1000000010');

INSERT INTO user_national_id
VALUES
    ('1234567890090', '2008-11-11', 'M', 'John', 'Smith'),
    ('1234567890091', '2008-11-12', 'F', 'Ekapol', 'Chuangsuwanich'),
    ('1234567890092', '2008-11-13', 'M', 'Atiwong', 'Sucha-to'),
    ('1234567890093', '2008-11-14', 'F', 'Phusaratis', 'Jong'),
    ('1234567890094', '2008-11-15', 'M', 'John', 'Xina'),
    ('1234567890095', '2008-11-16', 'F', 'Chawan', 'Brook');


INSERT INTO review
VALUES
    ('0000000110', '0000000111', 2.0, 'bad mak mak'),
    ('0000000111', '0000000110', 5.0, 'so goooooood'),
    ('0000000112', '0000000111', 4.0, 'nice pic'),
    ('0000000112', '0000000113', 2.5, 'hmmmmm'),
    ('0000000113', '0000000112', 3.0, 'so so'),
    ('0000000113', '0000000114', 0.0, 'MY FIST'),
	('0000000113', '0000000110', 0.0, 'TASTE MY FIST'),
    ('0000000114', '0000000115', 4.0, 'Good but kinda expensive for me'),
    ('0000000115', '0000000114', 1.0, 'GID GUD'),

    ('0000000110', '0000000115', 4.0, 'WELL DONE');

INSERT INTO Review
VALUES
('0000000115', '0000000110', 0.0, 'TASTE MY FIST');


DELETE FROM user U where U.username = 'phu';

SELECT * FROM user as U JOIN customer as C ON U.id=C.c_id;
SELECT * FROM user NATURAL JOIN customer NATURAL JOIN user_national_id WHERE username = 'nattee';
UPDATE user SET password='123' WHERE username='nattee';
UPDATE user SET password='123' WHERE id='0000000003';
UPDATE user SET password='569' WHERE id='0000000003';

SELECT * FROM user AS U JOIN customer AS C JOIN user_national_id AS UID ON C.c_id = id AND U.national_id =  UID.national_id ;

select * from user_national_id;
select * from customer;
select * from user;


SELECT N.firstname, N.lastname, count(*) as review_amount
FROM Photographer P 
NATURAL JOIN Review R 
JOIN User U JOIN user_national_id N 
on P.p_id = R.p_id 
AND  P.p_id = U.id
AND U.national_id= N.national_id
WHERE bank_name  = 'KBANK'
GROUP BY p_id;



select * FROM 
Photographer P 
NATURAL JOIN Review R 
JOIN User U JOIN user_national_id N 
on P.p_id = R.p_id 
AND  P.p_id = U.id
AND U.national_id= N.national_id;

show tables;

select * from User U join photographer P JOIN user_national_id N  on p.p_id = U.id AND U.national_id= N.national_id;

SELECT N.firstname, N.lastname, count(*) as review_amount
FROM Photographer P
    JOIN Review R ON P.p_id = R.p_id
    JOIN User U ON P.p_id = U.id
    JOIN User_national_id N ON U.national_id = N.national_id
WHERE bank_name  = 'KBANK'
GROUP BY P.p_id
UNION
(
    SELECT DISTINCT firstname, lastname, 0 as review_amount
    from User U join photographer P JOIN user_national_id N  on p.p_id = U.id AND U.national_id= N.national_id
    AND U.national_id = N.national_id
    WHERE p.p_id NOT IN (
        SELECT p_id
        FROM Review) 
    AND P.bank_name = "KBANK"
)
ORDER BY review_amount DESC LIMIT 5,firstname;





SELECT * FROM (
SELECT N.firstname, N.lastname, COUNT(*) AS review_amount
FROM Photographer P
    JOIN Review R JOIN User U 
    JOIN User_national_id N 
    ON U.national_id = N.national_id AND 
    P.p_id = R.p_id AND 
    P.p_id = U.id
WHERE bank_name = 'KBANK'
GROUP BY P.p_id
UNION
(
    SELECT DISTINCT firstname, lastname, 0 AS review_amount
    FROM Photographer P
    JOIN User U 
    JOIN User_national_id N 
    ON U.national_id = N.national_id AND 
    P.p_id = U.id
    WHERE P.p_id NOT IN (
        SELECT p_id
        FROM Review)
    AND P.bank_name = 'KBANK'
)) AS T
WHERE review_amount>=(SELECT MIN(review_amount) 
FROM (SELECT N.firstname, N.lastname, COUNT(*) AS review_amount
FROM Photographer P
    JOIN Review R JOIN User U 
    JOIN User_national_id N 
    ON U.national_id = N.national_id AND 
    P.p_id = R.p_id AND 
    P.p_id = U.id
WHERE bank_name = 'KBANK'
GROUP BY P.p_id
UNION
(
    SELECT DISTINCT firstname, lastname, 0 AS review_amount
    FROM Photographer P
    JOIN User U 
    JOIN User_national_id N 
    ON U.national_id = N.national_id AND 
    P.p_id = U.id
    WHERE P.p_id NOT IN (
        SELECT p_id
        FROM Review)
    AND P.bank_name = 'KBANK'
)
ORDER BY review_amount DESC LIMIT 5) AS T)
ORDER BY review_amount DESC,firstname,lastname;



-- INDEX

ALTER TABLE User ENGINE = MEMORY;
CREATE INDEX index_username ON User(username) USING HASH;
SHOW INDEXES FROM User;

DROP INDEX index_username ON User;


CUSTOMER PROCEDURE 
DELIMITER $$
CREATE PROCEDURE GetCustomer(IN name VARCHAR(64))
BEGIN
	SELECT * FROM user AS U JOIN customer AS C JOIN user_national_id AS UID 
    ON C.c_id = id AND U.national_id =  UID.national_id  
    WHERE U.username = name;
END $$
DELIMITER ; 

DROP PROCEDURE GetCustomer;

CALL GetCustomer('phu');

-- ---------------- PRESENT

USE Outstagram;
SELECT * FROM user AS U JOIN customer AS C JOIN user_national_id AS UID ON C.c_id = id AND U.national_id =  UID.national_id ;

SELECT * FROM user_national_id;

-- TRIGGER

CREATE TABLE TriggerTime(exec_time datetime NOT NULL);

CREATE TRIGGER CustomerUpdate 
BEFORE UPDATE ON customer 
FOR EACH ROW
INSERT INTO TriggerTime VALUES (NOW()); 

DROP TRIGGER CustomerUpdate;

SELECT * FROM TriggerTime;

-- ------------------- PROCEDURE 1

DELIMITER $$
CREATE PROCEDURE GetPhotographerPriceRange (IN min Float , IN max Float)
BEGIN
	SELECT * 
    FROM photographer P
    WHERE P.price_min >= min AND P.price_max <= max;
END $$
DELIMITER ; 

SELECT * from photographer;


CALL GetPhotographerPriceRange(0,4000);

-- ------------------- PROCEDURE 3

DELIMITER $$
CREATE PROCEDURE GetPhotographerAvgRating (IN pid varchar(10) )
BEGIN
	SELECT avg(rating) 
    FROM review 
    GROUP BY p_id 
    HAVING p_id = pid ;
END $$
DELIMITER ; 
SELECT * from photographer;


CALL GetPhotographerAvgRating('0000000005');

-- -------------------- TRIGGER

DELIMITER $$
CREATE TRIGGER ChatRoomCreate
AFTER INSERT ON Matching FOR EACH ROW
BEGIN
	IF NEW.status = 'p_accept_match' THEN
		INSERT INTO chat (p_id,c_id)
        VALUES (NEW.p_id,NEW.c_id);
	END IF;
END $$
DELIMITER ; 

SELECT * from photographer;
CALL GetPhotographerAvgRating('0000000005');


-- -------------------- COMPLEX 1

SELECT firstname,lastname,avg_rating,price_min,price_max
FROM user U
JOIN photographer P on P.p_id = U.id
NATURAL JOIN user_national_id 
NATURAL JOIN avg_rating_p
WHERE p_id IN (SELECT p_id
FROM photographer
      NATURAL JOIN matching
      NATURAL JOIN payment
      NATURAL JOIN review
      NATURAL JOIN avg_rating_p
WHERE c_id = '0000000004' AND amount <= 3000 
) 
ORDER BY avg_rating DESC
LIMIT 10;

-- --------------------  COMPLEX 3

select (r6.total)/(r8.people) as average, r6.brand as brand from
  (select sum(r5.total) as total, r5.brand as brand from
    (select distinct r4.p_id as p_id,r4.total as total, brand from equipment natural join equipment_series natural join
      (select r2.p_id as p_id, r3.total as total from 
        (select r1.id as p_id from photographer, 
          (select id, birthdate from user natural join user_national_id where
            birthdate between '1997-01-01' and '2008-12-31') r1
          where r1.id = photographer.p_id) r2 
          join
          (select p_id, sum(amount) as total from matching natural join payment 
          where payment.datetime BETWEEN '2015-11-01' AND '2015-11-30' 
          group by p_id) r3
      where r2.p_id = r3.p_id) r4
    where type = 'camera') r5
  group by r5.brand ) r6 natural join
  (select count(r7.p_id) as people, r7.brand as brand from 
  (select distinct p_id, brand from equipment natural join equipment_series
  where type = 'camera') r7
  group by r7.brand) r8
order by average desc;



CREATE TABLE equipment(
  series VARCHAR(255) NOT NULL ,
  p_id VARCHAR(10) NOT NULL REFERENCES photographer(p_id) ON DELETE NO ACTION,
  price INT NOT NULL ,
  PRIMARY KEY (series,p_id),
  CHECK (price > 0 )
);

CREATE TABLE equipment_series(
  series VARCHAR(255) NOT NULL REFERENCES equipment(series) ON DELETE CASCADE,
  brand VARCHAR(255) NOT NULL,
  type enum('camera', 'lens', 'other') NOT NULL,
  PRIMARY KEY (series)
);

INSERT INTO equipment VALUES
('A100','0000000005',29999),
('B200','0000000006',31999),
('C300','0000000007',46099),
('D400','0000000008',59999),
('E500','0000000006',99000),
('B250','0000000006',30999),
('C350','0000000007',32599),
('D450','0000000008',12999),
('B275','0000000006',10999);

INSERT INTO equipment_series VALUES
('A100','CANON','camera'),
('B200','SONY','lens' ),
('C300','OLYMPUS','camera'),
('D400','PANASONIC','camera'),
('E500','METAVERSE','camera'),
('B250','SONY','camera'),
('C350','SONY','camera'),
('D450','METAVERSE','camera'),
('B275','SONY','camera');

