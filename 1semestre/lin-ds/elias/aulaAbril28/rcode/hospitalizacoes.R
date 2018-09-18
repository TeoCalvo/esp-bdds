
if (FALSE)
    setwd('..')

library(foreign) ## dados .dbf
library(rgdal) ## biblioteca para trabalhar com mapas
if (!require(rgdal))
    library(maptools) ## alternativa, funcao readShapePoly()

### Dados de internacoes 
r <- read.dbf('data/RDPR1509.dbf')

dim(r)
names(r)

### Numero de missing por coluna
(na <- colSums(is.na(r)))
summary(na)
tail(sort(na),20)

### Valor total por procedimento
hist(log(r$VAL_TOT))

## Mapa do Brasil dividido por municipios
if (require(rgdal)) {
    br <- readOGR('map/', 'BRMUE250GC_SIR')
} else {
    br <- readShapePoly('map/BRMUE250GC_SIR')
}
names(br)
str(which(substr(br$CD_GEOCMU,1,2)=='41'))

pr <- br[which(substr(br$CD_GEOCMU,1,2)==41),]

## INSPECIONA
names(attributes(pr))
pr@class
length(pr@polygons)
str(pr@polygons[[1]]) ###
dim(pr@data) ### atributos
head(pr@data)

par(mar=c(0,0,0,0))
plot(pr)

mun.val <- data.frame(val=tapply(r$VAL_TOT, r$MUNIC_RES, sum))
dim(mun.val) ## 567 municipios
head(mun.val,2)

### 2 digitos: UF
table(substr(rownames(mun.val),1,2))

### adiciona codigo com 6 digitos como coluna
mun.val$cod6 <- substr(rownames(mun.val),1,6)

head(mun.val,2)

head(pr@data,2)

### join dados na tabela de atributos do mapa
djoin <- merge(data.frame(pr@data, cod6=substr(pr@data$CD,1,6)),
               mun.val, sort=FALSE) ### preserva a ordem do mapa
table(djoin$cod6==substr(pr@data$CD,1,6))
pr@data <- djoin

### opcao 1 de visualizar
spplot(pr, 'val')

### opcao 2: construir classes e cores
q <- quantile(pr$val, 0:10/10)
q

i.color <- findInterval(pr$val, q, rightmost.closed=TRUE)
table(i.color)
rcol <- rgb(0:9/10, 1-2*abs(0:9/10-0.45), 9:0/10)

plot(pr, col=rcol[i.color])
legend('topleft', leglabs(format(q/1e3, dig=2), '<', '>'),
       fill=rcol, bty='n', title='Valor (mil R$)')

### visualização no GoogleMaps (iterativa)
library(plotGoogleMaps)
names(pr)
plotGoogleMaps(pr, 'ValorInternacoes.html', 4)

if (FALSE) {
    map <- pr
    map@data <- pr@data[, 1:3]
    save('map', file='map.RData')
}
