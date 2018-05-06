import pymongo

client = pymongo.MongoClient()
tpch = client.tpch

tpch.friendship.create_index([('f_firstcustkey', pymongo.ASCENDING)])
tpch.customer.create_index([('c_custkey', pymongo.ASCENDING)])
tpch.customer.create_index([('c_mktsegment', pymongo.ASCENDING)])
tpch.orders.create_index([('o_custkey', pymongo.ASCENDING)])
tpch.lineitem.create_index([('l_orderkey', pymongo.ASCENDING)])
