source("config/setup.R")
ishtml <- knitr::opts_knit$get("rmarkdown.pandoc.to") %in% c("html", "slidy")
# Lista de pacotes presentes nessa sessão.
search()

# Pacotes insladados.
ip <- installed.packages()
dim(ip)

# Quantidade de pacotes em cada grupo.
table(ip[, "Priority"], useNA = "always")

# Os pacotes do grupo `base` e `recommended`.
ip[ip[, "Priority"] %in% c("base", "recommended"),
   c("Package", "Version", "Priority")]
# Topo e cauda dos objetos do pacote `base`.
head(ls("package:base"), n = 50)
tail(ls("package:base"), n = 20)
head(ls("package:stats"))
tail(ls("package:stats"))
# Mostra o conjunto de funções disponíveis com final `apply`.
apropos("^.*apply$")
# Uma matriz.
m <- matrix(1:12, nrow = 3, ncol = 4)
m

# Soma percorrendo cada margem.
apply(m, MARGIN = 1, FUN = sum)
apply(m, MARGIN = 2, FUN = sum)

# Parte a matriz nas linhas criando uma lista de vetores.
l <- split(m, f = seq_len(nrow(m)))
l

# Diferença entre as funções que percorrem listas.
lapply(l, FUN = sum)
sapply(l, FUN = sum)

# Cria uma tabela de dados com duas variáveis de níveis cruzados e
# acrescenta respostas numéricas aleatórias.
da <- expand.grid(A = 1:2,
                  B = 1:3,
                  rpt = 1:2,
                  KEEP.OUT.ATTRS = FALSE)
da$x <- rnorm(nrow(da))
da$y <- runif(nrow(da))
str(da)

# Estatística por níveis de uma variável estratificadora.
with(da,
     tapply(X = y, INDEX = A, FUN = mean))

# Estatística pela combinação de níveis de variáveis estratificadoras.
with(da,
     tapply(X = y, INDEX = list(A, B), FUN = mean))

# O mesmo de antes mas no formato de tabela (colunar).
with(da,
     aggregate(y, by = list(A = A, B = B), FUN = mean))
aggregate(y ~ A + B, data = da, FUN = mean)
aggregate(cbind(y, x) ~ A + B, data = da, FUN = mean)

# Útil para imputação.
with(da,
     ave(y, B, FUN = mean))
# Mostra o conjunto de funções disponíveis com começo `read`.
apropos("^read.*$")
apropos("^write.*$")
url1 <- "https://raw.githubusercontent.com/leg-ufpr/hackathon/master/notas.csv"
url2 <- "https://raw.githubusercontent.com/leg-ufpr/hackathon/master/opinioes.json"

# Exibe o diretório de trabalho.
getwd()

# Exibe os arquivos que batem com o padrão.
dir(pattern = "*\\.(csv|json)$")

# Verifica se o arquivo existe e em negativo, faz o download.
if (!file.exists(basename(url1))) {
    download.file(url = url1,
                  destfile = basename(url1))
}

if (!file.exists(basename(url2))) {
    download.file(url = url2,
                  destfile = basename(url2))
}
# Carrega o conteúdo de um script externo.
source("https://raw.githubusercontent.com/walmes/wzRfun/master/R/tree.R")

# Exibe o diretório na forma de árvore.
tree()
# Faz a leitura do aquivo CSV. Exceto o parâmetro `file`, ou demais são
# opcioanis pois tem valor default.
csv <- read.table(file = "notas.csv",
                  header = TRUE,
                  sep = ";",
                  dec = ".",
                  # stringsAsFactors = FALSE,
                  quote = "\"",
                  comment.char = "",
                  na.string = "",
                  encoding = "UTF-8")

# Visão estrutural do conjunto de dados: dimensão, nomes, conteúdo,
# tipos de valores.
str(csv)

# Visão panorâmica do conjunto de dados: frequência e domínio.
summary(csv)

# Classe e métodos disponíveis.
class(csv)
methods(class = "data.frame")
## install.packages(pkgs = "jsonlite",
##                  dependencies = TRUE,
##                  repos = "http://cran-r.c3sl.ufpr.br/")
# Carrega o pacote.
library(jsonlite)

# Exibe as funções do pacote.
ls("package:jsonlite")

# Lê os dados no arquivo JSON.
json <- fromJSON("opinioes.json", simplifyVector = FALSE)
class(json)
length(json)
length(json[[1]])

# Estrutura do objeto inteiro (com controle de exibição).
str(json, list.len = 5)

