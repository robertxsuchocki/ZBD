import sys
import pymongo

if (len(sys.argv) != 2):
    sys.exit("Usage: " + sys.argv[0] + " customer_id")

cust_id = int(sys.argv[1])
client = pymongo.MongoClient()
tpch = client.tpch

friends_obj = tpch.friendship.find({"f_firstcustkey" : cust_id})
friends = [friend["f_secondcustkey"] for friend in friends_obj]

mktsegment = tpch.customer.find_one({"c_custkey" : cust_id})["c_mktsegment"]

fitting_obj = tpch.customer.find({"c_mktsegment" : mktsegment})
fitting = [fitting["c_custkey"] for fitting in fitting_obj]

customers = [customer for customer in friends if customer in fitting]

orders_obj = tpch.orders.find({"o_custkey":{"$in":customers}})
orders = [order["o_orderkey"] for order in orders_obj]

lineitems_obj = tpch.lineitem.find({"l_orderkey":{"$in":orders}})
partkeys = sorted([lineitem["l_partkey"] for lineitem in lineitems_obj])[:20]

for partkey in partkeys:
    print(partkey)
