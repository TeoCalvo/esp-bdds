
library(dplyr)

df = read.csv("youtube.txt", sep=" ")


df_new = mutate(group_by(df,CANAL), ACC_INSCRITOS=cumsum(INSCRITOS))
df_new$ACC_INSCRITOS_10 = df_new$ACC_INSCRITOS / 100000

df_canal1 = df_new[ df_new$CANAL == "inventonahora" , ]
df_canal2 = df_new[ df_new$CANAL != "inventonahora" , ]

fx = function(par, x) { par[1] / ( 1 + exp( par[2]*( x - par[3] ) ) ) }

f_ols = function( par, dias, valor) { return( sum( (valor - par[1] / ( 1 + exp( par[2]*( dias - par[3] ) ) ) )^2 ) ) }


fx_2 <- function(par, y, dias  ) {
  mu <-  par[1] / ( 1 + exp( par[2]*( dias - par[3] ) ) ) 
  SQ <- sum( (y - mu)^2 )
  return(SQ)
}

# AJUSTANDO A PORRA DOS PARAMETROS
par_1 = c( max( df_canal1$ACC_INSCRITOS_10 ), -0.01 ,median(df_canal1$ACC_INSCRITOS_10) )

adj_1 = optim( par=par_1, f_ols, dias=df_canal1$DIAS , valor=df_canal1$ACC_INSCRITOS_10 )

# PLOTANDO A PORRA DO GRÁFICO
plot(df_canal1$ACC_INSCRITOS_10 ~ df_canal1$DIAS, type="l", xlim=c(0,1200), ylim=c(0,25)  ) 
lines( fx(par=adj_1$par, x=1:1200), col="red" )

