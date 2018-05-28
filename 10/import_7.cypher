//Connect customer with order

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/orders.csv" AS row
MATCH (customer:Customer {c_custkey: row.o_custkey})
MATCH (order:Order {o_orderkey: row.o_orderkey})
MERGE (region)-[:CONSISTS_OF]->(nation);
