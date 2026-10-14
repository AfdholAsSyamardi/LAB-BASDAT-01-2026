-- SOAL 1: Ringkasan Audit Pembayaran Pelanggan
SELECT 
    customerNumber, 
    SUM(amount) AS "Total Akumulasi", 
    COUNT(checkNumber) AS "Frekuensi Transaksi", 
    MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING COUNT(checkNumber) > 4 AND AVG(amount) > 20000;

-- SOAL 2: Evaluasi Kontribusi Keuangan Pelanggan
SELECT 
    customerNumber, 
    SUM(amount) AS "Total Setoran"
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY "Total Setoran" DESC;


-- SOAL 3: Evaluasi Kepadatan Kategori Barang
SELECT 
    productLine, 
    COUNT(productCode) AS "Jumlah Ragam Produk", 
    ROUND(AVG(MSRP), 2) AS "Rata-rata Harga", 
    STRING_AGG(productName, ', ') AS "Daftar Produk"
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;


-- SOAL 4: Daftar Tunjangan Kepemimpinan (Himpunan)
SELECT reportsTo AS "ID Karyawan"
FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle ILIKE '%VP%' OR jobTitle ILIKE '%President%';


-- SOAL 5: Evaluasi Performa Produk Bernilai Tinggi 
SELECT 
    productCode, 
    SUM(quantityOrdered) AS "Total Unit Terjual", 
    ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Jual"
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY "Total Unit Terjual" DESC;


-- SOAL 6: Evaluasi Volatilitas Harga Saat Dipesan
SELECT 
    productCode, 
    SUM(quantityOrdered) AS "Total Unit Dipesan", 
    SUM(quantityOrdered * priceEach) AS "Estimasi Pendapatan Kotor", 
    ROUND(AVG(priceEach), 2) AS "Rata-rata Harga Satuan", 
    (MAX(priceEach) - MIN(priceEach)) AS "Rentang Volatilitas Harga"
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY "Estimasi Pendapatan Kotor" DESC;


-- SOAL 7: Penelusuran Klien Bermasalah (Irisan & Pengecualian).
SELECT customerNumber FROM customers WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber FROM orders WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber FROM payments GROUP BY customerNumber HAVING SUM(amount) > 100000;

	