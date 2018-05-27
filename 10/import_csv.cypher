// Create customers

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/customer.csv" AS row
CREATE (:Customer {c_custkey: row.c_custkey, c_name: row.c_name, c_address: row.c_address, c_nationkey: row.c_nationkey, c_phone: row.c_phone, c_acctbal: row.c_acctbal, c_mktsegment: row.c_mktsegment, c_comment: row.c_comment});


// Create lineitems

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
CREATE (:Lineitem {l_orderkey: row.l_orderkey, l_partkey: row.l_partkey, l_suppkey: row.l_suppkey, l_linenumber: row.l_linenumber, l_quantity: row.l_quantity, l_extendedprice: row.l_extendedprice, l_discount: row.l_discount, l_tax: row.l_tax, l_returnflag: row.l_returnflag, l_linestatus: row.l_linestatus, l_shipdate: row.l_shipdate, l_commitdate: row.l_commitdate, l_receiptdate: row.l_receiptdate, l_shipinstruct: row.l_shipinstruct, l_shipmode: row.l_shipmode, l_comment: row.l_comment});


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


// Create indexes

CREATE INDEX ON :Customer(c_name);
CREATE INDEX ON :Customer(c_custkey);
CREATE INDEX ON :Lineitem(l_orderkey);
CREATE INDEX ON :Lineitem(l_linenumber);
CREATE INDEX ON :Nation(n_name);
CREATE INDEX ON :Nation(n_nationkey);
CREATE INDEX ON :Order(o_orderkey);
CREATE INDEX ON :Part(p_name);
CREATE INDEX ON :Part(p_partkey);
CREATE INDEX ON :Region(r_name);
CREATE INDEX ON :Region(r_regionkey);
CREATE INDEX ON :Supplier(s_name);
CREATE INDEX ON :Supplier(s_suppkey);


// Create friendships

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/friendship.csv" AS row
MATCH (first:Customer {c_custkey: row.f_firstcustkey})
MATCH (second:Customer {c_custkey: row.f_secondcustkey})
MERGE (first)-[:BEFRIENDS_WITH]->(second);


// Create partsupps

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/partsupp.csv" AS row
MATCH (part:Part {p_partkey: row.ps_partkey})
MATCH (supplier:Supplier {s_suppkey: row.ps_suppkey})
MERGE (supplier)-[ps:SUPPLY]->(part)
ON CREATE SET ps.availqty = row.ps_availqty, ps.supplycost = row.ps_supplycost, ps.comment = row.ps_comment;


//Connect lineitems

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
MATCH (lineitem:Lineitem {l_orderkey: row.l_orderkey, l_linenumber: row.l_linenumber})
MATCH (order:Order {o_orderkey: row.l_orderkey})
MERGE (order)-[:CONSISTS_OF]->(lineitem)

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
MATCH (lineitem:Lineitem {l_orderkey: row.l_orderkey, l_linenumber: row.l_linenumber})
MATCH (part:Part {p_partkey: row.l_partkey})
MERGE (lineitem)-[lp:REPRESENTS]->(part)
ON CREATE SET lp.extendedprice = row.l_extendedprice, lp.discount = row.l_discount, lp.tax = row.l_tax;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
MATCH (lineitem:Lineitem {l_orderkey: row.l_orderkey, l_linenumber: row.l_linenumber})
MATCH (supplier:Supplier {s_suppkey: row.l_suppkey})
MERGE (supplier)-[:PROVIDES]->(lineitem)


//Connect nations

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/nation.csv" AS row
MATCH (nation:Nation {n_nationkey: row.n_nationkey})
MATCH (region:Region {r_regionkey: row.n_regionkey})
MERGE (region)-[:CONSISTS_OF]->(nation)

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/customer.csv" AS row
MATCH (nation:Nation {n_nationkey: row.c_nationkey})
MATCH (customer:Customer {c_custkey: row.c_custkey})
MERGE (supplier)-[:OPERATES_IN]->(nation)

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/supplier.csv" AS row
MATCH (nation:Nation {n_nationkey: row.s_nationkey})
MATCH (supplier:Supplier {s_suppkey: row.s_suppkey})
MERGE (supplier)-[:OPERATES_IN]->(nation)


//Connect customer with order

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/orders.csv" AS row
MATCH (customer:Customer {c_custkey: row.o_custkey})
MATCH (order:Order {o_orderkey: row.o_orderkey})
MERGE (region)-[:CONSISTS_OF]->(nation)
