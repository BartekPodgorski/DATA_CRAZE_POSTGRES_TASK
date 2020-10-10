--1
CREATE SCHEMA training;
--2
ALTER SCHEMA training RENAME TO training_zs;

--I CONNECT TO THE SCHEMA
--3
CREATE TABLE products(
	id integer,
	production_qty NUMERIC(10,2),
	product_name varchar(100),
	product_code varchar(10),
	description TEXT,
	manufacturing_date date
);
--4
ALTER TABLE products ADD CONSTRAINT pk_id PRIMARY KEY(id);
--5
DROP TABLE IF EXISTS training_zs;
--6
CREATE TABLE sales(
	id integer,
	sales_date timestamp NOT NULL,
	sales_amount NUMERIC(38,2),
	sales_qty NUMERIC(10,2),
	product_id integer,
	added_by TEXT DEFAULT 'admin',
	CONSTRAINT sales_over1k CHECK (sales_amount > 1000),
	CONSTRAINT pk_idik PRIMARY KEY(id)
);
--7
ALTER TABLE sales ADD FOREIGN KEY(product_id) REFERENCES products (id) ON DELETE CASCADE;
--8
DROP SCHEMA training_zs CASCADE;