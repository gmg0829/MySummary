## Scikit-learn模型序列化方法：
PMML：Nyoka，SkLearn2PMML
ONNX：sklearn-onnx, 或者ONNXMLTools包装了sklearn-onnx
MLeap
Pickle 或者 Joblib

## XGBoost模型序列化方法：
XGBoost自定义二进制格式，该格式是一种与语言和平台无关的内部通用格式。
xgboost.Booster.save_model
xgboost.Booster.load_model
PMML：Nyoka，SkLearn2PMML
ONNX：ONNXMLTools
Pickle 或者 Joblib（使用Python API）

## LightGBM模型序列化方式：
- LightGBM自定义格式：文本文件或者字符串。
    - lightgbm.Booster.save_model
    - lightgbm.Booster.model_to_string
    - 构造函数导入模型 lightgbm.Booster
- PMML：Nyoka，SkLearn2PMML
- ONNX：ONNXMLTools
- Pickle 或者 Joblib（使用Python API）
## Spark-ML模型序列化方式
- Spark-ML内部存储格式，PipelineModel提供save和load方法，输入的是一个路径，而不是文件名，因为要存储到多个不同的文件中。Spark在大数据的分布式处理有很大优势，比如适合批量预测和模型评估，但是对于实时预测来说，太重量级了，效率不高。提供Scala，Java和Python接口，可以跨平台和语言读取。
- PMML：JPMML-SparkML
- ONNX：ONNXMLTools，还在实验阶段。
- PFA：Aardpfark，支持还不完全。
- MLeap





