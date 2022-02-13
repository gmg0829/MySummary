# -*- coding:utf-8 -*-
import numpy as np
from sklearn.cluster import KMeans
from sklearn import preprocessing
import pandas as pd

# 加载数据
df = pd.read_excel('titanic.xls')
df.drop(['body', 'name', 'ticket'], 1, inplace=True)
df.fillna(0, inplace=True)  # 把NaN替换为0

# 把字符串映射为数字，例如{female:1, male:0}
df_map = {}
cols = df.columns.values
for col in cols:
    if df[col].dtype != np.int64 and df[col].dtype != np.float64:
        temp = {}
        x = 0
        for ele in set(df[col].values.tolist()):
            if ele not in temp:
                temp[ele] = x
                x += 1

        df_map[df[col].name] = temp
        df[col] = list(map(lambda val: temp[val], df[col]))

# 将每一列特征标准化为标准正太分布
x = np.array(df.drop(['survived'], 1).astype(float))
x = preprocessing.scale(x)
clf = KMeans(n_clusters=2)
clf.fit(x)

# 计算分组准确率
y = np.array(df['survived'])
correct = 0
for i in range(len(x)):
    predict_data = np.array(x[i].astype(float))
    predict_data = predict_data.reshape(-1, len(predict_data))
    predict = clf.predict(predict_data)
    if predict[0] == y[i]:
        correct += 1

print(correct * 1.0 / len(x))