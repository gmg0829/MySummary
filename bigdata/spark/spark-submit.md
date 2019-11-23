## spark-submit 提交python外部依赖包

```
spark-submit \
--queue 公司队列 \
--conf 'spark.scheduler.executorTaskBlacklistTime=30000' \
--driver-memory 10g  \
--executor-memory 12g   \
--conf spark.yarn.executor.memoryOverhead=3000 \
--conf spark.dynamicAllocation.maxExecutors=700  \
--conf spark.network.timeout=240s  \
--conf spark.dynamicAllocation.enabled=true \
--conf spark.executor.cores=2 \
--conf "spark.pyspark.driver.python=/home/uther/miniconda2/envs/uther/bin/python3.7" \
--conf "spark.pyspark.python=/home/uther/miniconda2/envs/uther/bin/python3.7" \
--py-files='spark_submit.zip' \  -- 注意填写自己的绝对路径
test.py  --填写绝对路径

```

## spark-submit提交jar
```
spark-submit \
  --class "Excellent" \
  --master yarn \
  --deploy-mode cluster \
  --driver-memory 2g \
  --executor-memory 2g \
  --executor-cores 1 \
  /home/zhizhizhi/sparktry_2.11-0.1.jar \
  para1 \      
  para2 \     
  "test sql" \   
  parax    
```