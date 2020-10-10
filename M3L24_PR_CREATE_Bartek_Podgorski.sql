CREATE SCHEMA expense_tracker;

CREATE TABLE IF NOT EXISTS bank_account_owner(
	id_ba_own integer,
	owner_name varchar(50) NOT NULL,
	owner_desc VARCHAR(250),
	user_login integer NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id1 PRIMARY KEY(id_ba_own)
);

CREATE TABLE IF NOT EXISTS bank_account_types(
	id_ba_type integer,
	ba_type varchar(50) NOT NULL,
	ba_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	is_common_account boolean DEFAULT FALSE NOT NULL,
	id_ba_own integer, --foreign bank_account_owner
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id2 PRIMARY KEY(id_ba_type)
);

CREATE TABLE IF NOT EXISTS transactions(
	id_transaction integer,
	id_trans_ba integer, --foreign
	id_trans_cat integer, --foreign
	id_trans_subcat integer, --foreign
	id_trans_type integer, --foreign
	id_user integer, --foreign
	transaction_date date DEFAULT current_date,
	transaction_value NUMERIC(9,2),
	transaction_description TEXT,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id3 PRIMARY KEY(id_transaction)
);

CREATE TABLE IF NOT EXISTS transaction_bank_accounts(
	id_trans_ba integer,
	id_ba_own integer, --foreign
	id_ba_typ integer, --foreign
	bank_account_name varchar(50) NOT NULL,
	bank_account_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id4 PRIMARY KEY(id_trans_ba)
);

CREATE TABLE IF NOT EXISTS transaction_category(
	id_trans_cat integer,
	category_name varchar(50) NOT NULL,
	category_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id5 PRIMARY KEY(id_trans_cat)
);

CREATE TABLE IF NOT EXISTS transaction_subcategory(
	id_trans_subcat integer,
	id_trans_cat integer, --foreign
	subcategory_name varchar(50) NOT NULL,
	subcategory_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id6 PRIMARY KEY(id_trans_subcat)
);

CREATE TABLE IF NOT EXISTS transaction_type(
	id_trans_type integer,
	transaction_type_name varchar(50) NOT NULL,
	transaction_type_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id7 PRIMARY KEY(id_trans_type)
);

CREATE TABLE IF NOT EXISTS users(
	id_user integer,
	user_login varchar(25) NOT NULL,
	user_name varchar(50) NOT NULL,
	user_password varchar(100) NOT NULL,
	password_salt varchar(100) NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_id8 PRIMARY KEY(id_user)
);