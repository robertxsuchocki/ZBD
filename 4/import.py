import os

for fname in os.listdir('.'):
    if fname.endswith(".csv"):
        os.system("mongoimport -d tpch --type csv --file " + fname + " --headerline")
