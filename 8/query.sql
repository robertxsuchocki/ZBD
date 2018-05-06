select l_partkey
from lineitem l, orders o
where
  l_orderkey = o_orderkey and
  o_custkey in (
    select c2.c_custkey from friendship, customer c1, customer c2
    where
      c1.c_custkey = 10 and
      f_firstcustkey = c1.c_custkey and
      f_secondcustkey = c2.c_custkey and
      c1.c_mktsegment = c2.c_mktsegment
  )
order by l_partkey
limit 20;
