## 常见问题

### RegionServer宕机
1、长时间GC导致RegionServer宕机
2、大字段scan导致RegionServer宕机
3、close_wait端口耗尽导致RegionServer宕机

### HBase写入异常
1、MemStore占用内存大小超过设定阈值导致写入阻塞
2、RegionServer Active Handler资源被耗尽导致写入阻塞
3、HDFS缩容导致部分写入异常

## 常见故障

HBase系统中主要有两类服务进程：Master进程以及RegionServer进程。Master主要负责集群管理调度，在实际生产线上并没有非常大的压力，因此发生软件层面故障的概率非常低。RegionServer主要负责用户的读写服务，进程中包含很多缓存组件以及与HDFS交互的组件，实际生产线上往往会有非常大的压力，进而造成的软件层面故障会比较多。

- Full GC异常：长时间的Full GC是导致RegionServer宕机的最主要原因，据不完全统计，80%以上的宕机原因都和JVM Full GC有关。导致JVM发生Full GC的原因有很多：HBase对于Java堆内内存管理的不完善，HBase未合理使用堆外内存，JVM启动参数设置不合理，业务写入或读取吞吐量太大，写入读取字段太大，等等。其中部分原因要归结于HBase系统本身，另一部分原因和用户业务以及HBase相关配置有关。

- HDFS异常：RegionServer写入读取数据都是直接操作HDFS的，如果HDFS发生异常会导致RegionServer直接宕机。


