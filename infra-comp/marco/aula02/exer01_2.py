import math
import multiprocessing as mp
import numpy as np

manager = mp.Manager()
return_dict = manager.dict()

def my_f(x):
	return 4.0 / (1 + x ** 2)

def multi_f(start, end, n):
	soma = 0
	j = start
	m = float(end - start) / n

	for i in range( n ):
		j += m
		soma += my_f(j)

	print(soma)

n, m = 100000, 4
start, end = 0, 1
bounds = np.linspace(start, end, m+1)

p = []

for i in range(m):
	p.append( mp.Process(target = multi_f, args=(bounds[i], bounds[i+1], int(n / m), ) ) )
	p[-1].start()

for process in p:
	process.join()