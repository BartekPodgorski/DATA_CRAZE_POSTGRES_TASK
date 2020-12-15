DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id SERIAL,
	product_name VARCHAR(100),
	product_code VARCHAR(10),
	product_quantity NUMERIC(10,2),
	manufactured_date DATE,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now());
	
SET datestyle TO 'DMY';

INSERT INTO products (product_name, product_code, product_quantity, manufactured_date)
	SELECT 'Product '||floor(random() * 10 + 1)::int,
		'PRD'||floor(random() * 10 + 1)::int,
		random() * 10 + 1,
		CAST((NOW() - (random() * (interval '90 days')))::timestamp AS date)
	FROM generate_series(1, 10) s(i);

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
	id SERIAL,
	sal_description TEXT,
	sal_date DATE,
	sal_value NUMERIC(10,2),
	sal_qty NUMERIC(10,2),
	sal_product_id INTEGER,
	added_by TEXT DEFAULT 'admin',
	created_date TIMESTAMP DEFAULT now());

INSERT INTO sales (sal_description, sal_date, sal_value, sal_qty, sal_product_id)
	SELECT left(md5(i::text), 15),
		CAST((NOW() - (random() * (interval '60 days'))) AS DATE),
		random() * 100 + 1,
		floor(random() * 10 + 1)::int,
		floor(random() * 10)::int
	FROM generate_series(1, 10000) s(i);