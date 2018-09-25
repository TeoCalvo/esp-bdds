import pandas as pd
import numpy as np
import seaborn
import matplotlib.pyplot as plt

nb = pd.read_csv('nb.txt',sep=';')
lg = pd.read_csv('logist.txt', sep=';')
lda = pd.read_csv('lda.txt', sep=';')
knn = pd.read_csv('knn.txt', sep=';')

lag_500= np.arange(500,20001,500)
lag_1000 = np.arange(1000,20001,1000)


plt.subplot( 1, 2, 1) 
plt.plot( lag_500, nb['performance'] )
plt.plot( lag_500, lg['performance'] )
plt.plot( lag_500, lda['performance'] )  
plt.plot( lag_500,knn['performance'] ) 
plt.legend( ['Naive-Bayes', "Regressao Logistica", "Linear Discriminante", 'Knn'], loc='best' )
plt.title( "Comparacao de modelos" )
plt.xlabel("Tamanho de amostra")
plt.ylabel("Performance")
plt.grid(True)

plt.subplot( 1, 2, 2) 
plt.plot( lag_500, np.log( nb['tempo']) )
plt.plot( lag_500, np.log( lg['tempo']) )
plt.plot( lag_500, np.log( lda['tempo']) )  
plt.plot( lag_500, np.log(knn['tempo']) ) 
plt.legend( ['Naive-Bayes', "Regressão Logistica", "Análise Discriminante Linear", 'Knn'], loc='best' )
plt.title( "Comparacao de modelos" )
plt.xlabel("Tamanho de amostra")
plt.ylabel("Tempo log(segundos)")
plt.grid(True)

plt.show()


