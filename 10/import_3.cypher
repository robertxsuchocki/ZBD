// Create indexes

CREATE INDEX ON :Customer(c_custkey);
CREATE INDEX ON :Lineitem(l_orderkey);
CREATE INDEX ON :Lineitem(l_linenumber);
CREATE INDEX ON :Nation(n_nationkey);
CREATE INDEX ON :Order(o_orderkey);
CREATE INDEX ON :Part(p_partkey);
CREATE INDEX ON :Region(r_regionkey);
CREATE INDEX ON :Supplier(s_suppkey);
