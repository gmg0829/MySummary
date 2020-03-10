##
mvn archetype:generate -DarchetypeGroupId=org.apache.flink -DarchetypeArtifactId=flink-quickstart-java -DarchetypeVersion=1.7.0 -DgroupId=FlinkLearning -DartifactId=FlinkLearning -Dversion=0.1 -Dpackage=com.gmg -DinteractiveMode=false
## 部署方式
- Local本地部署
- Standalone Cluster集群部署
- Flink ON YARN
## 时间窗口
tumbling time windows(翻滚时间窗口)
sliding time windows(滑动时间窗口) 
## 计数窗口
tumbling count window
sliding count window
## 会话窗口
当它在一个固定的时间周期内不再收到元素，即非活动间隔产生，那个这个窗口就会关闭。
## 触发器
触发器决定了一个窗口何时可以被窗口函数处理，每一个窗口分配器都有一个默认的触发器，如果默认的触发器不能满足你的需要，你可以通过调用trigger(...)来自定义的一个触发器。
- EventTimeTrigger(前面提到过)：触发是基于事件时间用水印来衡量进展的。
- ProcessingTimeTrigger： 根据处理时间来触发
- CountTrigger ：一旦窗口中的元素个数超出了给定的限制就会触发
- PurgingTrigger：将另一个触发器作为参数，并将其转换为清除触发器。
## 驱逐器（Evictors）
这个驱逐器(evitor)可以在触发器触发之前或者之后，或者窗口函数被应用之前清理窗口中的元素。
- CountEvictor：在窗口中保留用户指定的元素数量，并丢弃窗口缓冲区开头的剩余元素。
- DeltaEvictor：通过DeltaFunction 和阈值，计算窗口缓冲区中最后一个元素和每个剩余元素之间的delta值，并清除delta值大于或者等于阈值的元素
- TimeEvitor：使用一个interval的毫秒数作为参数，对于一个给定的窗口，它会找出元素中的最大时间戳max_ts，并清除时间戳小于max_tx - interval的元素。
## Watermark
- Punctuated Watermark：数据流中每一个递增的 EventTime 都会产生一个 Watermark。
- PeriodicWatermarks：周期性（一定时间间隔或者达到一定的记录条数）生成水印。

## 通过 -d 表示后台执行
/opt/flink/bin/flink run -p 1 -c com.test.TestLocal -d ./flink-streaming-report-forms-1.0-SNAPSHOT-jar-with-dependencies.jar 

```
-c,--class <classname> : 需要指定的main方法的类

-C,--classpath <url> : 向每个用户代码添加url，他是通过UrlClassLoader加载。url需要指定文件的schema如（file://）

-d,--detached : 在后台运行

-p,--parallelism <parallelism> : job需要指定env的并行度，这个一般都需要设置。

-q,--sysoutLogging : 禁止logging输出作为标准输出。

-s,--fromSavepoint <savepointPath> : 基于savepoint保存下来的路径，进行恢复。

-sas,--shutdownOnAttachedExit : 如果是前台的方式提交，当客户端中断，集群执行的job任务也会shutdown。

```
nc -L -p 9000

## rest api
http://192.168.1.177:8081/v1/jobs/78dd81804d9342ea41871564cf9dc6b5

http://192.168.1.177:8081/v1/jobs/78dd81804d9342ea41871564cf9dc6b5/vertices/cbc357ccb763df2852fee8c4fc7d55f2/subtasks/metrics?get=numRecordsOutPerSecond,numBytesOutPerSecond
