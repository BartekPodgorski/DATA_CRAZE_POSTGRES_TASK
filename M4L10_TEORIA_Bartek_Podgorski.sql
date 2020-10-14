GRANT ALL PRIVILEGES ON SCHEMA public TO PUBLIC;
--1
CREATE ROLE user_training WITH LOGIN PASSWORD 'silne_haslo123';
--2
CREATE SCHEMA training AUTHORIZATION user_training;
--3
DROP ROLE user_training; --OF COURSE WE GET ERROR
--4
REASSIGN OWNED BY user_training TO postgres;
DROP ROLE user_training;
--5
CREATE ROLE reporting_ro;
GRANT CONNECT ON DATABASE postgres TO reporting_ro;
GRANT USAGE,CREATE ON SCHEMA training TO reporting_ro;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA training TO reporting_ro;
--6
CREATE ROLE reporting_user WITH LOGIN PASSWORD 'uber_hard123';
GRANT reporting_ro TO reporting_user;
--7
CREATE TABLE training.testru(id integer); --Success
--8
REVOKE CREATE ON SCHEMA training FROM reporting_ro;
--9
CREATE TABLE training.testru2(id integer); --DENY
CREATE TABLE public.testru2(id integer); --SUCCESS