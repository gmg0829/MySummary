## 优化
### HBase读取性能优化
#### HBase服务器端优化
- 读请求是否均衡
Rowkey必须进行散列化处理（比如MD5散列），同时建表必须进行预分区处理。
- BlockCache设置是否合理？
默认情况下BlockCache和MemStore的配置相对比较均衡（各占40%），可以根据集群业务进行修正，比如读多写少业务可以将BlockCache占比调大。
-  HFile文件是否太多
HBase在读取数据时通常先到MemStore和BlockCache中检索（读取最近写入数据和热点数据），如果查找不到则到文件中检索。
hbase.hstore.compactionThreshold设置不能太大，默认为3个。
- Compaction是否消耗系统资源过多
Compaction是将小文件合并为大文件，提高后续业务随机读性能，但是也会带来IO放大以及带宽消耗问题（数据远程读取以及三副本写入都会消耗系统带宽）。

####  HBase客户端优化
- scan缓存是否设置合理
HBase业务通常一次scan就会返回大量数据，因此客户端发起一次scan请求，实际并不会一次就将所有数据加载到本地，而是分成多次RPC请求进行加载，这样设计一方面因为大量数据请求可能会导致网络带宽严重消耗进而影响其他业务，另一方面因为数据量太大可能导致本地客户端发生OOM。大scan场景下将scan缓存从100增大到500或者1000，用以减少RPC次数。
- get是否使用批量请求
使用批量get进行读取请求。需要注意的是，对读取延迟非常敏感的业务，批量请求时每次批量数不能太大。
- 请求是否可以显式指定列簇或者列
尽量指定列簇或者列进行精确查找
-离线批量读取请求是否设置禁止缓存
常在离线批量读取数据时会进行一次性全表扫描，一方面数据量很大，另一方面请求只会执行一次。这种场景下如果使用scan默认设置，就会将数据从HDFS加载出来放到缓存。离线批量读取请求设置禁用缓存，scan.setCacheBlocks (false)。

### HBase写入性能调优
#### HBase服务端优化
-  Region是否太少
当前集群中表的Region个数如果小于RegionServer个数，即Num (Region of Table) < Num (RegionServer)，可以考虑切分Region并尽可能分布到不同的RegionServer上以提高系统请求并发度。

- 写入请求是否均衡
检查Rowkey设计以及预分区策略，保证写入请求均衡。
#### HBase客户端优化
- 是否可以使用Bulkload方案写入
Bulkload是一个MapReduce程序，运行在Hadoop集群。程序的输入是指定数据源，输出是HFile文件。HFile文件生成之后再通过LoadIncrementalHFiles工具将HFile中相关元数据加载到HBase中。
- Put是否可以同步批量提交
- Put是否可以异步批量提交
在业务可以接受的情况下开启异步批量提交，用户可以设置setAutoFlush (false)
- 写入KeyValue数据是否太大
KeyValue大小对写入性能的影响巨大。一旦遇到写入性能比较差的情况，需要分析写入性能下降是否因为写入KeyValue的数据太大。

