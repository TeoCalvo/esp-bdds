import math
import multiprocessing as mp
import numpy as np
import sys

def my_f(x):
    return 4.0 / (1 + x ** 2)

def multi_f(start, end, n, id_process, input_pipe):
    soma = 0
    j = start
    m = float(end - start) / n

    for i in range( n ):
        j += m
        soma += my_f(j)

    input_pipe.send(soma)
    input_pipe.close()
    print("Total soma processo",id_process,": ", soma)

n, m = sys.argv[1:]
n, m = int(n), int(m)
start, end = 0, 1
bounds = np.linspace(start, end, m+1)

processes, pipe_list = [], []

for i in range(m):  
    output_pipe, input_pipe = mp.Pipe()
    p = mp.Process(target = multi_f, args=( bounds[i], bounds[i+1], int(n / m), i, input_pipe, ) )
    processes.append( p )
    pipe_list.append( output_pipe )
    p.start()

for p in processes:
    p.join()

soma = sum( [ i.recv() for i in pipe_list ] )
    
print("Valor do pi aproximado final:", soma/n)