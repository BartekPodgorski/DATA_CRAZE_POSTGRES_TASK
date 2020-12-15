SET datestyle TO 'DMY'

--1. Wy�wietl unikatowe daty stworzenia produkt�w (wed�ug atrybutu manufactured_date)
SELECT DISTINCT manufactured_date
	FROM products;

--2.Jak sprawdzisz czy 10 wstawionych produkt�w to 10 unikatowych kod�w produkt�w?
SELECT COUNT(DISTINCT product_code)
	FROM products;

--3.Korzystaj�c ze sk�adni IN wy�wietl produkty od kodach PRD1 i PRD9
SELECT product_name
	FROM products
	WHERE product_code IN ('PRD1','PRD9');
--4Wy�wietl wszystkie atrybuty z danych sprzeda�owych, takie �e data sprzeda�y jest w zakresie od 1 sierpnia 2020 do 31 sierpnia 2020 (w��cznie). 
--Dane wynikowe maj� by� posortowane wed�ug warto�ci sprzeda�y malej�co i daty sprzeda�y rosn�co.
SELECT * 
	FROM sales
	WHERE sal_date BETWEEN '1/08/2020' AND '31/08/2020'
	ORDER BY sal_value DESC , sal_date ASC ;
	
--5. Korzystaj�c ze sk�adni NOT EXISTS wy�wietl te produkty z tabeli PRODUCTS, kt�re nie bior� udzia�u w transakcjach sprzeda�owych (tabela SALES). 
--ID z tabeli Products i SAL_PRODUCT_ID to klucz ��czenia.
SELECT *
FROM products p 
WHERE NOT EXISTS(SELECT 1
					FROM sales s
					WHERE p.id = s.sal_product_id);
				
--6. Korzystaj�c ze sk�adni ANY i operatora = wy�wietl te produkty, kt�rych wyst�puj� w transakcjach sprzeda�owych 
--(wed�ug klucza Products ID, Sales SAL_PRODUCT_ID) takich, �e warto�� sprzeda�y w transakcji jest wi�ksza od 100.
SELECT DISTINCT *
	FROM products p
	WHERE p.id = any(SELECT DISTINCT s.sal_product_id
							FROM sales s
							WHERE s.sal_value > 100);
						
--7.Stw�rz now� tabel� PRODUCTS_OLD_WAREHOUSE o takich samych kolumnach jak istniej�ca tabela produkt�w (tabela PRODUCTS). 
--Wstaw do nowej tabeli kilka wierszy - dowolnych wed�ug Twojego uznania.

CREATE TABLE PRODUCTS_OLD_WAREHOUSE(
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now()
);	

INSERT INTO PRODUCTS_OLD_WAREHOUSE (product_name,product_code,product_quantity,manufactured_date) 
	VALUES ('Product Best Seller', 'PRD1',13, '20/11/2006'),
 	 		('Product Most Important', 'PRD2',56, '1/11/2009'),
 	 		('Product World Class', 'PRD3',82, '1/11/2008');						

SELECT * FROM PRODUCTS_OLD_WAREHOUSE;
--8.Na podstawie tabeli z zadania 7, korzystaj�c z operacji UNION oraz UNION ALL po��cz tabel� PRODUCTS_OLD_WAREHOUSE z 5 dowolnym produktami z tabeli PRODUCTS, 
--w wyniku wy�wietl jedynie nazw� produktu (kolumna PRODUCT_NAME) i kod produktu (kolumna PRODUCT_CODE).
--Czy w przypadku wykorzystania UNION jakie� wierszy zosta�y pomini�te?

SELECT product_name,product_code
	FROM PRODUCTS_OLD_WAREHOUSE
		UNION ALL
SELECT product_name,product_code
	FROM products 
	LIMIT 5;
	
SELECT product_name,product_code
	FROM PRODUCTS_OLD_WAREHOUSE
		UNION 
SELECT product_name,product_code
	FROM products
	LIMIT 5;
	
--Je�eli sprawdzimy bez LIMIT 5 mo�emy zobaczy� , �e liczba element�w jest taka sama, wi�c nie ma pomini�cia.

--9.Na podstawie tabeli z zadania 7, korzystaj�c z operacji EXCEPT znajd� r�nic� zbior�w pomi�dzy tabel� PRODUCTS_OLD_WAREHOUSE a PRODUCTS, w wyniku wy�wietl jedynie kod produktu (kolumna PRODUCT_CODE).
SELECT product_code 
	FROM PRODUCTS_OLD_WAREHOUSE
		EXCEPT
SELECT product_code
	FROM products;
--10.Wy�wietl 10 rekord�w z tabeli sprzeda�owej sales. Dane powinny by� posortowane wed�ug warto�ci sprzeda�y (kolumn SAL_VALUE) malej�co.
SELECT *
	FROM sales 
	ORDER BY sal_value DESC
	LIMIT 10;
--11.Korzystaj�c z funkcji SUBSTRING na atrybucie SAL_DESCRIPTION, wy�wietl 3 dowolne wiersze z tabeli sprzeda�owej w taki spos�b, 
--aby w kolumnie wynikowej dla SUBSTRING z SAL_DESCRIPTION wy�wietlonych zosta�o tylko 3 pierwsze znaki.
SELECT sal_description , substring(sal_description,1,3)
	FROM sales
	LIMIT 3;
--12.Korzystaj�c ze sk�adni LIKE znajd� wszystkie dane sprzeda�owe, kt�rych opis sprzeda�y (SAL_DESCRIPTION) zaczyna si� od c4c.
SELECT *
	FROM sales
	WHERE sal_description LIKE 'c4c%';
	
