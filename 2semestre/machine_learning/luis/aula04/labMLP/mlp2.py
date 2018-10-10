import numpy as np
import pandas
import keras
from keras.models import Sequential
from keras.layers import Dense, Dropout
from sklearn.datasets import load_svmlight_file
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt

X_train, y_train = load_svmlight_file('IMDB/train.txt')
X_test, y_test = load_svmlight_file('IMDB/test.txt')

## save for the confusion matrix
label = y_test

## converts the labels to a categorical one-hot-vector
y_train = keras.utils.to_categorical(y_train, num_classes=2)
y_test = keras.utils.to_categorical(y_test, num_classes=2)

model = Sequential()
# Dense(50) is a fully-connected layer with 50 hidden units.
# in the first layer, you must specify the expected input data shape:
# here, 100-dimensional vectors.
model.add(Dense(10, activation='relu', input_dim=200))
model.add(Dense(200, activation='relu'))
#model.add(Dense(300, activation='relu'))
#model.add(Dense(200, activation='relu'))
#model.add(Dense(100, activation='relu'))
model.add(Dense(2, activation='sigmoid'))
model.add( Dropout(0.1) )
model.compile(loss='binary_crossentropy', optimizer='rmsprop', metrics=['accuracy'])

history = model.fit(X_train, y_train, validation_split=0.33, epochs=200, batch_size=10)

score = model.evaluate(X_test, y_test, batch_size=128)
print (score)

y_pred = model.predict_classes(X_test)

cm = confusion_matrix(label, y_pred)
print(cm)

# list all data in history
print(history.history.keys())
# summarize history for accuracy
plt.plot(history.history['acc'])
plt.plot(history.history['val_acc'])
plt.title('model accuracy')
plt.ylabel('accuracy')
plt.xlabel('epoch')
plt.legend(['train', 'test'], loc='upper left')
plt.show()

