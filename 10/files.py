#!/usr/bin/env python3
import os
from re import sub

customer_headers = "c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment\n"
lineitem_headers = "l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment\n"
nation_headers = "n_nationkey, n_name, n_regionkey, n_comment\n"
orders_headers = "o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment\n"
part_headers = "p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment\n"
partsupp_headers = "ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment\n"
region_headers = "r_regionkey, r_name, r_comment\n"
supplier_headers = "s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment\n"

# Get *.tbl files for database
os.chdir("/home/robert/Code/ZBD/tpch/dbgen")
os.system("./dbgen -s 0.2")
os.system("mv *.tbl ../../10")
os.chdir("/home/robert/Code/ZBD/10")

for fname in os.listdir('.'):
    if fname.endswith(".tbl"):
        with open(fname, "r") as f:
            name = fname[:-4]
            with open(name + ".csv", "a") as new_f:
                new_f.write(eval(name + "_headers"))
                for line in f.readlines():
                    line = line[:-2] + '\n'
                    line = sub(',', '\.', line)
                    line = sub('\|', ',', line)
                    new_f.write(line)
        os.system("rm ./" + fname)
