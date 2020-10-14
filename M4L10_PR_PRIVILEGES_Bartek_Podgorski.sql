--1
CREATE ROLE expense_tracker_user WITH LOGIN PASSWORD '123';
--2
REVOKE CREATE ON SCHEMA public FROM PUBLIC;
--3
DROP SCHEMA expense_tracker CASCADE;
--4
CREATE ROLE expense_tracker_group;
--5
CREATE SCHEMA expense_tracker AUTHORIZATION expense_tracker_group;
--6
GRANT CONNECT ON DATABASE postgres TO expense_tracker_group;
GRANT ALL PRIVILEGES ON SCHEMA expense_tracker TO expense_tracker_group;
--7
GRANT expense_tracker_group TO expense_tracker_user;

