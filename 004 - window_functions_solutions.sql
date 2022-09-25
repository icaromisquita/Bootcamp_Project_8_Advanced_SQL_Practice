/*
With a function that includes window functions, select all orders with their corresponding products in order_items. 
We want only the orders with a shipping_limit_date before midnight 2016-10-09. 
Add a column called total_order_price with a sum of the price of all products belonging to the same order. 
And add another column showing how many products were in each order.
*/

SELECT
    order_id,
	product_id,
    price AS product_price,
    ROUND(SUM(price) OVER (PARTITION BY order_id), 2) total_order_price,
    COUNT(product_id) OVER (PARTITION BY order_id) no_of_products
FROM 
    order_items
WHERE 
    shipping_limit_date < '20161010';

/*
Now let’s go for a challenge that also involves getting information from other tables. 
We want to see how much people spent in a particular category on a specific day. 

Select purchased items from order_items that meet these conditions:

Their order_purchase_timestamp date is 2016-10-09
Their order_status is “delivered”
To which category does this product belong? –> English category name, not Portuguese
Add a column called avg_category_payment with the average price of the items belonging to the same category.
Add a column called category_total_sales with the summation of the prices for products belonging to the category
Order the rows by category_total_sales, so we can see which category has made the largest sales on 2016-10-09
*/

SELECT 
	oi.product_id, 
	p_eng.product_category_name_english category_english,
    ROUND(AVG(oi.price) OVER (PARTITION BY p_eng.product_category_name_english), 2) avg_category_payment,
    oi.price product_price,
    ROUND(SUM(oi.price) OVER (PARTITION BY p_eng.product_category_name_english), 2) category_total_sales
FROM 
	order_items oi
LEFT JOIN 
	orders o
		using(order_id)
LEFT JOIN 
	products p
		using (product_id)
LEFT JOIN 
	product_category_name_translation p_eng
		using (product_category_name)
WHERE 
	order_purchase_timestamp < '20161010'
AND 
	order_purchase_timestamp > '20161009'
AND 
	order_status = 'delivered'
ORDER BY 
	category_total_sales DESC;