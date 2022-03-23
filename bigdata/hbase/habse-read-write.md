# Hbase读和写
HBase采用LSM树架构，天生适用于写多读少的应用场景。在真实生产线环境中，也正是因为HBase集群出色的写入能力，才能支持当下很多数据激增的业务。需要说明的是，HBase服务端并没有提供update、delete接口，HBase中对数据的更新、删除操作在服务器端也认为是写入操作，不同的是，更新操作会写入一个最新版本数据，删除操作会写入一条标记为deleted的KV数据。所以HBase中更新、删除操作的流程与写入流程完全一致。


## 写入流程

1）客户端处理阶段：客户端将用户的写入请求进行预处理，并根据集群元数据定位写入数据所在的RegionServer，将请求发送给对应的RegionServer。

2）Region写入阶段：RegionServer接收到写入请求之后将数据解析出来，首先写入WAL(Write-Ahead-Log)，再写入对应Region列簇的MemStore。

3）MemStore Flush阶段：当Region中MemStore容量超过一定阈值，系统会异步执行flush操作，将内存中的数据写入文件，形成HFile


### BulkLoad
1）HFile生成阶段。这个阶段会运行一个MapReduce任务，MapReduce的mapper需要自己实现，将HDFS文件中的数据读出来组装成一个复合KV，其中Key是rowkey，Value可以是KeyValue对象、Put对象甚至Delete对象；MapReduce的reducer由HBase负责，通过方法HFileOutputFormat2.configureIncrementalLoad()进行配置。

2）HFile导入阶段。HFile准备就绪之后，就可以使用工具completebulkload将HFile加载到在线HBase集群。

##  读取流程

1、客户端首先会根据配置文件中zookeeper地址连接zookeeper，获取存储HBase元数据（hbase:meta）表所在的RegionServer地址。

2、根据hbase:meta所在RegionServer的访问信息，客户端会将该元数据表加载到本地并进行缓存。然后在表中确定待检索rowkey所在的RegionServer信息。

3、根据数据所在RegionServer的访问信息，客户端会向该RegionServer发送真正的数据读取请求。


