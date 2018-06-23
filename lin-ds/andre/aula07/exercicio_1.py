from PIL import Image
import numpy as np

def meu_parser( path ):
    imagem = Image.open( path )
    linha = np.array( imagem, dtype=int ).flatten()
    linha = np.array( imagem, dtype=str )
    return linha

lista_arquivos = open( "/home/espinf/tbcalvo/Documentos/esp-bdds/lin-ds/andre/Dados-20180622/digits_2K/files.txt" )

arq = open("minha_saida_imagens.txt", "w")
arquivos, target = [], []
for i in lista_arquivos.readlines():
    a,b = i.split()
    linha = ",".join( meu_parser(a) ) + b + "\n"
    arq.write( linha )
    arquivos.append(a)
    target.append(b)


arq.close()