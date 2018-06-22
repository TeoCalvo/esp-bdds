
# coding: utf-8

import numpy as np
import csv
import sys

if len( sys.argv ) >=3 :
    actual, arq1, arq2, arq3, arq4, *_ = sys.argv

else:
    print("Entre com os nomes dos arquivos corretos.")

print(arq1, arq2, arq3, arq4, sep="\n")

# Importa os dados dos arquivos txt
d1 = np.genfromtxt(arq1, delimiter=";", skip_header=1)
d2 = np.genfromtxt(arq2, delimiter=";", skip_header=1)

# Concatena as linas dos dois arquivos em uma única matriz
d3 = np.append(d1,d2, axis=0)

# Obtem o header de um dos arquivos
header = open(arq1, 'r').readline()
header = ",".join( header.strip("\n").split(";") )

# Define uma lista que contem o tipo de vinho (1 para red e 2 para white)
type_wine = [1 for i in range(d1.shape[0])] + [2 for i in range(d2.shape[0])] 
type_wine = np.array( type_wine).reshape( (d3.shape[0],1) )

# Adiciona uma coluna referente ao tipo de vinho
d4 = np.append( d3, type_wine, axis=1 )

# Adiciona 'tipo' no header
header += ",tipo"
header_list = header.split(",")

print("\n Header: ", header)
print( "\n Numero de linhas totais, somando cada matriz: " , d1.shape[0] + d2.shape[0] )
print( "\n Número de linhas na nova matriz: " , d4.shape[0] )

# Verifica se os dados importados são os mesmos que foram salvados
np.savetxt(arq3, d4, header=header , delimiter=",")
d5 = np.genfromtxt(arq3, delimiter=",", skip_header=True)
print("\n Checagem de dados...")
print(d4 == d5)

# Busca o indice em que se encontra a qualidade
quality_index = header_list.index('"quality"')

# Busca o indice em que se encontra o tipo (rótulo)
tipo = header_list.index("tipo")

# Realiza os cálculos das médias
mean_all = d4[:,quality_index].mean()
mean_red = d4[ d4[:,tipo]==1, quality_index ].mean()
mean_white = d4[ d4[:,tipo]==2, quality_index ].mean()

# Cria vetor de médias
means = np.array([mean_all, mean_red, mean_white], ndmin=2)

# Exibe as médias calculadas
print("\n Qualidade média geral:" , mean_all)
print(" Qualidade média red:" , mean_red)
print(" Qualidade média white:" , mean_white)

# Salva o arquivo com as médias calculadas
header_mean = "geral,tinto,branco"
np.savetxt(arq4, means, header=header_mean, delimiter=",")
