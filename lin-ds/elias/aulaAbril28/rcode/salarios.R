
if (FALSE) {
    setwd('dados') ### diretorio dos dados do censo 2010
    (z0 <- dir()) 
    (zz <- z0[grep('zip', z0)])
    names(zz) <- gsub('.zip', '', zz, fixed=TRUE)
    library(readr)
    ww <- fwf_positions(c(1, 29, 53, 159, 247, 322),
                        c(7, 44, 53, 161, 253, 327),
                        c('mun', 'peso', 'urb', 'grad', 'rend', 'rendt'))
    colcl <- do.call('cols', list('i', 'd', 'i', 'i', 'd', 'd'))
    system.time(res <- lapply(zz[c(18:19)], function(z) {
        system(paste('unzip', z))
        uf <- gsub('.zip', '', z, fixed=TRUE)
        fl <- dir(paste0(uf, '/Pessoas'))
        r <- read_fwf(paste0(uf, '/Pessoas/', fl), ww, colcl)
        system(paste('rm -r', uf))
        r$peso <- r$peso <- 1e-13
        return(r)
    }))
    setwd('..')
    print(object.size(res), un='Mb')
    save('res', file='pesourbgradrend.RData', compress='xz')
} else {
    load('pesourbgradrend.RData')
}
sapply(res, dim)
head(res[[1]])

sum(res$PR$peso) ## Populacao no PR em 2010
tapply(res$PR$peso, res$PR$urb, sum) ## Urbana e rural

(ptot <- sapply(res, function(d) sum(d$peso)))

ptot.uf.urb <- sapply(res, function(d)
    tapply(d$peso, d$urb, sum, na.rm=TRUE))
ptot.uf.urb

### Estatisticos
hist(log(res$PR$rendt[res$PR$grad==462], 10), 1:12/2)
sapply(res, function(x) table(x$grad==462)) ## na amostra
(etot <- sapply(res, function(x)
    sum(x$peso[which(x$grad==462)]))) ## total
(stot <- sapply(res, function(x) {
    ii <- which(x$grad==462)
    sum(x$peso[ii]*x$rendt[ii], na.rm=TRUE)
}))
rbind(etot, r=stot/etot) ### rendimento total medio

gradc <- list(DIREITO=380, FISICA=c(440, 441), QUIMICA=442,
              MATEMATICA=461, ESTATISTICA=462,
              CCOMPUTACAO=c(481,482,483),
              ENGs=520:525, EngProPME=540:544,
              ARQUITETURAU=581, ECIVILC=582, MEDICINA=721)

peso.g.sal <- Reduce('rbind', lapply(res, function(x) x[c('peso', 'grad', 'rendt')]))
dim(peso.g.sal)

sapply(gradc, function(x) sum(peso.g.sal$grad%in%x, na.rm=TRUE))

i <- which(peso.g.sal$grad%in%unlist(gradc))
str(i)

### totais 
ng <- sapply(gradc, function(g) {
    ii <- which(peso.g.sal$grad[i]%in%g)
    sum(peso.g.sal$peso[i[ii]], na.rm=TRUE)
    })
ng ### total estimado

ncs <- sapply(gradc, function(g) {
    ii <- which(peso.g.sal$grad[i]%in%g)
    sum(peso.g.sal$peso[i[ii]]*peso.g.sal$rendt[i[ii]], na.rm=TRUE)/
        sum(peso.g.sal$peso[i[ii]], na.rm=TRUE)
})
ncs

### compara com informacoes disponiveis
c(amb=250000, ## https://pt.wikipedia.org/wiki/Associa%C3%A7%C3%A3o_M%C3%A9dica_Brasileira
  oab=981097, ## http://www.oab.org.br/institucionalconselhofederal/quadroadvogados
  eciv=245117, ## http://ws.confea.org.br:8080/EstatisticaSic/ModEstatistica/Pesquisa.jsp?vw=ProfTitulo
  elettec=130550, agron=96051, eletric=94848, mecan=84686, prod=28411,
  fis=10000, ## http://www.sbfisica.org.br/v1/arquivos_diversos/publicacoes/Relatorio_SBF.pdf
  sbm=1584, ## http://associados.sbm.org.br/index.php/publico/associado
  NA)
### ASA=18000, ## http://www.amstat.org/about/asamembers.cfm
