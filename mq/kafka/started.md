## Broker
一个Borker就是Kafka集群中的一个实例，或者说是一个服务单元。连接到同一个zookeeper的多个broker实例组成kafka的集群。在若干个broker中会有一个broker是leader，其余的broker为follower。leader在集群启动时候选举出来，负责和外部的通讯。当leader死掉的时候，follower们会再次通过选举，选择出新的leader，确保集群的正常工作。



## Consumer Group
Kafka和其它消息系统有一个不一样的设计，在consumer之上加了一层group。同一个group的consumer可以并行消费同一个topic的消息，但是同group的consumer，不会重复消费。这就好比多个consumer组成了一个团队，一起干活，当然干活的速度就上来了。group中的consumer是如何配合协调的，其实和topic的分区相关联，后面我们会详细论述。

如果同一个topic需要被多次消费，可以通过设立多个consumer group来实现。每个group分别消费，互不影响。




## Topic
kafka中消息订阅和发送都是基于某个topic。比如有个topic叫做NBA赛事信息，那么producer会把NBA赛事信息的消息发送到此topic下面。所有订阅此topic的consumer将会拉取到此topic下的消息。Topic就像一个特定主题的收件箱，producer往里丢，consumer取走。

### 2、Kafka核心概念简介
kafka采用分区（Partition）的方式，使得消费者能够做到并行消费，从而大大提高了自己的吞吐能力。同时为了实现高可用，每个分区又有若干份副本（Replica），这样在某个broker挂掉的情况下，数据不会丢失。

接下来我们详细分析kafka是如何基于Partition和Replica工作的。

### 分区（Partition）
大多数消息系统，同一个topic下的消息，存储在一个队列。分区的概念就是把这个队列划分为若干个小队列，每一个小队列就是一个分区，如下图：

![Partition](
  ./images/1.webp)

  ![Partition](
  ./images/2.webp)


### 副本（Replica）  
副本是正本的拷贝。在kafka中，正本和副本都称之为副本（Repalica），但存在leader和follower之分。活跃的称之为leader，其他的是follower。

每个分区的数据都会有多份副本，以此来保证Kafka的高可用。

Topic、partition、replica的关系如下图：

  ![Partition](
  ./images/3.webp)

topic下会划分多个partition，每个partition都有自己的replica，其中只有一个是leader replica，其余的是follower replica。

消息进来的时候会先存入leader replica，然后从leader replica复制到follower replica。只有复制全部完成时，consumer才可以消费此条消息。这是为了确保意外发生时，数据可以恢复。consumer的消费也是从leader replica读取的。

由此可见，leader replica做了大量的工作。所以如果不同partition的leader replica在kafka集群的broker上分布不均匀，就会造成负载不均衡。

## 参考：

https://mp.weixin.qq.com/s?__biz=MzU3MzgwNTU2Mg==&mid=100000472&idx=1&sn=99353b901d1174c3edd4a9ebbe394975&chksm=7d3d444d4a4acd5bf0017210f55ec394abda01d163674d540988ca94863a51411be951711553#rd

