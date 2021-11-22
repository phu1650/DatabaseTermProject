
-- INDEX

ALTER TABLE User ENGINE = MEMORY;
CREATE INDEX index_username ON User(username) USING HASH;
SHOW INDEXES FROM User;

-- DROP INDEX idx1 ON User;

-- CUSTOMER PROCEDURE 
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

SELECT * FROM user_national_id

-- ---------------- TRIGGER
CREATE TABLE TriggerTime(exec_time datetime NOT NULL);

CREATE TRIGGER CustomerUpdate 
BEFORE UPDATE ON customer 
FOR EACH ROW
INSERT INTO TriggerTime VALUES (NOW()); 

DROP TRIGGER CustomerUpdate;

SELECT * FROM TriggerTime;
