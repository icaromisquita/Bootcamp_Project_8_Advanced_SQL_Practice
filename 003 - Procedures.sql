USE northwind;

DELIMITER $$
CREATE PROCEDURE `monthly_revenue` ()
BEGIN

WITH revenue AS(
    SELECT 
        SUM((UnitPrice * Quantity) * (1 - Discount)) AS order_revenue,
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
GROUP BY
    year,
    month
ORDER BY 
    year, 
    month ASC;
    
END$$

DELIMITER ;

CALL monthly_revenue;