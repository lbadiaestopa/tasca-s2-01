USE tasca_s2_01_n1_e1;

SELECT *
FROM sale s
JOIN client c
ON s.client_id = c.client_id
WHERE s.client_id = 1;

SELECT *
FROM sale s
JOIN employee c
ON s.employee_id = c.employee_id
WHERE s.employee_id = 1 AND s.sale_date BETWEEN '2026-01-01' AND '2026-12-31';

SELECT DISTINCT
    su.supplier_id,
    su.name
FROM sale s
JOIN model m ON s.model_id = m.model_id
JOIN brand b ON m.brand_id = b.brand_id
JOIN supplier su ON b.supplier_id = su.supplier_id
