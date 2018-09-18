''' 
Escrever um programa que:

1. receba como argumento o diretório de imagens de números

2. transforme cada imagem em um vetor de características/atributos/pixels

3. adicione um rótulo ao vetor, correlacionando os números com o nome do arquivo da imagem (files.txt)

4. escreva os vetores que representam as imagens rotuladas em um arquivo, onde cada vetor é uma linha desse arquivo

'''
import sys
import os
from PIL import Image
import numpy as np

if len(sys.argv) < 4:
    print("Entre com todos os parametros necessários")
else:
    path_img, path_files, path_out = sys.argv[1:]

    files = open(path_files, "r")

    path_target = {}
    for file in files:
        a, b = file.split()
        name = a.split("/")[-1]
        path_target[name] = b

    files.close()

    list_img, target = [], []
    for img in os.listdir(path_img):
        if img.endswith("tif"):
            mem_img = Image.open( path_img+img )
            list_img.append( np.array( mem_img.resize((100,100)), dtype=int ).flatten()  )
            target.append( path_target[img] )
            mem_img.close()

    data = np.array(list_img)
    target = np.array( target, dtype=int ).reshape( (len(target),1) )
    data = np.append( data , target, axis=1)
    np.savetxt(path_out,data, delimiter=";")