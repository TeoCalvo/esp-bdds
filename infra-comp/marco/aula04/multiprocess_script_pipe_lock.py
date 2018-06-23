import math
import multiprocessing as mp
import numpy as np
import sys

def multi_f(start, end, n, id_process, input_pipe, lock):
    soma = 0
    j = start
    m = float(end - start) / n

    for i in range( n ):
        j += m
        soma += 4.0 / (1 + j**2)

    with lock:
        input_pipe.send(soma)

    input_pipe.close()
    print("Total soma processo",id_process,": ", soma)

n, m = sys.argv[1:]
n, m = int(n), int(m)
start, end = 0, 1

bounds = np.linspace(start, end, m+1)

lock = mp.Lock()
processes, pipe_list = [], []

output_pipe, input_pipe = mp.Pipe()

for i in range(m):
    p = mp.Process(target = multi_f, args=( bounds[i], bounds[i+1], int(n / m), i, input_pipe, lock ) )
    processes.append( p )
    p.start()

for p in processes:
    p.join()

soma = sum( [ output_pipe.recv() for i in range(m) ] )
print("Valor do pi aproximado final:", soma/n)
