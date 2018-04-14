# 1) 
df = data.frame(qtde.cara = c(42,34,59,18),
				local=c("Joaquina", "Campache", "Armacao", "Praia Mole") )

# 2) 
df$local[df$qtde.cara < 30]

# 3)
x = c()
for(i in df$local){
	if(i %in% c("Joaquina" ,"Praia Mole") ){
		x = c(x,"leste")
	 }

	 else{
	  x = c(x, "sul")
	 }
}

df$regiao = x

# 4)
df[ df$regiao == "leste" & df$qtde.cara < 20, ] 

# 5)
subset(df, regiao == "sul" & qtde.cara > 40, select = "local" ) 

# 6)
subset(df, qtde.cara > 50, select = "regiao" ) 