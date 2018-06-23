import math
import multiprocessing as mp
import numpy as np
import sys

def multi_f(start, end, n, id_process, arr):
    soma = 0
    j = start
    m = float(end - start) / n

    for i in range( n ):
        j += m
        soma += 4.0 / (1 + j**2)

    arr[id_process] = soma

    print("Total soma processo",id_process,": ", soma)

n, m = sys.argv[1:]
n, m = int(n), int(m)
start, end = 0, 1
A = mp.Array('f', range(m))

bounds = np.linspace(start, end, m+1)

processes = []

for i in range(m):
    p = mp.Process(target = multi_f, args=( bounds[i], bounds[i+1], int(n / m), i, A ) )
    processes.append( p )
    p.start()

for p in processes:
    p.join()

pi = sum( A )/n
print("Valor do pi aproximado final:", pi)
