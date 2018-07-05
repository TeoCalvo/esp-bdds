import math
import multiprocessing as mp
import numpy as np
import sys

def calc_pi(x):
    return 4.0 / (1 + x**2)

def np_pi(start, end, n):
    return np.sum( np.apply_along_axis( calc_pi , 0, np.linspace(start, end, n) ) )

n, m = [ int(i) for i in sys.argv[1:] ]

start = list( np.linspace(0, 1, m+1) )
end = start[1:] + [1]

pool = mp.Pool(processes=m)

result = [ pool.apply_async( np_pi , args=( start[i], end[i], n/m,) )  for i in range(m) ]

res = [i.get() for i in result]

print( sum(res)/n ) 
