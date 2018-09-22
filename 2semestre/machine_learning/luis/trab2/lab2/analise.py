import pandas as pd
import numpy as np
#import seaborn
import matplotlib.pyplot as plt

nb_txt = open('nb.txt','r')
nb_l = [ np.float64(i.strip("\n")) for i in nb_txt.readlines()]
nb_txt.close()

lg_txt = open('logist.txt', 'r')
lg_l = [ np.float64(i.strip("\n")) for i in lg_txt.readlines()]
lg_txt.close()

lda_txt = open('lda.txt', 'r')
lda_l = [ np.float64(i.strip("\n")) for i in lda_txt.readlines()]
lda_txt.close()

lag = np.arange(500,20001,500)

plt.plot( lag, nb_l )
plt.plot( lag, lg_l )
plt.plot( lag, lda_l )
plt.legend( ['Naive-Bayes', "Regressao Logistica", "Linear Discriminante"], loc='lower right' )
plt.title( "Comparacao de modelos" )
plt.xlabel("Tamanho de amostra")
plt.ylabel("Performance")
plt.show()


