use northwind;

DELIMITER $$
CREATE FUNCTION `orderline_total_price` (
     UnitPrice double,
     Quantity smallint,
     Discount float
)
RETURNS  double
DETERMINISTIC
BEGIN
DECLARE result_var double;
     SET result_var = (UnitPrice * Quantity) *(1-Discount);
RETURN (result_var);
END$$
DELIMITER;

 
DELIMITER $$
CREATE PROCEDURE `monthly_revenue` ()
BEGIN

WITH revenue AS(
    SELECT 
        SUM(orderline_total_price(UnitPrice, Quantity, Discount)) AS order_revenue,
        YEAR(OrderDate) AS year,
        MONTH(OrderDate) AS month
    FROM
        orders
    JOIN order_details
        ON orders.OrderID = order_details.OrderID
    GROUP BY 
        order_details.OrderID)
SELECT 
    year, 
    month,
    ROUND(SUM(order_revenue), 2) AS monthly_revenue
FROM 
    revenue
GROUP BY year, month
ORDER BY year, month ASC;
    
END$$

DELIMITER ;

call monthly_revenue;


