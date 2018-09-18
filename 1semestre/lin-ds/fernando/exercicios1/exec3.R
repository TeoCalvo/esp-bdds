# 1)
x = c( 54, 0, 17, 94, 12.5, 2, 0.9, 15)

print(x+c(5,6))
print(x+c(5,6,7))

# 2)
letras = rep( c("A", "B", "C"), c(15, 12,8) )

# a) 
letras == "B"

# b)
sum( letras == "B" )

# 3)
uni = runif(100, 0, 1)
sum( uni >= 0.5 )

# 4)
x = 2^(1:50)

# a)
y = (1:50)^2

# b)
x[ x==y ]

# c)
length(x[ x==y ])

# 5)
num = seq(0, 2*pi, 0.1)
seno = sin(num)
cosseno = cos(num)
tangente = tan( num )

# a)
tan_calc = seno / cosseno

# b)
dife = tan_calc - tangente

# c)
dife != 0

# d)
max(abs(dife))
print("Isso ocorre dado a precisão do R")
