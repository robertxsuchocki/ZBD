#!/usr/bin/env python3
import os
import sys

from itertools import permutations, zip_longest
from random import choice, randint, shuffle

def grouper(iterable, n):
    return list(zip_longest(*([iter(iterable)] * n)))

def choice_excluded(seq, item):
    return choice([x for x in seq if x != item])

if (len(sys.argv) != 2):
    sys.exit("Usage: " + sys.argv[0] + " SF")

all_pairs = []
amount = int(float(sys.argv[1]) * 150000)
groups = grouper(sorted(list(range(1, amount + 1)), key=os.urandom), 10)

for group in groups:
    all_pairs.extend(permutations([x for x in group if x is not None], 2))

    for elem in group:
        other = choice_excluded(groups, group)
        rands = [randint(1, amount) for _ in range(7)]
        rest = list(other) + rands
        all_pairs.extend([(elem, x) for x in rest] + [(x, elem) for x in rest])

all_pairs = list(set(all_pairs))
all_pairs.sort()

with open('friendship.csv', 'w') as f:
    f.write("f_friendshipkey, f_firstcustkey, f_secondcustkey")
    for i, pair in enumerate(all_pairs):
        f.write(str(i + 1) + ", " + str(pair[0]) + ", " + str(pair[1]) + "\n")
