create index i_friendship on friendship (f_firstcustkey);
create index i_customer on customer (c_custkey);
create index i_customermkt on customer (c_mktsegment);
create index i_orders on orders (o_custkey);
create index i_lineitem on lineitem (l_orderkey);
