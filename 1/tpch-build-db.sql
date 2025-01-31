BEGIN;

	CREATE TABLE PART (

		P_PARTKEY		SERIAL PRIMARY KEY,
		P_NAME			VARCHAR(55),
		P_MFGR			CHAR(25),
		P_BRAND			CHAR(10),
		P_TYPE			VARCHAR(25),
		P_SIZE			INTEGER,
		P_CONTAINER		CHAR(10),
		P_RETAILPRICE	DECIMAL,
		P_COMMENT		VARCHAR(23)
	);

	COPY part FROM '/media/robert/My Passport/ZBD/part.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE REGION (
		R_REGIONKEY	SERIAL PRIMARY KEY,
		R_NAME		CHAR(25),
		R_COMMENT	VARCHAR(152)
	);

	COPY region FROM '/media/robert/My Passport/ZBD/region.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE NATION (
		N_NATIONKEY		SERIAL PRIMARY KEY,
		N_NAME			CHAR(25),
		N_REGIONKEY		BIGINT NOT NULL,  -- references R_REGIONKEY
		N_COMMENT		VARCHAR(152)
	);

	COPY nation FROM '/media/robert/My Passport/ZBD/nation.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE SUPPLIER (
		S_SUPPKEY		SERIAL PRIMARY KEY,
		S_NAME			CHAR(25),
		S_ADDRESS		VARCHAR(40),
		S_NATIONKEY		BIGINT NOT NULL, -- references N_NATIONKEY
		S_PHONE			CHAR(15),
		S_ACCTBAL		DECIMAL,
		S_COMMENT		VARCHAR(101)
	);

	COPY supplier FROM '/media/robert/My Passport/ZBD/supplier.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE CUSTOMER (
		C_CUSTKEY		SERIAL PRIMARY KEY,
		C_NAME			VARCHAR(25),
		C_ADDRESS		VARCHAR(40),
		C_NATIONKEY		BIGINT NOT NULL, -- references N_NATIONKEY
		C_PHONE			CHAR(15),
		C_ACCTBAL		DECIMAL,
		C_MKTSEGMENT	CHAR(10),
		C_COMMENT		VARCHAR(117)
	);

	COPY customer FROM '/media/robert/My Passport/ZBD/customer.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE PARTSUPP (
		PS_PARTKEY		BIGINT NOT NULL, -- references P_PARTKEY
		PS_SUPPKEY		BIGINT NOT NULL, -- references S_SUPPKEY
		PS_AVAILQTY		INTEGER,
		PS_SUPPLYCOST	DECIMAL,
		PS_COMMENT		VARCHAR(199),
                PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY)
	);

	COPY partsupp FROM '/media/robert/My Passport/ZBD/partsupp.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE ORDERS (
		O_ORDERKEY		SERIAL PRIMARY KEY,
		O_CUSTKEY		BIGINT NOT NULL, -- references C_CUSTKEY
		O_ORDERSTATUS	CHAR(1),
		O_TOTALPRICE	DECIMAL,
		O_ORDERDATE		DATE,
		O_ORDERPRIORITY	CHAR(15),
		O_CLERK			CHAR(15),
		O_SHIPPRIORITY	INTEGER,
		O_COMMENT		VARCHAR(79)
	);

	COPY orders FROM '/media/robert/My Passport/ZBD/orders.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

BEGIN;

	CREATE TABLE LINEITEM (
		L_ORDERKEY		BIGINT NOT NULL, -- references O_ORDERKEY
		L_PARTKEY		BIGINT NOT NULL, -- references P_PARTKEY (compound fk to PARTSUPP)
		L_SUPPKEY		BIGINT NOT NULL, -- references S_SUPPKEY (compound fk to PARTSUPP)
		L_LINENUMBER	INTEGER,
		L_QUANTITY		DECIMAL,
		L_EXTENDEDPRICE	DECIMAL,
		L_DISCOUNT		DECIMAL,
		L_TAX			DECIMAL,
		L_RETURNFLAG	CHAR(1),
		L_LINESTATUS	CHAR(1),
		L_SHIPDATE		DATE,
		L_COMMITDATE	DATE,
		L_RECEIPTDATE	DATE,
		L_SHIPINSTRUCT	CHAR(25),
		L_SHIPMODE		CHAR(10),
		L_COMMENT		VARCHAR(44),
                PRIMARY KEY (L_ORDERKEY, L_LINENUMBER)  
	);

	COPY lineitem FROM '/media/robert/My Passport/ZBD/lineitem.csv' WITH (FORMAT csv, DELIMITER '|');

COMMIT;

ALTER TABLE SUPPLIER ADD FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY);

ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY);
ALTER TABLE PARTSUPP ADD FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY);

ALTER TABLE CUSTOMER ADD FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY);

ALTER TABLE ORDERS ADD FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY);

ALTER TABLE LINEITEM ADD FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY);
ALTER TABLE LINEITEM ADD FOREIGN KEY (L_PARTKEY,L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY,PS_SUPPKEY);

ALTER TABLE NATION ADD FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY);
