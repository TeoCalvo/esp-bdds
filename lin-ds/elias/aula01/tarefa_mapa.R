# O mapa foi obtido a partir do link abaixo.
# sendo orientato pelo professor a utilizar tal fonte de maps.
# "http://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2016/UFs/PR/pr_municipios.zip"

# Importa as bibliotecas necessárias para trabalhar com os arquivos de mapas e dbf
library(foreign)
library(rgdal)

# Define os caminhos dos arquivos na web e diretórios locais para serem criados
path_url = "http://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2016/UFs/PR/pr_municipios.zip"
path_file = "pr_municipios.zip"
path_file_unz = "pr_municipios"
path_wiki_file = "aula01/dados_wikipedia.csv"

# Realizando o download e extração dos arquivos que contem o mapa
download.file(path_url, path_file)
unzip(path_file, exdir=path_file_unz)

# Importando o mapa dos municipios
map = readOGR( path_file_unz , "41MUE250GC_SIR")

# Importa dados obtidos pela página da wikipedia a respespeito da população em cada municipio do estado do paramá
# https://pt.wikipedia.org/wiki/Lista_de_munic%C3%ADpios_do_Paran%C3%A1_por_popula%C3%A7%C3%A3o
df_wiki = read.csv( path_wiki_file, sep=";")

# Padroniza o nome dos municipios para tudo maiusculo
df_wiki["city"] = toupper( df_wiki[,1] ) 

# Arruma o formato da população para numérico e remove espaços
df_wiki["pop"] = as.numeric( gsub( " ", "", df_wiki[,2] ) )

# Realiza o join entre as tabelas mantendo a ordem no mapa
df = merge( map@data , df_wiki, sort=F, by.x="NM_MUNICIP", by.y="city" )

# Atribui aos dados do mapa a coluna 'pop' que contem a informação de população
map$pop = df[,"pop"]

# Finamente plotas o mapa da população
spplot(map, "pop")

# Gera valores aleatório de uma distribuição normal para ser plotado
map$rnorm = rnorm( nrow(map@data) )

# Plota os valores gerados aleatoriamente
spplot( map, "rnorm" )
