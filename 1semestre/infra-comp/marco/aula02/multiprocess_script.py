# coding: utf-8

import math
import multiprocessing as mp
import numpy as np
import sys

def my_f(x):
    return 4.0 / (1 + x ** 2)

def multi_f(start, end, n, id_process, q):
    soma = 0
    j = start
    m = float(end - start) / n

    for i in range( n ):
        j += m
        soma += my_f(j)

    q.put(soma)
    print("Total soma processo",id_process,": ", soma)

n, m = sys.argv[1:]
n, m = int(n), int(m)
start, end = 0, 1
bounds = np.linspace(start, end, m+1)

p, q = [] , mp.Queue()

for i in range(m):
    p.append( mp.Process(target = multi_f, args=(bounds[i], bounds[i+1], int(n / m),i,q, ) ) )
    p[-1].start()

for process in p:
    process.join()

soma = 0
while not q.empty():
    soma += q.get()
    
print("Valor do pi aproximado final:", soma/n)