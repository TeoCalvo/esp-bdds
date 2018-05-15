# O mapa foi obtido a partir do link abaixo.
# sendo orientato pelo professor a utilizar tal fonte de maps.
# "http://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2016/UFs/PR/pr_municipios.zip"

library(rgdal)

path_url = "http://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2016/UFs/PR/pr_municipios.zip"
path_file = "pr_municipios.zip"
path_file_unz = "pr_municipios"

# Realizando o download e extração dos arquivos que contem o mapa
download.file(path_url, path_file)
unzip(path_file, exdir=path_file_unz)

# Importando o mapa dos municipios
data = readOGR( path_file_unz , "41MUE250GC_SIR")

