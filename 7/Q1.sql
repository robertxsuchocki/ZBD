-- select b_custkey, p_partkey
-- from brands, part
-- where b_brand = p_brand
-- and c_custkey <= 100
-- and p_partkey not in (
--   select p_partkey
--   from customer_part cp
--   where cp.c_custkey = b_custkey
--   and cp.p_brand = b_brand
--   and c_custkey <= 100
-- )
--
-- select c_custkey, p_partkey
-- from part, lineitem, orders, customer c
-- where p_partkey not in (select p_partkey from customer_part cp where c.c_custkey = cp.c_custkey)
-- and p_brand in (select p_brand from customer_part cp where c.c_custkey = cp.c_custkey)
-- and p_partkey = l_partkey
-- and l_orderkey = o_orderkey
-- and o_custkey = c_custkey
-- and c_custkey <= 100

(select c.*, p.*
from customer c, brands b, part p
where c_custkey = b_custkey
and b_brand = p_brand
and c_custkey <= 100
order by c_custkey, p_partkey)
except
(select *
from customer_part
where c_custkey <= 100)
