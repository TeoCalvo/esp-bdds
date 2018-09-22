import sys
import numpy as np
from sklearn.model_selection import GridSearchCV
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.datasets import load_svmlight_file
from sklearn import preprocessing
import pylab as pl

data = '../features.txt'

X_data, y_data = load_svmlight_file(data)
X_train, X_test, y_train, y_test =  train_test_split(X_data, y_data, test_size=0.5, random_state = 5)

X_train = X_train.toarray()
X_test = X_test.toarray()


neigh = KNeighborsClassifier()
params = {
        'metric': ('euclidean', 'manhattan'),
        'n_neighbors': [3,4,5,6,7,8,9,10]
}

clf = GridSearchCV(estimator=neigh, param_grid=params, verbose=True, cv=3)

clf.fit( X_data, y_data )

