def fib(n):
    return 1 if n <= 1 else fib(n-1) + fib(n-2)

n = int( input("Entre com um valor para calcular o fibonacci: "))

print( fib(n) )
