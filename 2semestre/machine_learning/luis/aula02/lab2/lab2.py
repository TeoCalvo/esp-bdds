import sys
import numpy as np
import time

from sklearn import linear_model
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis

from sklearn.metrics import confusion_matrix 
from sklearn.datasets import load_svmlight_file

from sklearn.naive_bayes import BernoulliNB
from sklearn.naive_bayes import GaussianNB
from sklearn.naive_bayes import MultinomialNB 

def main(X_train, y_train, X_test, y_test, history, name):

    # loads data
    #print "Loading data..."
    #X_train, y_train = load_svmlight_file(tr)
    #X_test, y_test = load_svmlight_file(ts)
    
    # cria o classificador
    if name == 'knn':
        clf = KNeighborsClassifier(n_neighbors=3, metric='euclidean')
    elif name =='logist':
        clf = linear_model.LogisticRegression() 
    elif name == 'nb':
        clf = GaussianNB()
    else:
        clf = LinearDiscriminantAnalysis()
    
    X_train_dense = X_train.toarray()
    clf.fit(X_train_dense, y_train)

    X_test_dense = X_test.toarray()
    y_pred = clf.predict(X_test_dense) 
    
    # mostra o resultado do classificador na base de teste
    history.append(clf.score(X_test_dense, y_test))

    # cria a matriz de confusao
    cm = confusion_matrix(y_test, y_pred)
    print(name,':\n',cm)

    #print y_predProb

if __name__ == "__main__":
    if len(sys.argv) != 4:
        sys.exit("Use: lda.py <dataTR> <dataTS> <name>")

    # loads data
    print("Loading data...")
    X_train, y_train = load_svmlight_file(sys.argv[1])
    X_test, y_test = load_svmlight_file(sys.argv[2])
    name = sys.argv[3]
    size = X_train.shape
    batchsize = 500
    ini = 0
    end = batchsize
    history, duration = [], []
    while(end <= size[0] ):
        xt = X_train[0:end]
        yt = y_train[0:end]
        print ("Training size... ", end)     
        start_time = time.time()
        main(xt, yt, X_test, y_test, history, name)
        duration.append( time.time() - start_time ) 
        print("--- %s seconds ---" % (duration[-1]))
        end = end + batchsize
        print(history)
        arq = open(name+'.txt', 'w')
        arq.write('performance;tempo\n')
        for i in range(len(history)):
            arq.write( str(history[i])+ ';' + str(duration[i])  + '\n') 
        arq.close()

