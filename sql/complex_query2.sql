-- Hamtaro wants to know the total income of very High rating photographers sorted by total income 
-- Language: sql

--------------------------------------------------------------------------------------------------

-- หา 5 อันดับแรก ของช่างภาพที่มีจำนวน review มากที่สุด ที่ใช้ธนาคาร KBANK ในการรับเงิน display เป็น firstname และ lastname และ review amount 
-- ถ้าจำนวนรีวิวเท่ากัน เรียงตาม username

-- Find 5 photographers who have maximum number of reviews and consider only who use KBANK as a money receiving method.
-- Displaying first name, last name, and amount of review.
-- If photographers have the same amount of review, then sorting by first name and last name.
-- If there is a ties for the fifth place, show every entry that ties with the fifth place.


SELECT *
FROM (
                SELECT N.firstname, N.lastname, COUNT(*) AS review_amount
        FROM Photographer P
            JOIN Review R JOIN    User    U
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
            JOIN    User U
    JOIN User_national_id N
    ON U.national_id = N.national_id AND
        P.p_id = U.id
WHERE P.p_id NOT IN (
        SELECT p_id
    FROM Review)
    AND P.bank_name = 'KBANK'
)) AS T
WHERE review_amount >=
(SELECT MIN(review_amount)
FROM (                        SELECT N.firstname, N.lastname, COUNT(*) AS review_amount
        FROM Photographer P
            JOIN Review R JOIN    User    U
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
            JOIN    User U
    JOIN User_national_id N
    ON U.national_id = N.national_id AND
        P.p_id = U.id
WHERE P.p_id NOT IN (
        SELECT p_id
    FROM Review)
    AND P.bank_name = 'KBANK'
)
ORDER BY review_amount DESC LIMIT 5) AS T
);



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
    ('0000000114', '0000000115', 4.0, 'Good but kinda expensive for me'),
    ('0000000115', '0000000114', 1.0, 'GID GUD'),
    ('0000000110', '0000000115', 4.0, 'WELL DONE');


-- add more one comment to Chawan Brook
INSERT INTO Review
VALUES
    ('0000000115', '0000000110', 0.0, 'TASTE MY FIST');