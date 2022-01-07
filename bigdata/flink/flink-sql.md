## csv
```
create table csv(" +
            " pageId VARCHAR," +
            " eventId VARCHAR," +
            " recvTime VARCHAR" +
            ") with (" +
            " 'connector.type' = 'filesystem',\n" +
            " 'connector.path' = '/Users/bang/sourcecode/project/flink-sql-etl/data-generator/src/main/resources/user3.csv',\n" +
            " 'format.type' = 'csv',\n" +
            " 'format.fields.0.name' = 'pageId',\n" +
            " 'format.fields.0.data-type' = 'STRING',\n" +
            " 'format.fields.1.name' = 'eventId',\n" +
            " 'format.fields.1.data-type' = 'STRING',\n" +
            " 'format.fields.2.name' = 'recvTime',\n" +
            " 'format.fields.2.data-type' = 'STRING')
```
## elasticsearch
```
CREATE TABLE append_test (\n" +
            "  aggId varchar ,\n" +
            "  pageId varchar ,\n" +
            "  ts varchar ,\n" +
            "  expoCnt int ,\n" +
            "  clkCnt int\n" +
            ") WITH (\n" +
            "'connector.type' = 'elasticsearch',\n" +
            "'connector.version' = '6',\n" +
            "'connector.hosts' = 'http://localhost:9200',\n" +
            "'connector.index' = 'append_test7',\n" +
            "'connector.document-type' = '_doc',\n" +
            "'update-mode' = 'upsert',\n" +
            "'connector.key-delimiter' = '$',\n" +
            "'connector.key-null-literal' = 'n/a',\n" +
            "'connector.bulk-flush.interval' = '1000',\n" +
            "'format.type' = 'json'\n" +
            ")\n
```
## mysql
```
CREATE TABLE test_upsert (\n" +
            "  aggId STRING ,\n" +
            "  pageId STRING ,\n" +
            "  ts STRING ,\n" +
            "  expoCnt BIGINT ,\n" +
            "  clkCnt BIGINT\n" +
            ") WITH (\n" +
            "   'connector.type' = 'jdbc',\n" +
            "   'connector.url' = 'jdbc:mysql://localhost:3306/test',\n" +
            "   'connector.username' = 'root'," +
            "   'connector.table' = 'test_upsert',\n" +
            "   'connector.driver' = 'com.mysql.jdbc.Driver',\n" +
            "   'connector.write.flush.max-rows' = '5000', \n" +
            "   'connector.write.flush.interval' = '2s', \n" +
            "   'connector.write.max-retries' = '3'" +
            ")
```
## kafka
```
CREATE TABLE orders (\n" +
            "  order_id STRING,\n" +
            "  item    STRING,\n" +
            "  currency STRING,\n" +
            "  amount INT,\n" +
            "  order_time TIMESTAMP(3),\n" +
            "  proc_time as PROCTIME(),\n" +
            "  amount_kg as amount * 1000,\n" +
            "  ts as order_time + INTERVAL '1' SECOND,\n" +
            "  WATERMARK FOR order_time AS order_time\n" +
            ") WITH (\n" +
            "  'connector.type' = 'kafka',\n" +
            "  'connector.version' = '0.10',\n" +
            "  'connector.topic' = 'flink_orders3',\n" +
            "  'connector.properties.zookeeper.connect' = 'localhost:2181',\n" +
            "  'connector.properties.bootstrap.servers' = 'localhost:9092',\n" +
            "  'connector.properties.group.id' = 'testGroup4',\n" +
            "  'connector.startup-mode' = 'earliest-offset',\n" +
            "  'format.type' = 'json',\n" +
            "  'format.derive-schema' = 'true'\n" +
            ")
```

## hbase
```
CREATE TABLE country (\n" +
            "  rowkey VARCHAR,\n" +
            "  f1 ROW<country_id INT, country_name VARCHAR, country_name_cn VARCHAR, currency VARCHAR, region_name VARCHAR> \n" +
            " " +
            ") WITH (\n" +
            "    'connector.type' = 'hbase',\n" +
            "    'connector.version' = '1.4.3',\n" +
            "    'connector.table-name' = 'country',\n" +
            "    'connector.zookeeper.quorum' = 'localhost:2182',\n" +
            "    'connector.zookeeper.znode.parent' = '/hbase' " +
            ")
```

## mysql-cdc
```
 CREATE TABLE demoOrders (
         `order_id` INTEGER ,
          `order_date` DATE ,
          `order_time` TIMESTAMP(3),
          `quantity` INT ,
          `product_id` INT ,
          `purchaser` STRING,
           WATERMARK FOR order_time AS order_time 
         ) WITH (
          'connector' = 'mysql-cdc',
          'hostname' = 'localhost',
          'port' = '3306',
          'username' = 'mysqluser',
          'password' = 'mysqlpw',
          'database-name' = 'inventory',
          'table-name' = 'demo_orders');
```

```
 CREATE TABLE `demoProducts` (
          `product_id` INTEGER,
          `product_name` STRING,
          `price` DECIMAL(10, 4),
          `currency` STRING,
           update_time TIMESTAMP(3) METADATA FROM 'value.source.timestamp' VIRTUAL,
          PRIMARY KEY(product_id) NOT ENFORCED,
          WATERMARK FOR update_time AS update_time
        ) WITH (
          'connector' = 'kafka',
           'topic' = 'dbserver1.inventory.demo_products',
           'properties.bootstrap.servers' = 'localhost:9092',
           'scan.startup.mode' = 'earliest-offset',
           'format' = 'debezium-json',
           'debezium-json.schema-include' = 'true');
```



## UDF
```

./bin/sql-client.sh embedded -j flink-demo-udf.jar
create function int2Date as 'udf.Int2DateUDF';
```

## hive
```
CREATE TABLE dimension_table (
  product_id STRING,
  product_name STRING,
  unit_price DECIMAL(10, 4),
  pv_count BIGINT,
  like_count BIGINT,
  comment_count BIGINT,
  update_time TIMESTAMP(3),
  update_user STRING,
  ...
) TBLPROPERTIES (
  'streaming-source.enable' = 'false',           -- option with default value, can be ignored.
  'streaming-source.partition.include' = 'all',  -- option with default value, can be ignored.
  'lookup.join.cache.ttl' = '12 h'
);
```



