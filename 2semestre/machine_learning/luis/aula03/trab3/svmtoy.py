import sys
import numpy
from sklearn import svm
from sklearn.metrics import confusion_matrix
from sklearn.datasets import load_svmlight_file, make_classification, make_gaussian_quantiles, make_blobs
from sklearn.grid_search import GridSearchCV
from sklearn import preprocessing
from sklearn.model_selection import train_test_split

import pandas as pd

import matplotlib.pyplot as plt

def GridSearch(X_train, y_train):

    # define range dos parametros
    #k = ['linear', 'rbf']
    param_grid = {'gamma':2. ** numpy.arange(3,-15,-2),
                  'C': 2. ** numpy.arange(-5,15,2),
                  'kernel':['rbf']}

    # instancia o classificador, gerando probabilidades
    srv = svm.SVC(probability=True)

    # faz a busca
    grid = GridSearchCV(srv, param_grid, n_jobs=-1, verbose=True)
    grid.fit (X_train, y_train)

    # recupera o melhor modelo
    model = grid.best_estimator_
    
    # imprime os parametros desse modelo
    print(grid.best_params_)
    return model
    
def main():

    ## create data...
    plt.figure(figsize=(8, 8))  

    if sys.argv[1] == 'blobs':
        X_train, y_train = make_blobs(n_samples=300, centers=2)
    else:
        X_train, y_train = make_gaussian_quantiles(n_samples =300, n_features=2, n_classes =2)

    # cria um SVM
    clf =  svm.SVC(kernel='linear')

    # treina o classificador na base de treinamento
    print("Training Classifier...")
    clf.fit(X_train, y_train)
    
    #plt.subplot(211)
    #plt.scatter(X_train[:, 0], X_train[:, 1], marker='o', c=y_train, s=25, edgecolor='k')       
    #plt.scatter(clf.support_vectors_[:, 0], clf.support_vectors_[:, 1], marker='x')     
    
    # mostra o resultado do classificador na base de teste
    print('Desempenho Kernel Linear')
    acc_linear = clf.score(X_train, y_train)
    n_linear = clf.n_support_[0]+clf.n_support_[1] 
    print('Vetores de suporte:', n_linear )
    
    # GridSearch retorna o melhor modelo encontrado na busca
    best = GridSearch(X_train, y_train)

    # resultado do treinamento
    print('Accuracia no kernel RBF:', )
    acc_rbf = best.score(X_train, y_train)
    print(acc_rbf)
    n_rbf = best.n_support_[0]+best.n_support_[1] 
    print('Vetores de suporte:', n_rbf)

    # Treina usando o melhor modelo
    best.fit(X_train, y_train)
    #plt.subplot(212)
    #plt.scatter(X_train[:, 0], X_train[:, 1], marker='o', c=y_train, s=25, edgecolor='k')       
    #plt.scatter(best.support_vectors_[:, 0], best.support_vectors_[:, 1], marker='x')       
    #plt.show()

    return pd.DataFrame( {'n_linear':[n_linear],
                          'n_rbf':[n_rbf],
                          'acc_linear':[acc_linear],
                          'acc_rbf':[acc_rbf]} )

    # resultado do treinamento
    #print ('Accuracia no teste:', )
    #print best.score(X_test, y_test)

    # predicao do classificador
    #y_pred = best.predict(X_test)

    # cria a matriz de confusao
    #cm = confusion_matrix(y_test, y_pred)
    #print cm

if __name__ == "__main__":
    df = pd.DataFrame()
    for i in range( int( sys.argv[2] ) ):
        df = df.append( main() )
    
    print( df )
    df.to_csv("svm_compare_" + sys.argv[1] + ".csv", index=False)
    print( df.mean() )

