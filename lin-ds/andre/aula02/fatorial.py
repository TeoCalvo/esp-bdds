def fatorial(n):
    if n == 0:
        return 1
    else:
        return n * fatorial(n-1)

n = int( input("Entre com um valor para calcular o fatorial: "))

print( fatorial(n) )
