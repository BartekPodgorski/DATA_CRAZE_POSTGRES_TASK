CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_owner(
	id_ba_own integer,
	owner_name varchar(50) NOT NULL,
	owner_desc VARCHAR(250),
	user_login integer NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_bao PRIMARY KEY(id_ba_own)
);

CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_types(
	id_ba_type integer,
	ba_type varchar(50) NOT NULL,
	ba_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	is_common_account boolean DEFAULT FALSE NOT NULL,	
	id_ba_own integer, 
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_bat PRIMARY KEY(id_ba_type),
	FOREIGN KEY (id_ba_own) REFERENCES bank_account_owner (id_ba_own) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_bank_accounts(
	id_trans_ba integer,
	id_ba_own integer, 
	id_ba_type integer, --foreign
	bank_account_name varchar(50) NOT NULL,
	bank_account_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_tba PRIMARY KEY(id_trans_ba),
	FOREIGN KEY (id_ba_own) REFERENCES bank_account_owner (id_ba_own) ON DELETE CASCADE,
	FOREIGN KEY (id_ba_type) REFERENCES bank_account_types (id_ba_type) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS expense_tracker.users(
	id_user integer,
	user_login varchar(25) NOT NULL,
	user_name varchar(50) NOT NULL,
	user_password varchar(100) NOT NULL,
	password_salt varchar(100) NOT NULL,
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_u PRIMARY KEY(id_user)
);

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_type(
	id_trans_type integer,
	transaction_type_name varchar(50) NOT NULL,
	transaction_type_desc varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_tt PRIMARY KEY(id_trans_type)
);

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_category(
	id_trans_cat integer,
	category_name varchar(50) NOT NULL,
	category_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_tc PRIMARY KEY(id_trans_cat)
);

CREATE TABLE IF NOT EXISTS expense_tracker.transaction_subcategory(
	id_trans_subcat integer,
	id_trans_cat integer, --foreign
	subcategory_name varchar(50) NOT NULL,
	subcategory_description varchar(250),
	active boolean DEFAULT TRUE NOT NULL,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_ts PRIMARY KEY(id_trans_subcat),
	FOREIGN KEY (id_trans_cat) REFERENCES transaction_category (id_trans_cat) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS expense_tracker.transactions(
	id_transaction integer,
	id_trans_ba integer,
	id_trans_cat integer,
	id_trans_subcat integer,
	id_trans_type integer,
	id_user integer,
	transaction_date date DEFAULT current_date,
	transaction_value NUMERIC(9,2),
	transaction_description TEXT,
	insert_date timestamp DEFAULT current_timestamp,
	update_date timestamp DEFAULT current_timestamp,
	CONSTRAINT pk_t PRIMARY KEY(id_transaction),
	FOREIGN KEY (id_trans_ba) REFERENCES transaction_bank_accounts (id_trans_ba) ON DELETE CASCADE,
	FOREIGN KEY (id_trans_cat) REFERENCES transaction_category (id_trans_cat) ON DELETE CASCADE,
	FOREIGN KEY (id_trans_subcat) REFERENCES transaction_subcategory (id_trans_subcat) ON DELETE CASCADE,
	FOREIGN KEY (id_trans_type) REFERENCES transaction_type (id_trans_type) ON DELETE CASCADE,
	FOREIGN KEY (id_user) REFERENCES users (id_user) ON DELETE CASCADE
);



