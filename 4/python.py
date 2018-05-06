from pymongo import MongoClient
client = MongoClient()

tpch = client.tpch

lineitem = tpch.lineitem.find_one({'l_orderkey' : 10100000})

print(lineitem)
