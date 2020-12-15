SET datestyle TO 'DMY'

--1. Wyœwietl unikatowe daty stworzenia produktów (wed³ug atrybutu manufactured_date)
SELECT DISTINCT manufactured_date
	FROM products;

--2.Jak sprawdzisz czy 10 wstawionych produktów to 10 unikatowych kodów produktów?
SELECT COUNT(DISTINCT product_code)
	FROM products;

--3.Korzystaj¹c ze sk³adni IN wyœwietl produkty od kodach PRD1 i PRD9
SELECT product_name
	FROM products
	WHERE product_code IN ('PRD1','PRD9');
--4Wyœwietl wszystkie atrybuty z danych sprzeda¿owych, takie ¿e data sprzeda¿y jest w zakresie od 1 sierpnia 2020 do 31 sierpnia 2020 (w³¹cznie). 
--Dane wynikowe maj¹ byæ posortowane wed³ug wartoœci sprzeda¿y malej¹co i daty sprzeda¿y rosn¹co.
SELECT * 
	FROM sales
	WHERE sal_date BETWEEN '1/08/2020' AND '31/08/2020'
	ORDER BY sal_value DESC , sal_date ASC ;
	
--5. Korzystaj¹c ze sk³adni NOT EXISTS wyœwietl te produkty z tabeli PRODUCTS, które nie bior¹ udzia³u w transakcjach sprzeda¿owych (tabela SALES). 
--ID z tabeli Products i SAL_PRODUCT_ID to klucz ³¹czenia.
SELECT *
FROM products p 
WHERE NOT EXISTS(SELECT 1
					FROM sales s
					WHERE p.id = s.sal_product_id);
				
--6. Korzystaj¹c ze sk³adni ANY i operatora = wyœwietl te produkty, których wystêpuj¹ w transakcjach sprzeda¿owych 
--(wed³ug klucza Products ID, Sales SAL_PRODUCT_ID) takich, ¿e wartoœæ sprzeda¿y w transakcji jest wiêksza od 100.
SELECT DISTINCT *
	FROM products p
	WHERE p.id = any(SELECT DISTINCT s.sal_product_id
							FROM sales s
							WHERE s.sal_value > 100);
						
--7.Stwórz now¹ tabelê PRODUCTS_OLD_WAREHOUSE o takich samych kolumnach jak istniej¹ca tabela produktów (tabela PRODUCTS). 
--Wstaw do nowej tabeli kilka wierszy - dowolnych wed³ug Twojego uznania.

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
--8.Na podstawie tabeli z zadania 7, korzystaj¹c z operacji UNION oraz UNION ALL po³¹cz tabelê PRODUCTS_OLD_WAREHOUSE z 5 dowolnym produktami z tabeli PRODUCTS, 
--w wyniku wyœwietl jedynie nazwê produktu (kolumna PRODUCT_NAME) i kod produktu (kolumna PRODUCT_CODE).
--Czy w przypadku wykorzystania UNION jakieœ wierszy zosta³y pominiête?

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
	
--Je¿eli sprawdzimy bez LIMIT 5 mo¿emy zobaczyæ , ¿e liczba elementów jest taka sama, wiêc nie ma pominiêcia.

--9.Na podstawie tabeli z zadania 7, korzystaj¹c z operacji EXCEPT znajdŸ ró¿nicê zbiorów pomiêdzy tabel¹ PRODUCTS_OLD_WAREHOUSE a PRODUCTS, w wyniku wyœwietl jedynie kod produktu (kolumna PRODUCT_CODE).
SELECT product_code 
	FROM PRODUCTS_OLD_WAREHOUSE
		EXCEPT
SELECT product_code
	FROM products;
--10.Wyœwietl 10 rekordów z tabeli sprzeda¿owej sales. Dane powinny byæ posortowane wed³ug wartoœci sprzeda¿y (kolumn SAL_VALUE) malej¹co.
SELECT *
	FROM sales 
	ORDER BY sal_value DESC
	LIMIT 10;
--11.Korzystaj¹c z funkcji SUBSTRING na atrybucie SAL_DESCRIPTION, wyœwietl 3 dowolne wiersze z tabeli sprzeda¿owej w taki sposób, 
--aby w kolumnie wynikowej dla SUBSTRING z SAL_DESCRIPTION wyœwietlonych zosta³o tylko 3 pierwsze znaki.
SELECT sal_description , substring(sal_description,1,3)
	FROM sales
	LIMIT 3;
--12.Korzystaj¹c ze sk³adni LIKE znajdŸ wszystkie dane sprzeda¿owe, których opis sprzeda¿y (SAL_DESCRIPTION) zaczyna siê od c4c.
SELECT *
	FROM sales
	WHERE sal_description LIKE 'c4c%';
	
