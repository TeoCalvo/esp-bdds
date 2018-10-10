import sys
import numpy
import pandas as pd
from sklearn import cross_validation
from sklearn import svm
from sklearn.metrics import confusion_matrix
from sklearn.datasets import load_svmlight_file
from sklearn.grid_search import GridSearchCV
from sklearn import preprocessing
import time

def GridSearch(X_train, y_train, k):

    # define range dos parametros
    C_range = 2. ** numpy.arange(-5,15,2)
    gamma_range = 2. ** numpy.arange(3,-15,-2)
    param_grid = dict(gamma=gamma_range, C=C_range, kernel=[k])

    # instancia o classificador, gerando probabilidades
    srv = svm.SVC(probability=True)

    # faz a busca
    grid = GridSearchCV(srv, param_grid, n_jobs=-1, verbose=10)
    grid.fit (X_train, y_train)

    # recupera o melhor modelo
    model = grid.best_estimator_

    # imprime os parametros desse modelo
    print(grid.best_params_)
    return model

def main(datatr, datats):

    # loads data
    print("Loading data...")
    X_train, y_train = load_svmlight_file(datatr)
    X_test, y_test = load_svmlight_file(datats)

    # GridSearch retorna o melhor modelo encontrado na busca
    print("Treinamento grid search LINEA...")
    t_s = time.time()
    best_linear = GridSearch(X_train, y_train, k='linear')
    time_linear_grid = time.time() - t_s
    
    print("Treinamento grid search RBF...")
    t_s = time.time()
    best_rbf = GridSearch(X_train, y_train, k='rbf')
    time_rbf_grid = time.time() - t_s

    # Treina usando o melhor modelo
    t_s = time.time()
    best_linear.fit(X_train, y_train)
    time_linear = time.time() - t_s

    t_s = time.time()
    best_rbf.fit(X_train, y_train)
    time_rbf = time.time() - t_s

    linear_pars = best_linear.get_params()
    rbs_pars = best_rbf.get_params()

    linear_vectors = best_linear.n_support_.sum()
    rbf_vectors = best_rbf.n_support_.sum()

    # resultado do treinamento
    
    linear_score = best_linear.score(X_test, y_test)
    rbf_score = best_rbf.score(X_test, y_test)

    # predicao do classificador
    y_pred_linear = best_linear.predict(X_test)
    y_pred_rbf = best_rbf.predict(X_test)

    # cria a matriz de confusao
    #cm = confusion_matrix(y_test, y_pred)
    #print( cm )

    # probabilidades
    #probs = best.predict_proba(X_test)

    #print probs

    return pd.DataFrame( {"Tempo Grid Search Linear": [time_linear_grid],
                          "Tempo Grid Search RBF": [time_rbf_grid],
                          "Tempo treino Linear": [time_linear],
                          "Tempo treino RBF": [time_rbf],
                          "Score Train Linear": [linear_score],
                          "Score Train RBF": [rbf_score],                          
                          "Parametros Linear": [linear_pars],
                          "Parametros RBS": [rbs_pars] ,
                          "Qtd vetores Linear": [linear_vectors] ,
                          "Qtd vetores RBS": [rbf_vectors] } )

if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("Use: svm.py <tr> <ts>")
        
    df = main(sys.argv[1], sys.argv[2])
    df.to_csv( "resultado_svm.csv", index=False)
