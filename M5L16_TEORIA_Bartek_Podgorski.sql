--1
CREATE SCHEMA dml_exercises ; 
--2
DROP TABLE IF EXISTS dml_exercises.sales;

CREATE TABLE dml_exercises.sales(
	id SERIAL,
	sales_date timestamp NOT NULL,
	sales_amount NUMERIC(38,2),
	sales_qty NUMERIC(10,2),
	added_by TEXT DEFAULT 'admin',
	CONSTRAINT sales_less_1k CHECK (sales_amount <= 1000),
	CONSTRAINT pk_sales PRIMARY KEY (id)
);
--3.1 & 3.2
SET DATESTYLE TO 'DMY';
INSERT INTO dml_exercises.sales (sales_date, sales_amount, added_by)
	VALUES (now(),700, NULL),
			(now(),1000, DEFAULT),
			(now(),300, 'BP');
		
SELECT * FROM dml_exercises.sales;
--3.3 with error
INSERT INTO dml_exercises.sales (sales_date, sales_amount, added_by)			
	VALUES (now(),1100,NULL);
--4
INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
	VALUES ('20/11/2019', 101, 50, NULL);
SELECT * FROM dml_exercises.sales;
--We get 00:00:00
--5
INSERT INTO dml_exercises.sales (sales_date, sales_amount,sales_qty, added_by)
	VALUES ('04/04/2020', 101, 50, NULL);
--I CHECK DATE STYLE BY SHOW DATESTYLE 
--6
INSERT INTO dml_exercises.sales (sales_date, sales_amount, sales_qty,added_by)
	SELECT NOW() + (random() * (interval '90 days')) + '30 days',
			random() * 500 + 1,
			random() * 100 + 1,
			NULL
	FROM generate_series(1, 20000) s(i);

SELECT count(*) FROM dml_exercises.sales;
--7	
UPDATE dml_exercises.sales
	SET added_by = 'sales_over_200'
	WHERE sales_amount >= 200;
	
SELECT * FROM dml_exercises.sales WHERE sales_amount >=200 LIMIT 10;
--8
--Not correct
DELETE FROM dml_exercises.sales
	WHERE added_by = NULL; -- We cannot do this because The null value represents an unknown value, and it is not known whether two unknown values are equal
	
SELECT count(*) FROM dml_exercises.sales; --20005
--correct
DELETE FROM dml_exercises.sales
	WHERE added_by IS NULL;

SELECT count(*) FROM dml_exercises.sales; -- 11988

--9
TRUNCATE dml_exercises.sales RESTART IDENTITY;
--10
DROP TABLE IF EXISTS dml_exercises.sales;
pg_dump --host localhost ^
        --port 5432 ^
        --username postgres ^
        --format plain ^
        --file "C:\Users\user\Desktop\SQL\dml_exercises_sales_bp.sql" ^
        --table dml_exercises.sales ^
        postgres
        
psql -U postgres -p 5432 -h localhost -d postgres -f "C:\Users\user\Desktop\SQL\dml_exercises_sales_bp.sql"