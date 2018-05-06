select p_partkey, count(*)
from (select p_partkey from bought where c_custkey = 1)
group by p_partkey
order by count(*), p_partkey
limit 10;
