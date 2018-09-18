##################################################
# DEFINIÇÕES DO ENUNCIADO                        #
##################################################

## Insira aqui o número da sua matrícula para fixar uma semente
matricula <- 40001016323

## Gera 1 milhão de números aleatórios de uma distribuição normal
set.seed(matricula)
pop <- rnorm(n = 1e6, mean = 100, sd = sqrt(200))

## Retira uma amostra aleatória de tamanho n = 1000 da população
amostra <- pop[sample(1:length(pop), size = 1000)]

##################################################
# EXERCÍCIO 1.                                   #
##################################################

# Criação de uma função para bootstrap
my_boot = function(data, m, r ){

    # Cria vetor com dimensão para realizar as amostragens
    vec_medias = rep(0, r)

    # Laço de repetição para reamostragem e cálculo da média
    for(i in 1:r){
        vec_medias[i] = mean( sample( data, m, replace=TRUE ))
    }

    # Retorna as médias calculadas
    return( vec_medias )
}

# Define os parâmetros para o bootstrap
m = 500
r = 100000

# Aplica a função de bootstrap criada acima
medias = my_boot(data=amostra, m=m, r=r)

# Plota o histograma das médias
hist(medias, main="Histograma das médias das amostras", ylab="Frequencia", xlab="Médias", col="royalblue")

# Cria função para calculas a diferença das médias de duas amostras/populações
dif_abs = function( vec_1, vec_2 ){
    return( abs( mean(vec_1) - mean(vec_2)  ) )
}

# Aprensenta a diferença absoluta entre as médias de duas amostras/populações
print( dif_abs(pop, medias) )

##################################################
# EXERCÍCIO 2.
##################################################

# Cria função genérica para bootstrap com varios tamanhos de amostras
my_multi_boot = function( data, vec_m , r ){

    # Cria matriz que amarzenará as médias calculadas
    matrix_medias = matrix( 0, r , length(vec_m) )

    # Realiza o bootstrap para cada um dos tamanhos diferentes
    for(i in 1:length(vec_m)){
        matrix_medias[,i] = my_boot( data , vec_m[i], r)
    }

    return(matrix_medias)
}

# Define os parâmetros para o bootstrap
vec_m = c(100, 300, 500, 700)
r = 100000

# Aplica a função de bootstrap criada acima
medias_2 = my_multi_boot(data=amostra, vec_m=vec_m, r=r)

# Plotando os histogramas
par(mfrow=c(2,2))
for(i in 1:ncol(medias_2)){
    lable = paste("Histograma das médias ( m =", vec_m[i], ")")
    hist(medias_2[,i], main=lable, ylab="Frequencia", xlab="Médias", col="royalblue", xlim=c(92,108))
    abline(v = mean( pop ), col="tomato")
}

# Calcula as diferenças das médias calculadas em relação à populacional
for(i in 1:ncol(medias_2)){
    dif =  dif_abs(pop, medias_2[,i])
    text = paste("Para tamanhos de amostra m=", vec_m[i], ", a diferença é: ", dif, sep="")
    print(text)
}