### a criacao do banco esta descrita no arquivo README.txt 
### os arquivos usados em README.txt (inclusive este) estao em
### http://leg.ufpr.br/~elias/ensino/ce083/menagerie-db/

### o login ao banco pode ser feito com
### mysql --host=200.17.213.55 -D menagerie --user='aluno' -p
### e senha '12345'

### apos logar, volte o cursor para cima e veja as queries feitas
library(DBI)
con <- dbConnect(RMariaDB::MariaDB(), user='dsbd01',
                 password='1234567', dbname='menagerie')
dbListTables(con)

d1q <- dbSendQuery(con, 'select * from pet')
d1 <- dbFetch(d1q)
summary(d1)
d1

table(d1$sex, d1$species)

dbClearResult(d1q)

d1fq <- dbSendQuery(con, 'select * from pet where sex="f"')
d1f <- dbFetch(d1fq)
d1f
dbClearResult(d1fq)

### seleciona apenas as variaveis name, species, sex da tabela pet
### quando a variavel birth e' maior que 1995/01/01
d2q <- dbSendQuery(con, "select name,species,sex from pet where birth>'1995-01-01'")
d2 <- dbFetch(d2q)
d2

dbClearResult(d2q)

### merge
d3q <- dbSendQuery(con, paste('select * from pet left join',
                              'event on pet.pet_id=event.pet_id'))
d3 <- dbFetch(d3q)
d3

dbClearResult(d3q)

d4q <- dbSendQuery(con, paste('select name,sex,species,date,type',
                              'from pet left join',
                              'event on pet.pet_id=event.pet_id'))
d4 <- dbFetch(d4q)
d4

dbClearResult(d4q)

d5q <- dbSendQuery(con, paste('select name,sex,owner,date,type',
                              'from pet inner join',
                              'event on pet.pet_id=event.pet_id'))
(d5 <- dbFetch(d5q))

dbClearResult(d5q)

### restricao (apenas sex='f')
d6q <- dbSendQuery(con, paste('select name,sex,owner,date,type',
                              'from pet inner join',
                              'event on pet.pet_id=event.pet_id',
                              'where sex="f"'))
d6 <- dbFetch(d6q)
d6

dbClearResult(d6q)

dbDisconnect(con)
