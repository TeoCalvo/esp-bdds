# 1)

m = matrix( c( 2, 0, 9, 8, 4, 7, 4, 1, 5), 3,3)
print(m)

# 2)
rownames(m) = c("linha1", "linha2", "linha3")
colnames(m) = c("coluna1", "coluna2", "coluna3")
print(m)

# 3)
lista = list( rep(c("A", "B", "C"), c(2, 5, 4) ) , m  )
print(lista)

# 4)
names(lista) = c("nome1", "nome2")
print(lista)

# 5)
lista$fator = factor( c("brava", "joaquina", "armação"), )
print(lista)

# 6)
df = data.frame( local=c("A", "B", "C", "D"), contagem=c(42, 34, 59 , 18))


# 7)
paulo = list("paulo", "rose", 2)
dd = data.frame(nome = "mariana", sobrenome="nogute", qtde_pet=2, stringsAsFactors = FALSE)
dd = rbind(dd,paulo)

dd$time = c("Sao Paulo", "Pain")
print(dd)
