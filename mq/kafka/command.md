
## Kafka常用命令
1.创建topic

./kafka-topics.sh --create --topic test1 --replication-factor 2 --partitions 3 --zookeeper hbp001:2181

2.增加partition

./kafka-topics.sh --zookeeper node01:2181 --alter --topic t_cdr --partitions 10

3.查看所有topic列表

./kafka-topics.sh --zookeeper hbp201:2181 –list

4.查看指定topic信息

./kafka-topics.sh --zookeeper hbp201:2181 --describe --topic t_cdr

5.控制台向topic生产数据

./kafka-console-producer.sh --broker-list node86:9092 --topic t_cdr

6.控制台消费topic的数据

./kafka-console-consumer.sh -zookeeper hdh247:2181 --from-beginning --topic fieldcompact

7.查看topic某分区偏移量最大（小）值

./kafka-run-class.sh kafka.tools.GetOffsetShell --topic hive-mdatabase-hostsltable --time -1 --broker-list node86:9092 --partitions 0
注： time为-1时表示最大值，time为-2时表示最小值

8.增加topic分区数

为topic t_cdr 增加到10个分区
./kafka-topics.sh --zookeeper hbp201:2181 --alter --topic t_cdr --partitions 10

9.删除topic

慎用，只会删除zookeeper中的元数据，消息文件须手动删除
./kafka-run-class.sh kafka.admin.DeleteTopicCommand --zookeeper hbp201:2181 --topic t_cdr

10.查看consumer组内消费的offset

./kafka-run-class.sh kafka.tools.ConsumerOffsetChecker --zookeeper localhost:2181 --group test --topic testKJ1
 ./kafka-consumer-offset-checker.sh --zookeeper 192.168.0.201:2181 --group group1 --topic group1

11.查看kafka某分区日志具体内容

./kafka-run-class.sh kafka.tools.DumpLogSegments -files /tmp/kafka-logs/test3-0/00000000000000000000.log  -print-data-log  

12.获取正在消费的topic的group的offset

./kafka-consumer-groups.sh --new-consumer --describe --group test6 --bootstrap-server hbp201:9092

13.显示消费者

./kafka-consumer-groups.sh --bootstrap-server hdh56:9092,hdh57:9092,hdh58:9092 --list --new-consume

14.消费的topic查看

./bin kafka-console-consumer.sh --topic __consumer_offsets --zookeeper localhost:2181 --formatter "kafka.coordinator.GroupMetadataManager\$OffsetsMessageFormatter" --consumer.config /etc/KAFKA/consumer.properties --from-beginning
其中consumer.properties的group.id=消费的组，
exclude.internal.topics=false

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topicName --from-beginning

15.kafka自带压测命令

./kafka-producer-perf-test.sh --topic test5 --num-records 100000 --record-size 1 --throughput 100  --producer-props bootstrap.servers=hbp001:9092

16.平衡leader

./kafka-preferred-replica-election.sh --zookeeper zk_host:port/chroot

17、启动kafka服务

bin/kafka-server-start.sh config/server.properties &
18、停止kafka服务

./kafka-server-stop.sh 

18 消费者组

bin/kafka-consumer-groups.sh --bootstrap-server 127.0.0.1:9092 --list
./kafka-consumer-groups.sh --bootstrap-server 10.3.70.109:9092 --describe --group test_group2



