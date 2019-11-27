## sklearn入门
scikit-learn 是基于 Python 语言的机器学习工具

- 简单高效的数据挖掘和数据分析工具
- 可供大家在各种环境中重复使用
- 建立在 NumPy ，SciPy 和 matplotlib 上

### 安装
```
pip install -U scikit-learn
conda install scikit-learn
```
### 常用模块

sklearn中常用的模块有分类、回归、聚类、降维、模型选择、预处理。

- 分类：识别某个对象属于哪个类别，常用的算法有：SVM（支持向量机）、nearest neighbors（最近邻）、random forest（随机森林），常见的应用有：垃圾邮件识别、图像识别。

- 回归：预测与对象相关联的连续值属性，常见的算法有：SVR（支持向量机）、 ridge regression（岭回归）、Lasso，常见的应用有：药物反应，预测股价。

- 聚类：将相似对象自动分组，常用的算法有：k-Means、 spectral clustering、mean-shift，常见的应用有：客户细分，分组实验结果。

- 降维：减少要考虑的随机变量的数量，常见的算法有：PCA（主成分分析）、feature selection（特征选择）、non-negative matrix factorization（非负矩阵分解），常见的应用有：可视化，提高效率。

- 模型选择：比较，验证，选择参数和模型，常用的模块有：grid search（网格搜索）、cross validation（交叉验证）、 metrics（度量）。它的目标是通过参数调整提高精度。

- 预处理：特征提取和归一化，常用的模块有：preprocessing，feature extraction，常见的应用有：把输入数据（如文本）转换为机器学习算法可用的数据。
![](
  ./img/ml_map.png)

## demo
https://www.cnblogs.com/wj-1314/p/10179741.html