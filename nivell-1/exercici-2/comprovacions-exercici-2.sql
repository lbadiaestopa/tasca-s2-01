USE tasca_s2_01_n1_e2;

SELECT SUM(oq.quantity)
FROM `order` o
JOIN order_quantity oq ON o.order_id = oq.order_id
JOIN product p ON oq.product_id = p.product_id
JOIN shop s ON o.shop_id = s.shop_id
WHERE p.description = 'Beguda' AND s.city = 'Barcelona';

SELECT COUNT(*) AS total_orders
FROM `order` o
WHERE employee_id = 2;

