
# coding: utf-8

import numpy as np
import sys

if len( sys.argv ) >=3 :
	arq1, arq2, arq3, arq4, *_ = sys.argv[1:]

else:
    print("Entre com os nomes dos arquivos corretos.")

label_1 = "red" if "red" in arq1 else "white"
label_2 = "red" if "red" in arq2 else "white"

print("\n Arquivos a serem importados:", arq1, arq2, arq3, arq4, sep="\n")

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

# Verifica se os dados importados são os mesmos que foram salvados
np.savetxt(arq3, d4, header=header , delimiter=",")
d5 = np.genfromtxt(arq3, delimiter=",", skip_header=True)

# Busca o indice em que se encontra a qualidade
quality_index = header_list.index('"quality"')

# Busca o indice em que se encontra o tipo (rótulo)
tipo = header_list.index("tipo")

# Realiza os cálculos das médias
mean_all = d4[:,quality_index].mean()
mean_1 = d4[ d4[:,tipo]==1, quality_index ].mean()
mean_2 = d4[ d4[:,tipo]==2, quality_index ].mean()

# Cria vetor de médias
means = np.array([mean_1, mean_2, mean_all], ndmin=2)

# Exibe as médias calculadas

texto_1 = "| {0:<10} | {1:>.10} |"
texto_2 = "| {0:<10} | {1:<11} |"
linha = "+" + "-"*26 + "+"

print("\n", linha, sep="")
print( texto_2.format("Rótulo", "Média") )
print(linha)
print( texto_1.format(label_1, mean_1) )
print( texto_1.format(label_2, mean_2) )
print( texto_1.format("Geral", mean_all) )
print(linha)

# Salva o arquivo com as médias calculadas
header_mean = "geral,tinto,branco"
np.savetxt(arq4, means, header=header_mean, delimiter=",")
