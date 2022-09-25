USE magist;

-- Select all the products from the health_beauty or perfumery categories that 
--  have been paid by credit card with a payment amount of more than 1000$,
-- from orders that were purchased during 2018 and have a ‘delivered’ status?
SELECT *
FROM (
			SELECT payment_type
			FROM order_payments
			WHERE payment_type = "credit_card" 
			AND	  payment_value >1000	) AS CreditCard,
            
	(		SELECT order_status, order_purchase_timestamp
	 FROM orders
     WHERE order_purchase_timestamp >  "2018-01-01 00:00:00" 
     AND order_status = "delivered") AS datum,   
products
WHERE products.product_category_name = "perfumaria" OR "beleza_saude";


-- For the products that you selected, get the following information:
	-- The average weight of those products
    SELECT *
FROM (
			SELECT payment_type
			FROM order_payments
			WHERE payment_type = "credit_card" 
			AND	  payment_value >1000	) AS CreditCard,
            
	(		SELECT order_status, order_purchase_timestamp
	 FROM orders
     WHERE order_purchase_timestamp >  "2018-01-01 00:00:00" 
     AND order_status = "delivered") AS datum,   
products,
	(
			SELECT AVG(product_weight_g) 
			FROM products
      )  AS Average    
			  
WHERE products.product_category_name = "perfumaria" OR "beleza_saude";

	-- The cities where there are sellers that sell those products
SELECT *
FROM (
			SELECT payment_type
			FROM order_payments
			WHERE payment_type = "credit_card" 
			AND	  payment_value >1000	) AS CreditCard,
            
	(		SELECT order_status, order_purchase_timestamp
	 FROM orders
     WHERE order_purchase_timestamp >  "2018-01-01 00:00:00" 
     AND order_status = "delivered") AS datum,  
	(SELECT city
	  FROM geo) AS cities,
products
WHERE products.product_category_name = "perfumaria" OR "beleza_saude";    
	-- The cities where there are customers who bought products
SELECT *
FROM (
			SELECT payment_type
			FROM order_payments
			WHERE payment_type = "credit_card" 
			AND	  payment_value >1000	) AS CreditCard,
            
	(		SELECT order_status, order_purchase_timestamp
	 FROM orders
     WHERE order_purchase_timestamp >  "2018-01-01 00:00:00" 
     AND order_status = "delivered") AS datum,  
	(SELECT city
	  FROM geo) AS cities,
products
WHERE products.product_category_name = "perfumaria" OR "beleza_saude";
SELECT *
FROM geo
Join customers ON customers.customer_zip_code_prefix = geo.zip_code_prefix;