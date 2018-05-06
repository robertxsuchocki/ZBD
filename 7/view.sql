create materialized view customer_part as (
  select c.*, p.*
  from part p, lineitem, orders, customer c
  where p_partkey = l_partkey
  and l_orderkey = o_orderkey
  and o_custkey = c_custkey
  order by c_custkey, p_partkey
);

create materialized view brands as (
  select c_custkey as b_custkey, p_brand as b_brand
  from customer_part
  group by c_custkey, p_brand
  order by c_custkey, p_brand
)
