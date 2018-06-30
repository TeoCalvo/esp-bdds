import math
import multiprocessing as mp
import numpy as np
import sys

def calc_pi(x):
    return 4.0 / (1 + x**2)

n, m = [ int(i) for i in sys.argv[1:] ]

bounds = np.linspace(0, 1, n)
pool = mp.Pool(processes=m)

result = pool.map( calc_pi , bounds)
print( sum(result) / n) 
