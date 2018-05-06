from datetime import datetime
import pymongo

client = pymongo.MongoClient()
tpch = client.tpch

lineitems = tpch.lineitem_view.aggregate([
    {
        '$match':
        {
            '$and' :
            [
                {'region.r_name' : "AMERICA"},
                {'orders.o_orderdate' : {'$gte' : "1995-01-01"}},
                {'orders.o_orderdate' : {'$lt' : "1996-01-01"}}
            ]
        }
    },
    {
        '$group' :
        {
            '_id': {'n_name': { 'n_name': "$nation.n_name" }},
            'revenue':
            {
                '$sum':
                {
                    '$multiply': [
                        "$l_extendedprice",
                        {'$subtract': [1, "$l_discount"]}
                    ]
                }
            }
        }
    },
    {
        '$sort' :
        {
            'revenue': -1
        }
    },
    {
        '$limit' : 1
    }
])

for lineitem in list(lineitems):
    print(lineitem)
