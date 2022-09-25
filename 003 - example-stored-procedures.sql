-- use magist;
-- drop procedure procedure_name;

# Example 1: simple procedure
delimiter $$
CREATE PROCEDURE `procedure_name` ()
BEGIN
	SELECT * 
	FROM orders;
END$$
delimiter ;
# test simple procedure
call procedure_name;

# Example 2: platform
-- drop procedure top_ten_earning_cities; 
DELIMITER $$
CREATE PROCEDURE `top_ten_earning_cities` ()
BEGIN
 
WITH cities_ranked AS(
     SELECT
          RANK() OVER(ORDER BY ROUND(SUM(op.payment_value), 2) DESC) ranking,
          g.city,
          ROUND(SUM(op.payment_value), 2) total_revenue
     FROM order_payments op
     JOIN orders o
          using (order_id)
     JOIN customers c
          using (customer_id)
     JOIN geo g
          ON g.zip_code_prefix = c.customer_zip_code_prefix
     GROUP BY 2
)
SELECT *
FROM cities_ranked
WHERE ranking <= 10;
 
END$$
 
DELIMITER ;
# call it
call top_ten_earning_cities;
