// Create lineitems

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:/lineitem.csv" AS row
CREATE (:Lineitem {l_orderkey: row.l_orderkey, l_partkey: row.l_partkey, l_suppkey: row.l_suppkey, l_linenumber: row.l_linenumber, l_quantity: row.l_quantity, l_extendedprice: row.l_extendedprice, l_discount: row.l_discount, l_tax: row.l_tax, l_returnflag: row.l_returnflag, l_linestatus: row.l_linestatus, l_shipdate: row.l_shipdate, l_commitdate: row.l_commitdate, l_receiptdate: row.l_receiptdate, l_shipinstruct: row.l_shipinstruct, l_shipmode: row.l_shipmode, l_comment: row.l_comment});
