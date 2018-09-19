import pandas as pd
import numpy as np
from scipy.spatial import distance as dst
import sys


def knn( obs, k, df, features, target):
    df_train = df.copy()
    df_train['distance'] = np.apply_along_axis( dst.euclidean, 1, df_train[features], obs)
    df_train.sort_values(by='distance', ascending=False, inplace=True)
    return df_train.head(k)[target].value_counts().idxmax()

if __name__ == '__main__':
    _, path, features, target, obs, k = sys.argv
    features = features.split(',')
    df = pd.read_csv(path)
    obs = obs.split(',')
    print('Label:' , knn( k, df, features, target, obs) )
