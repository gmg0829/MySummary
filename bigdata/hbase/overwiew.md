# HBase概述
HBase是目前非常热门的一款分布式KV（KeyValue，键值）数据库系统，无论是互联网行业还是其他传统IT行业都在大量使用。HBase从2010年开始前前后后经历了几十个版本的升级，不断地对读写性能、系统可用性以及稳定性等方面进行改进。
## 逻辑视图

- table：表，一个表包含多行数据。
- row：行，一行数据包含一个唯一标识rowkey、多个column以及对应的值。在HBase中，一张表中所有row都按照rowkey的字典序由小到大排序。
-  column：列，与关系型数据库中的列不同，HBase中的column由column family（列簇）以及qualif ier（列名）两部分组成，两者中间使用":"相连。比如contents:html，其中contents为列簇，html为列簇下具体的一列。columnfamily在表创建的时候需要指定，用户不能随意增减。一个column family下可以设置任意多个qualif ier，因此可以理解为HBase中的列可以动态增加，理论上甚至可以扩展到上百万列。
- timestamp：时间戳，每个cell在写入HBase的时候都会默认分配一个时间戳作为该cell的版本，当然，用户也可以在写入的时候自带时间戳。HBase支持多版本特性，即同一rowkey、column下可以有多个value存在，这些value使用timestamp作为版本号，版本越大，表示数据越新。
- cell：单元格，由五元组（row, column, timestamp,type, value）组成的结构，其中type表示Put/Delete这样的操作类型，timestamp代表这个cell的版本。这个结构在数据库中实际是以KV结构存储的，其中（row, column,timestamp, type）是K，value字段对应KV结构的V。
## 体系架构
![啡海报](
  ./hbase-overview.png)
### ZooKeeper

- 实现Master高可用：通常情况下系统中只有一个Master工作，一旦Active Master由于异常宕机，ZooKeeper会检测到该宕机事件，并通过一定机制选举出新的Master，保证系统正常运转。
- 管理系统核心元数据：比如，管理当前系统中正常工作的RegionServer集合，保存系统元数据表hbase:meta所在的RegionServer地址等。
- 参与RegionServer宕机恢复：ZooKeeper通过心跳可以感知到RegionServer是否宕机，并在宕机后通知Master进行宕机处
- 实现分布式表锁：HBase中对一张表进行各种管理操作（比如alter操作）需要先加表锁，防止其他用户对同一张表进行管理操作，造成表状态不一致。和其他RDBMS表不同，HBase中的表通常都是分布式存储，ZooKeeper可以通过特定机制实现分布式表锁。

### Master
- 处理用户的各种管理请求，包括建表、修改表、权限操作、切分表、合并数据分片以及Compaction等。
- 管理集群中所有RegionServer，包括RegionServer中Region的负载均衡、RegionServer的宕机恢复以及Region的迁移等。
- 清理过期日志以及文件，Master会每隔一段时间检查HDFS中HLog是否过期、HFile是否已经被删除，并在过期之后将其删除。

### RegionServer
RegionServer主要用来响应用户的IO请求，是HBase中最核心的模块，由WAL(HLog)、BlockCache以及多个Region构成。
- WAL(HLog)：HLog在HBase中有两个核心作用——其一，用于实现数据的高可靠性，HBase数据随机写入时，并非直接写入HFile数据文件，而是先写入缓存，再异步刷新落盘。为了防止缓存数据丢失，数据写入缓存之前需要首先顺序写入HLog，这样，即使缓存数据丢失，仍然可以通过HLog日志恢复；其二，用于实现HBase集群间主从复制，通过回放主集群推送过来的HLog日志实现主从复制。
- BlockCache：HBase系统中的读缓存。客户端从磁盘读取数据之后通常会将数据缓存到系统内存中，后续访问同一行数据可以直接从内存中获取而不需要访问磁盘。
- Region：数据表的一个分片，当数据表大小超过一定阈值就会“水平切分”，分裂为两个Region。Region是集群负载均衡的基本单位。通常一张表的Region会分布在整个集群的多台RegionServer上，一个RegionServer上会管理多个Region，当然，这些Region一般来自不同的数据表。
### HDFS
HBase底层依赖HDFS组件存储实际数据，包括用户数据文件、HLog日志文件等最终都会写入HDFS落盘。HDFS是Hadoop生态圈内最成熟的组件之一，数据默认三副本存储策略可以有效保证数据的高可靠性。HBase内部封装了一个名为DFSClient的HDFS客户端组件，负责对HDFS的实际数据进行读写访问。

## 参考
Hbase原理与实践
