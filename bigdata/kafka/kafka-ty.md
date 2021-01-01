## 性能调优

## JVM的优化
一般HEAP SIZE的大小不超过主机内存的50%

vim bin/kafka-server-start.sh     
调整KAFKA_HEAP_OPTS="-Xmx16G -Xms16G”的值

## 网络和io操作线程配置优化：

broker处理消息的最大线程数
num.network.threads=9
broker处理磁盘IO的线程数
num.io.threads=16

## socket server可接受数据大小(防止OOM异常)：
socket.request.max.bytes=2147483600

## log数据文件刷盘策略
为了大幅度提高producer写入吞吐量，需要定期批量写文件。

每当producer写入10000条消息时，刷数据到磁盘
log.flush.interval.messages=10000
每间隔1秒钟时间，刷数据到磁盘
log.flush.interval.ms=1000

## 日志保留策略配置
日志保留时长
log.retention.hours=72
段文件配置
log.segment.bytes=1073741824

## replica复制配置
每个follow从leader拉取消息进行同步数据，follow同步性能由这几个参数决定，分别为:

拉取线程数(num.replica.fetchers)
num.replica.fetchers=3
最小字节数
replica.fetch.min.bytes=1
最大字节数(replica.fetch.max.bytes)：默认为1MB，这个值太小，推荐5M，根据业务情况调整
replica.fetch.max.bytes=5242880
最大等待时间
replica.fetch.wait.max.ms

## 分区数量配置
num.partitions=5

## 参数调优
吞吐量优先、延时优先、可靠性优先以及可用性优先。

### Producer优化
- batch.size 设置每次批量提交消息的最大字节数，一旦待批量发送的消息的大小超过这个字节数，这些消息将被批量发送出去
- linger.ms 该参数会影响延时，因为消息不是立即发送的，而是需要等待发送的消息大小超过batch.size或者收集消息的等待时间超过linger.ms才会发送消息
- compression.type 将待发送的多个消息压缩成一个消息，因此和batch.size一起使用，batch.size越大，压缩率越高，吞吐量越大。支持3种压缩类型：lz4、snappy和gzip。[lz4能使吞吐量最优][1]
- acks 	acks=1表示leader broker收到消息后就返回ack，而无需等所有的followers都确认收到消息。存在丢失消息的风险
- buffer.memory 分配给producer的内存，用于存储还未发送到broker的消息。如果分区比较多，那么设置的值也需要更大
- max.block.ms 定义被阻塞的时间；当buffer.memory达到上限时，再次发送消息时会被阻塞。当阻塞时间超过max.block.ms时，producer将会抛出异常
- max.request.size  定义每条消息的最大字节数。
- request.timeout.ms 客户端等待请求的最大响应时间；如果设置了重试次数，超过这个时间，客户端将会重试。

### Consumer优化
- fetch.min.bytes 定义从broker获取消息的最小字节数。只有大于这个值时，consumer才会拉取到消息，否则会等待到超时。这个值越大，从broker获取消息的次数越少，会减轻broker的CPU压力；但会影响延时
- fetch.max.wait.ms	 	达到fetch.min.bytes或者超过fetch.max.wait.ms时，才会消费消息
- auto.commit.enable  通过显式调用commitSync()或者commitAsync()手动确认消息被消费。消费者是通过更新offsets来表明offsets之前的消息已经被消费了；当消费者的poll()执行完时，会自动commit offsets。但是如果poll作为业务事务中的一部分的时候，为了保证可靠性，必须在事务提交之后才能提交offsets，所以需要将auto.commit.enable=false，并且显示地调用commitSync() or commitAsync()




# 链接
https://nereuschen.github.io/2016/08/08/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3Kafka%E8%B0%83%E4%BC%98%E7%9A%84%E6%A0%B8%E5%BF%83%E5%8F%82%E6%95%B0/


