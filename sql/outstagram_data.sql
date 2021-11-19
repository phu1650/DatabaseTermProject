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
 
CREATE TABLE payment(
  pay_id VARCHAR(10) NOT NULL REFERENCES user(id) ON DELETE CASCADE,
  pay_status ENUM('incomplete','complete') DEFAULT 'incomplete',
  amount FLOAT(10,2) NOT NULL, 
  datetime DATETIME NOT NULL,
  PRIMARY KEY (pay_id)
);

CREATE TABLE review(
  p_id VARCHAR(10) NOT NULL REFERENCES photographer(p_id) ON DELETE NO ACTION,
  c_id VARCHAR(10) NOT NULL REFERENCES customer(c_id) ON DELETE NO ACTION,
  rating FLOAT(2,1) NOT NULL,
  message TEXT DEFAULT NULL,
  PRIMARY KEY (p_id,c_id)
);

CREATE TABLE photographer(   
  p_id VARCHAR(10) NOT NULL REFERENCES user(id) ON DELETE CASCADE,   
  matching_count INT NOT NULL DEFAULT 0,
  location JSON DEFAULT NULL,
  style VARCHAR(64) DEFAULT NULL,
  price_min FLOAT(10,2) DEFAULT 0, 
  price_max FLOAT(10,2) DEFAULT 99999999.99,
  bank_name VARCHAR(6) DEFAULT NULL,
  bank_account VARCHAR(10) DEFAULT NULL, 
  PRIMARY KEY (p_id)
);

CREATE TABLE matching(
  p_id VARCHAR(10) NOT NULL REFERENCES photographer(p_id) ON DELETE NO ACTION,
  c_id VARCHAR(10) NOT NULL REFERENCES customer(c_id) ON DELETE NO ACTION,
  pay_id VARCHAR(10) NOT NULL REFERENCES payment(pay_id) ON DELETE NO ACTION,
  status ENUM('p_accept_match','p_deny_match','c_accept_price','c_deny_price','complete_task','send_result','accept_result') NOT NULL,
  PRIMARY KEY (p_id,c_id,pay_id)
);

CREATE TABLE chat(
  p_id VARCHAR(10) NOT NULL REFERENCES photographer(p_id) ON DELETE NO ACTION,
  c_id VARCHAR(10) NOT NULL REFERENCES customer(c_id) ON DELETE NO ACTION,
  chat_log JSON DEFAULT NULL,
  PRIMARY KEY (p_id, c_id)
);

INSERT INTO user VALUES 
('0000000001','1234567890121','phu','phu@gmail.com','pass1'),
('0000000002','1234567890122','bow','bow@gmail.com','pass2'),
('0000000003','1234567890123','pepper','pepper@gmail.com','pass3'),
('0000000004','1234567890124','nattee','nattee@gmail.com','pass4');

INSERT INTO customer VALUES 
('0000000001','credit1'),
('0000000002','credit2'),
('0000000003','credit3'),
('0000000004','credit4');

INSERT INTO user_national_id VALUES 
('1234567890121','2008-11-11','M','Phu','Jongsaratis'),
('1234567890122','2008-11-12','F','Wipawan','Temterakij'),
('1234567890123','2008-11-13','M','Pepper','Pepper'),
('1234567890124','2008-11-14','M','Nattee','Nepanan');

INSERT INTO user VALUES 
('0000000005','1234567890125','put','put@gmail.com','pass5'),
('0000000006','1234567890126','yod','yod@gmail.com','pass6'),
('0000000007','1234567890127','peem','peem@gmail.com','pass7'),
('0000000008','1234567890128','aof','aof@gmail.com','pass8');

INSERT INTO user_national_id VALUES 
('1234567890125','2008-10-01','M','Puttinart','Puto'),
('1234567890126','2008-10-02','M','Pakorn','Naja'),
('1234567890127','2008-10-03','M','Peemaphoj','Phojmapeem'),
('1234567890128','2008-10-04','M','Aof','Pongsak');

INSERT INTO photographer 
(p_id,matching_count,price_min,price_max,bank_name, bank_account) VALUES
('0000000005',0,100,100,'BBL','1000000005'),
('0000000006',1,200,1000,'KBANK','1000000006'),
('0000000007',2,300,2000,'TFB','1000000007'),
('0000000008',2,400,5000,'SCB','1000000008');

INSERT INTO review VALUES
('0000000006','0000000002',3.0,'test'),
('0000000007','0000000001',4.0,'good'),
('0000000007','0000000003',5.0,'perfect'),
('0000000008','0000000004',4.5,'nice'),
('0000000008','0000000003',2.5,'bad');

-- --------------------------------------------------------------------

INSERT INTO payment VALUES
('1111111111','complete','4000','2015-11-05 14:29:36'),
('1111111110','complete','3000','2015-11-04 14:29:36'),
('1111111101','complete','2000','2015-11-03 14:29:36'),
('1111111100','complete','1000','2015-11-02 14:29:36'),
('1111111011','complete','500','2015-11-01 14:29:36');

INSERT INTO matching VALUES
('0000000008','0000000003','1111111111','complete_task'),
('0000000008','0000000004','1111111110','complete_task'),
('0000000007','0000000003','1111111101','complete_task'),
('0000000007','0000000001','1111111100','complete_task'),
('0000000006','0000000002','1111111011','complete_task');



-- extend for nattee

INSERT INTO payment VALUES
('0000000001','complete','4000','2000-11-01 14:29:00'),
('0000000010','complete','3000','2010-11-01 14:29:10'),
('0000000011','complete','2000','2020-11-01 14:29:20');



INSERT INTO matching VALUES
('0000000007','0000000004','0000000001','complete_task'),
('0000000006','0000000004','0000000010','complete_task'),
('0000000005','0000000004','0000000011','complete_task');


INSERT INTO review VALUES
('0000000005','0000000004',4.5,'noice'),
('0000000006','0000000004',1.5,'wowza'),
('0000000007','0000000004',3.2,'subarashi destsune');