# Estrutura do primeiro elemento da lista.
str(json[[1]])
# Número de registros para cada quesito.
xtabs(~quesito, data = csv)

# Número de ocorrências dos ID.
unique(xtabs(~ID, data = csv))
# Fixa a semente de forma bem criativa (#SQN).
set.seed(1234)

# Isso é ser criativo ;).
sum(as.integer(rawToBits(charToRaw("O R é o máximo!"))))

# Gera o índice dos registros que serão removidos.
i <- sample(x = 1:nrow(csv),
            size = floor(0.05 * nrow(csv)),
            replace = FALSE)
length(i)/nrow(csv)

# Remove os registros.
csv <- csv[-i, ]

# Número de registros para cada quesito.
sort(xtabs(~quesito, data = csv), decreasing = TRUE)

# Número de ID em para a quantidade de registros que possui.
table(xtabs(~ID, data = csv))
names(csv)
x <- csv$nota[csv$quesito == "Recomendação"]

# Medidas de posição e separação.
summary(x)

# Tabela de frequência.
table(x)

# O antigo digrama de ramos e folhas (que não funciona aqui).
stem(x, scale = 1, width = 20)

# Carrega o pacote mas omite as messagens de boas vindas.
suppressPackageStartupMessages(library(fBasics))
suppressPackageStartupMessages(library(EnvStats))

# Medidas descritivas clássicas.
basicStats(x)
summaryStats(x)
summaryFull(x)
# Obter a média para todos os quesitos.
m <- with(csv,
          tapply(X = nota,
                 INDEX = quesito,
                 FUN = mean))
cbind(média = sort(m))

# O mesmo mas usando aggregate que usa sintaxe de fórmula.
aggregate(nota ~ quesito, data = csv, FUN = mean)

# Obter média, desvio-padrão, etc.
aggregate(nota ~ quesito,
          data = csv,
          FUN = function(x) {
              c(mean = mean(x),
                sd = sd(x))
          })
# Obter todas as medidas descritivas para todos os quesitos.
with(csv,
     by(data = nota,
        INDICES = quesito,
        FUN = basicStats))
# Usando a `summaryStats()`.
with(csv,
     by(data = nota,
        INDICES = quesito,
        FUN = summaryStats))

est <- basicStats(x)
t(est)

# Faz a mesma coisa com uma sintaxe de maior controle.
structure(.Data = est[[1]],
          .Names = rownames(est),
          row.names = 1L,
          class = "data.frame")

myBasicStats <- function(x) {
    t(basicStats(x))
}

# Gera uma lista de data.frames de um registro em cada.
res <- with(csv,
            by(data = nota,
               INDICES = quesito,
               FUN = myBasicStats))

# Pega os nomes.
n <- names(res)

# Aplica uma função recursivamente sobre os elementos da lista.
res <- do.call(what = rbind, args = res)
rownames(res) <- n
res
# Partir, ordenar e extrair.
s <- by(data = csv,
        INDICES = csv$ID,
        FUN = function(subdata) {
            n <- nrow(subdata)
            j <- subdata$quesito[order(subdata$nota)][c(1, n)]
            data.frame(pior = j[1], melhor = j[2])
        })

# Coerção de lista de data.frames para data.frame (emplilhar).
s <- do.call(rbind, s)

# A distribuição de frequência.
sort(xtabs(~pior, data = s), decreasing = TRUE)
sort(xtabs(~melhor, data = s), decreasing = TRUE)

# ATTENTION: por causa das linhas removidas essa comparação não é muito
# fiel.  Se a remoção de linhas não fosse completamente ao acaso como
# proporsitalmente fizemos, poderia haver problemas.

# Se as notas fossem atribuidas casualmente, a frequência esperada seria
# o quociente abaixo (isso se não houver nenhum segredo sobre
# distribuição extremos que eu não sei).
nlevels(csv$ID)/nlevels(csv$quesit)
names(csv)

csvw <- reshape(data = csv,
                idvar = "ID",        # Fica na margem linha.
                timevar = "quesito", # Fica na margem coluna.
                v.names = "nota",    # Valores nas cédulas
                direction = "wide")
str(csvw)
library(reshape2)
ls("package:reshape2")

csvw <- dcast(data = csv,
              formula = ID ~ quesito,
              value.var = "nota")
str(csvw)
str(json[[1]])

# Percorre a lista e retém os elementos no vetor pela posição.
json2 <- lapply(json, FUN = "[", c(1, 3:5, 10))
str(json2[[1]])

