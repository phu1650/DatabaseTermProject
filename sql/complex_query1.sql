-- - แสดงข้อมูล photographer ที่มี rating avg สูงสุด 10 อันดับแรก ที่มีราคาไม่เกิน 3000 (อิงมาจากการจ่ายจริง) และ customer คนนี้เคยใช้ (customer = nattee)


CREATE VIEW avg_rating_p AS
SELECT p_id,avg(rating) AS avg_rating
    FROM review 
    GROUP BY p_id;

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