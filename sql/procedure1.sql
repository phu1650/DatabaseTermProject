DELIMITER $$
CREATE PROCEDURE GetPhotographerPriceRange (IN min Float , IN max Float)
BEGIN
	SELECT * 
    FROM photographer P
    WHERE P.price_min >= min AND P.price_max <= max;
END $$
DELIMITER ; 