library(shiny)
require(devtools)
devtools::install_bitbucket("finnlindgren/FLtools")
url <- "https://bitbucket.org/finnlindgren/fltools/raw/1a89118e76799f0642b2074e3b39b23251020acd/R/optimisation.R"
source(url)
ls()
optimisation()

