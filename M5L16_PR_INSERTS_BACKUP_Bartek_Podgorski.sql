SET DATESTYLE TO 'DMY';

INSERT INTO expense_tracker.bank_account_owner (owner_name,owner_desc,user_login)
	VALUES ('Bartek Podgorski','Personal account Millenium', 1); --GIVE US REST OF DATA DEFAULT

INSERT INTO expense_tracker.bank_account_types (ba_type,ba_desc,id_ba_own)
	VALUES('FCA','Foreign currency account',1);
	
INSERT INTO expense_tracker.transaction_bank_accounts(id_ba_own,id_ba_type,bank_account_name,bank_account_desc)
	VALUES (1,1,'Personal account of Bartek','Private');
	
INSERT INTO expense_tracker.users (user_login,user_name,user_password,password_salt)
	VALUES('PodBar','Bartek Podgorski','Nabu*hodozor_123','a5876558');
	
INSERT INTO expense_tracker.transaction_type (transaction_type_name,transaction_type_desc)
	VALUES('Incoming transfer','Increasing account resources');
	
INSERT INTO expense_tracker.transaction_category(category_name,category_description)
	VALUES('FOOD','All products which can be eaten')
	
INSERT INTO expense_tracker.transaction_subcategory(id_trans_cat,subcategory_name,subcategory_description)
	VALUES(1,'Restaurant','Meals which can be ordred in the restaurant');
	
INSERT INTO expense_tracker.transactions (id_trans_ba,id_trans_cat,id_trans_subcat,id_trans_type,id_user,
transaction_value,transaction_description)
	VALUES(1,1,1,1,1,59.89,'Pizza , Spaghetti');

--SELECT to check inserts
SELECT * FROM expense_tracker.bank_account_owner;
SELECT * FROM expense_tracker.bank_account_types;
SELECT * FROM expense_tracker.transaction_bank_accounts;
SELECT * FROM expense_tracker.users;
SELECT * FROM expense_tracker.transaction_type;
SELECT * FROM expense_tracker.transaction_subcategory;
SELECT * FROM expense_tracker.transaction_subcategory;
SELECT * FROM expense_tracker.transactions;

--BACKUP
pg_dump --host localhost ^
        --port 5432 ^
        --username postgres ^
        --format plain ^
        --file "C:\Users\user\Desktop\SQL\expense_tracker_bp.sql" ^
        --clean ^
        postgres

psql -U postgres -p 5432 -h localhost -d postgres -f "C:\Users\user\Desktop\SQL\expense_tracker_bp.sql"
