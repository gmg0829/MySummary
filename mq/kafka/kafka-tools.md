## Kafka Manager
## Kafka Eagle


bin\windows\zookeeper-server-start.bat config\zookeeper.properties

bin\windows\kafka-server-start.bat config\server.properties

bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test

bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic qwer --from-beginning

\bin\kafka-manager.bat

 InfluxDB、Prometheus  Grafana

 192.168.1.177,192.168.1.178,192.168.1.181

 redis-cli --csv SMEMBERS gmg > stdout.csv 2> stderr.txt