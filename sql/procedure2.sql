DELIMITER $$
CREATE PROCEDURE GetPhotographerAvgRating (IN pid varchar(10) )
BEGIN
	SELECT avg(rating) 
    FROM review 
    GROUP BY p_id 
    HAVING p_id = pid ;
END $$
DELIMITER ; 