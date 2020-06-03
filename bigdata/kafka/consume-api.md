## 订阅主题的全部分区
```
 String[] topics = new String[]{"dev3-yangyunhe-topic001", "dev3-yangyunhe-topic002"};

    // 订阅指定主题的全部分区
    consumer.subscribe(Arrays.asList(topics));

    try {
        while (true) {
            /*
                * poll() 方法返回一个记录列表。
                * 每条记录都包含了记录所属主题的信息、记录所在分区的信息、记录在分区里的偏移量，以及记录的键值对。
                * 我们一般会遍历这个列表，逐条处理这些记录。
                * 传给poll() 方法的参数是一个超时时间，用于控制 poll() 方法的阻塞时间（在消费者的缓冲区里没有可用数据时会发生阻塞）。
                * 如果该参数被设为 0，poll() 会立即返回，否则它会在指定的毫秒数内一直等待 broker 返回数据。
                * 而在经过了指定的时间后，即使还是没有获取到数据，poll()也会返回结果。
                */
            ConsumerRecords<String, String> records = consumer.poll(1000);
            for (ConsumerRecord<String, String> record : records) {
                System.out.println("topic = " + record.topic() + ", partition = " + record.partition());
            }
        }
    } finally {
        /*
            * 在退出应用程序之前使用 close() 方法关闭消费者。
            * 网络连接和 socket 也会随之关闭，并立即触发一次再均衡，而不是等待群组协调器发现它不再发送心跳并认定它已死亡，
            * 因为那样需要更长的时间，导致整个群组在一段时间内无法读取消息。
            */
        consumer.close();
    }
```

## 用正则表达式来订阅主题的全部分区
```
// 订阅所有以"dev3"开头的主题的全部分区
Pattern pattern = Pattern.compile("dev3.*");
consumer.subscribe(pattern, new ConsumerRebalanceListener() {

    @Override
    public void onPartitionsRevoked(Collection<TopicPartition> arg0) {
        // TODO nothing：再均衡监听器会在之后的文章中进行讨论
    }

    @Override
    public void onPartitionsAssigned(Collection<TopicPartition> arg0) {
        // TODO nothing：再均衡监听器会在之后的文章中进行讨论
    }
});

```

## 订阅指定的分区
```
KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);

TopicPartition[] topicPartitions = new TopicPartition[]{
        new TopicPartition("dev3-yangyunhe-topic001", 0),
        new TopicPartition("dev3-yangyunhe-topic002", 1)
};

// 订阅"dev3-yangyunhe-topic001"的分区0和"dev3-yangyunhe-topic002"的分区1
consumer.assign(Arrays.asList(topicPartitions));
```
### 消费者常用配置
- fetch.min.bytes 该属性指定了消费者从服务器获取记录的最小字节数。broker 在收到消费者的数据请求时，如果可用的数据量小于 fetch.min.bytes 指定的大小，那么它会等到有足够的可用数据时才把它返回给消费者。
- fetch.max.wait.ms 用于指定 broker 的等待时间，默认是如果没有足够的数据流入Kafka，消费者获取最小数据量的要求就得不到满足，最终导致 500ms 的延迟。
- max.partition.fetch.bytes 该属性指定了服务器从每个分区里返回给消费者的最大字节数。它的默认值是 1MB。
- session.timeout.ms 该属性指定了消费者在被认为死亡之前可以与服务器断开连接的时间，默认是 1s。如果消费者没有在 session.timeout.ms 指定的时间内发送心跳给群组协调器，就被认为已经死亡，组协调器就会触发再均衡，把它的分区分配给群组里的其他消费者。
- auto.offset.reset 该属性指定了消费者在读取一个没有偏移量的分区或者偏移量无效的情况下（因消费者长时间失效，包含偏移量的记录已经过时并被删除）该作何处理。它的默认值是 latest，意思是说，在偏移量无效的情况下，消费者将从最新的记录开始读取数据（在消费者启动之后生成的记录）。另一个值是 earliest，意思是说，在偏移量无效的情况下，消费者将从起始位置读取分区的记录。none 则代表当偏移量失效后，直接抛出异常。
- enable.auto.commit  该属性指定了消费者是否自动提交偏移量，默认值是 true。为了尽量避免出现重复数据和数据丢失，可以把它设为 false，由自己控制何时提交偏移量。如果把它设为 true，还可以通过配置 auto.commit.interval.ms 属性来控制提交的频率。
- max.poll.records 该属性用于控制单次调用 poll() 方法最多能够返回的记录条数，可以帮你控制在轮询里需要处理的数据量。

##  链接
https://cloud.tencent.com/developer/article/1336567


