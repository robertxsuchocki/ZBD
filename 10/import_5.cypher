//Connect lineitems

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
MATCH (lineitem:Lineitem {l_orderkey: row.l_orderkey, l_linenumber: row.l_linenumber})
MATCH (order:Order {o_orderkey: row.l_orderkey})
MERGE (order)-[:CONSISTS_OF]->(lineitem);

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
MERGE (supplier)-[:PROVIDES]->(lineitem);
