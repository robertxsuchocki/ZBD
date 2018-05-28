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
