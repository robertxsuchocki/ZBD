import os
from re import sub

friendship_headers = "f_friendshipkey, f_firstcustkey, f_secondcustkey\n"

# Get *.tbl files for database
os.system("cp ../6/result.csv ./friendship.tbl")

for fname in os.listdir('.'):
    if fname.endswith(".tbl"):
        with open(fname, "r") as f:
            name = fname[:-4]
            with open(name + ".csv", "a") as new_f:
                new_f.write(eval(name + "_headers"))
                for line in f.readlines():
                    line = sub('\|', ', ', line)
                    new_f.write(line)
        os.system("mongoimport -d tpch --type csv --file " + name + ".csv --headerline")
        os.system("rm ./" + fname)
        os.system("rm ./" + name + ".csv")
