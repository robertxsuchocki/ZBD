//Connect nations

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/nation.csv" AS row
MATCH (nation:Nation {n_nationkey: row.n_nationkey})
MATCH (region:Region {r_regionkey: row.n_regionkey})
MERGE (region)-[:CONSISTS_OF]->(nation);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/customer.csv" AS row
MATCH (nation:Nation {n_nationkey: row.c_nationkey})
MATCH (customer:Customer {c_custkey: row.c_custkey})
MERGE (supplier)-[:OPERATES_IN]->(nation);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/supplier.csv" AS row
MATCH (nation:Nation {n_nationkey: row.s_nationkey})
MATCH (supplier:Supplier {s_suppkey: row.s_suppkey})
MERGE (supplier)-[:OPERATES_IN]->(nation);
