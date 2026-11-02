-- soal 1
SELECT
	productCode,
	productName,
	MSRP,
	quantityInStock,
	CASE
		WHEN MSRP < 50 AND quantityInStock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN MSRP < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN MSRP >= 50 AND MSRP <= 100 THEN 'Harga Menengah'
		WHEN MSRP > 100 THEN 'Harga Premium'
	END AS Kategori
FROM products
ORDER BY MSRP DESC;

--soal 2
SELECT 
	productCode,
	SUM(quantityOrdered) AS total_unit_terjual,
	COUNT(DISTINCT orderNumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productCode
HAVING
	SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails)
ORDER BY total_unit_terjual DESC;


--soal3
SELECT 
	productCode,
	productName,
	quantityInStock,
	MSRP
FROM products
WHERE 
	quantityInStock > (SELECT AVG(quantityInStock) FROM products)
	AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;



--soal4
BEGIN;

UPDATE orders 
SET status = 'Pengiriman'
WHERE orderNumber = 10100

SAVEPOINT status_pengiriman

UPDATE orders
SET status = 'Batal'
WHERE orderNumber = 10100


ROLLBACK TO SAVEPOINT status_pengiriman ;

COMMIT;

	




