import math

def my_f(x):
	return 4.0 / (1 + x ** 2)

soma = 0
n = 100000000
m = 1.0/n
j=0

for i in range(n):
	j += m
	soma += my_f(j)

soma *= m

print soma