import pymongo

client = pymongo.MongoClient()
tpch = client.tpch

tpch.orders.create_index([('o_orderdate', pymongo.ASCENDING)])
tpch.orders.create_index([('o_orderkey', pymongo.ASCENDING)])
tpch.supplier.create_index([('s_suppkey', pymongo.ASCENDING)])
tpch.nation.create_index([('n_nationkey', pymongo.ASCENDING)])
tpch.region.create_index([('r_regionkey', pymongo.ASCENDING)])
tpch.region.create_index([('r_name', pymongo.ASCENDING)])

pipeline = [
    {
        '$lookup':
        {
            'from': "orders",
            'localField': "l_orderkey",
            'foreignField': "o_orderkey",
            'as': "orders"
        }
    },
    {
        '$unwind': "$orders"
    },
    {
        '$lookup':
        {
            'from': "supplier",
            'localField': "l_suppkey",
            'foreignField': "s_suppkey",
            'as': "supplier"
        }
    },
    {
        '$unwind': "$supplier"
    },
    {
        '$lookup':
        {
            'from': "nation",
            'localField': "supplier.s_nationkey",
            'foreignField': "n_nationkey",
            'as': "nation"
        }
    },
    {
        '$unwind': "$nation"
    },
    {
        '$lookup':
        {
            'from': "region",
            'localField': "nation.n_regionkey",
            'foreignField': "r_regionkey",
            'as': "region"
        }
    },
    {
        '$unwind': "$region"
    }
]

tpch.command('create', 'lineitem_view', viewOn='lineitem', pipeline=pipeline)

print(tpch.lineitem.count())
print(tpch.lineitem_view.count())
