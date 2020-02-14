# 机器学习模型之PMML
机器学习模型的应用一般会经历两个主要过程：离线开发和线上部署。

离线部分负责模型训练和导出模型，线上负责导入模型并且做预测。
![](
  ./pmml-process.jpg)
## PMML概述

PMML是数据挖掘的一种通用的规范，它用统一的XML格式来描述我们生成的机器学习模型。

要使用PMML，需要两步的工作，第一块是将离线训练得到的模型转化为PMML模型文件，第二块是将PMML模型文件载入在线预测环境，进行预测。这两块都需要相关的库支持。

##  PMML模型的生成和加载相关类库

PMML模型的生成相关的库需要看我们使用的离线训练库。如果我们使用的是sklearn，那么可以使用sklearn2pmml这个python库来做模型文件的生成。

加载PMML模型需要目标环境支持PMML加载的库，如果是JAVA，则可以用JPMML来加载PMML模型文件。


## PMML总结与思考
- PMML为了满足跨平台，牺牲了很多平台独有的优化，所以很多时候我们用算法库自己的保存模型的API得到的模型文件，要比生成的PMML模型文件小很多。同时PMML文件加载速度也比算法库自己独有格式的模型文件加载慢很多。

- PMML加载得到的模型和算法库自己独有的模型相比，预测会有一点点的偏差，当然这个偏差并不大。比如某一个样本，用sklearn的决策树模型预测为类别1，但是如果我们把这个决策树落盘为一个PMML文件，并用JAVA加载后，继续预测刚才这个样本，有较小的概率出现预测的结果不为类别1.

- 对于超大模型，比如大规模的集成学习模型，比如xgboost, 随机森林，或者tensorflow，生成的PMML文件很容易得到几个G，甚至上T，这时使用PMML文件加载预测速度会非常慢，此时推荐为模型建立一个专有的环境，就没有必要去考虑跨平台了。

## 参考

https://www.cnblogs.com/pinard/p/9220199.html

https://zhuanlan.zhihu.com/p/30378213

1、 调研PMML，github提供了一些模型文件(支持sklearn、xgboost、lgb、sparkml)转为pmml和Java载入pmml的library。
2、 实战做了个小demo,github链接为(http://gitlab.corp.elensdata.com/AML/pmml_example)。
3、 对于复杂大规模的集成学习模型，生成的PMML文件比较大，这时使用PMML文件加载预测速度会非常慢。