// Create customers

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/customer.csv" AS row
CREATE (:Customer {c_custkey: row.c_custkey, c_name: row.c_name, c_address: row.c_address, c_nationkey: row.c_nationkey, c_phone: row.c_phone, c_acctbal: row.c_acctbal, c_mktsegment: row.c_mktsegment, c_comment: row.c_comment});


// Create nations

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/nation.csv" AS row
CREATE (:Nation {n_nationkey: row.n_nationkey, n_name: row.n_name, n_regionkey: row.n_regionkey, n_comment: row.n_comment});


// Create orders

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/orders.csv" AS row
CREATE (:Order {o_orderkey: row.o_orderkey, o_custkey: row.o_custkey, o_orderstatus: row.o_orderstatus, o_totalprice: row.o_totalprice, o_orderdate: row.o_orderdate, o_orderpriority: row.o_orderpriority, o_clerk: row.o_clerk, o_shippriority: row.o_shippriority, o_comment: row.o_comment});


// Create parts

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/part.csv" AS row
CREATE (:Part {p_partkey: row.p_partkey, p_name: row.p_name, p_mfgr: row.p_mfgr, p_brand: row.p_brand, p_type: row.p_type, p_size: row.p_size, p_container: row.p_container, p_retailprice: row.p_retailprice, p_comment: row.p_comment});


// Create regions

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/region.csv" AS row
CREATE (:Region {r_regionkey: row.r_regionkey, r_name: row.r_name, r_comment: row.r_comment});


// Create suppliers

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/supplier.csv" AS row
CREATE (:Supplier {s_suppkey: row.s_suppkey, s_name: row.s_name, s_address: row.s_address, s_nationkey: row.s_nationkey, s_phone: row.s_phone, s_acctbal: row.s_acctbal, s_comment: row.s_comment});