# Simplifica a lista para um vetor.
json2 <- lapply(json2, FUN = unlist)
str(json2[[1]])

# Empilha todos os vetores gerando uma matriz.
json2 <- do.call(what = rbind, args = json2)
str(json2)

# Converte a matriz para tabela.
json2 <- as.data.frame(json2, stringsAsFactors = FALSE)
str(json2)

# Atribui nomes para as colunas.
names(json2) <- c("ID", "veiculo", "donoloc", "desc", "ts")
str(json2)

json2[sample(1:nrow(json2), size = 10), ]
# Ano. --------------------------------------
json2$ano <- sub(pattern = "^.* ([0-9/]+)$",
                 replacement = "\\1",
                 x = json2$veiculo)
table(json2$ano)

# Fabricante. -------------------------------
json2$fabricante <- sub(pattern = "^([^ ]+) .*$",
                        replacement = "\\1",
                        x = json2$veiculo)
table(json2$fabricante)

# Modelo. -----------------------------------
json2$modelo <- sub(pattern = "^[^ ]+ (.*) [0-9/]+$",
                    replacement = "\\1",
                    x = json2$veiculo)
length(unique(json2$modelo))

# Estado. -----------------------------------
json2$estado <- sub(pattern = "^.*([A-Z]{2})$",
                    replacement = "\\1",
                    x = json2$donoloc)
table(json2$estado)

# Cidade. -----------------------------------
json2$cidade <- sub(pattern = "^.*- (.*) [A-Z]{2}$",
                    replacement = "\\1",
                    x = json2$donoloc)
length(unique(json2$cidade))

# Nome do proprietário. ---------------------

head(json2$donoloc)

json2$propri <- sub(pattern = "^(.*) -.*",
                    replacement = "\\1",
                    x = json2$donoloc)
length(unique(json2$propri))
sort(table(json2$propri), decreasing = TRUE)[1:20]

# Carro anterior. ---------------------------

# Uma amostra da informação.
sample(json2$desc, size = 20)

ca <- grepl(pattern = "Carro anterior:", x = json2$desc)
sum(ca)
nrow(json2)

json2$carroant <- ifelse(test = ca,
                         yes = sub(pattern = ".*Carro anterior: (.+)$",
                                   replacement = "\\1",
                                   x = json2$desc),
                         no = NA)
sort(table(json2$carroant), decreasing = TRUE)[1:10]

# Distância percorrida. ---------------------
json2$km <- ifelse(test = grepl(pattern = "[0-9]+ km",
                                x = json2$desc),
                   yes = sub(pattern = ".*- ([0-9.]+) km.*$",
                             replacement = "\\1",
                             x = json2$desc),
                   no = NA)
json2$km <- as.integer(sub(pattern = "\\D",
                           replacement = "",
                           x = json2$km))
summary(json2$km)

# Tempo de posse. ---------------------------
json2$temposse <- sub(pattern = "^Dono há (.*) anos?.*",
                      replacement = "\\1",
                      x = json2$desc)
sort(table(json2$temposse), decreasing = TRUE)

json2$temposse[json2$temposse == "menos de 1"] <- "1"
json2$temposse <- as.integer(json2$temposse)
summary(json2$temposse)

# Data da avaliação. ------------------------
head(json2$ts)

ts <- strsplit(json2$ts, split = " ")
ts <- do.call(what = rbind, args = ts)
str(ts)

json2$data <- as.Date(x = ts[, 1], format = "%d/%m/%Y")
summary(json2$data)

# Dia da semana da avaliação. ---------------

json2$diasem <- weekdays(x = json2$data)
sort(table(json2$diasem))

# Hora da avaliação. ------------------------
json2$hora <- as.POSIXlt(x = ts[, 2],
                         format = "%H:%M:%S")
summary(json2$hora)

class(json2$hora)
methods(class = class(json2$hora)[1])

d <- json2$hora - as.POSIXlt(x = Sys.Date())
units(d) <- "hours"

json2$hora <- as.numeric(d, units = "hours")
head(json2$hora)

summary(json2$hora)

names(json2)
json2$veiculo <- NULL
json2$donoloc <- NULL
json2$desc <- NULL
json2$ts <- NULL

str(json2)
carros <- merge(x = csvw,
                y = json2,
                by = "ID",
                all = TRUE)
str(carros)

# Salva em disco todos os objetos do workspace.
save.image(file = "manipulacao.RData")

# Salva apenas os arquivos listados.
save(carros, file = "carros.RData")
