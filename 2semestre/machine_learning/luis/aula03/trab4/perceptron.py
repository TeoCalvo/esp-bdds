#!/usr/bin/python
# -*- encoding: iso-8859-1 -*-

import sys
import numpy as np
import time
import matplotlib.pyplot as plt

from sklearn.metrics import confusion_matrix 
from sklearn.datasets import load_svmlight_file

from sklearn.linear_model import Perceptron
from sklearn.model_selection import cross_val_score
from sklearn.datasets import load_svmlight_file, make_classification


def main(X_train, y_train, X_test, y_test, ite, history):

	# loads data
	#print "Loading data..."
	#X_train, y_train = load_svmlight_file(tr)
	#X_test, y_test = load_svmlight_file(ts)
	X_train_dense = X_train.toarray()
	X_test_dense = X_test.toarray()
	
	
	clf = Perceptron(max_iter=ite)
	clf.fit(X_train_dense, y_train)
		
	y_pred = clf.predict(X_test_dense) 
	
	# mostra o resultado do classificador na base de teste
	history.append(clf.score(X_test_dense, y_test))


	# cria a matriz de confusao
	cm = confusion_matrix(y_test, y_pred)
	print history[0]
	print cm

	#print y_predProb

if __name__ == "__main__":
	if len(sys.argv) != 3:
		sys.exit("Use: perceptron.py <dataTR> <dataTS> <ite>")

	# loads data
	print ("Loading data...")
	X_train, y_train = load_svmlight_file(sys.argv[1])
	X_test, y_test = load_svmlight_file(sys.argv[2])
	size = X_train.shape
        ite = int( sys.argv[3]

	history = []
	print('Fitting...')
	start_time = time.time()
	main(X_train, y_train, X_test, y_test, ite, history )
	print("--- %s seconds ---" % (time.time() - start_time))
	arq = open('perceptron.txt', 'w' )	


