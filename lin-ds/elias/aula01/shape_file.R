path_url = "http://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2016/UFs/PR/pr_municipios.zip"
path_file = "pr_municipios.zip"
path_file_unz = "pr_municipios"

download.file(path_url, path_file)

unzip(path_file, exdir=path_file_unz)

data <- read.shp( paste(path_file_unz,"41MUE250GC_SIR", sep="/") )

load("map.RData")
