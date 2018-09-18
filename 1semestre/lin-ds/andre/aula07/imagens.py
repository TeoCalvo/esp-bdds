import numpy as np

arq = open( "../Dados-20180622/imagens/ballons.pgm" ) 
print(arq)

formato = arq.readline()
print(formato)

col, lin = [ int(i) for i in arq.readline().split() ]
print(col, lin)

max_pixel = eval(arq.readline())
print("Maior pixel: ", max_pixel)

data = np.array( arq.read().split() , dtype='int' ).reshape( (lin, col) )
print(data)

limiar = max_pixel * 0.5

data[ data < limiar ]  = 0
data[ data > limiar ]  = 255

#data = np.array( data, dtype='str')

header = "{formato}{coluna} {linha}\n{max_pixel}\n".format(formato=formato, linha=lin,coluna=col,max_pixel=255)
np.savetxt( 'saida_imagem.pmg',data, fmt="%s" ,header=header, comments='' )

from PIL import Image

