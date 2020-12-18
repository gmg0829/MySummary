## 索引
### 全局索引
全局索引更多的应用在读较多的场景。它对应一张独立的HBASE表。对于全局索引，在查询中检索的列如果不在索引表中，默认的索引表将不会被使用，除非使用hint。

### 本地索引
因为本地索引和原数据是存储在同一个表中的，所以更适合写多的场景。对于本地索引，查询中无论是否指定hint或者是查询的列是否都在索引表中，都会使用索引表。

1. 创建同步索引超时怎么办？

```
<property>
    <name>hbase.rpc.timeout</name>
    <value>60000000</value>
</property>
<property>
    <name>hbase.client.scanner.timeout.period</name>
    <value>60000000</value>
</property>
<property>
    <name>phoenix.query.timeoutMs</name>
    <value>60000000</value>
</property>
```

2、索引表最多可以创建多少个？
10个

## 数据类型

1. INTEGER
2. UNSIGNED_INT
3. BIGINT
4. UNSIGNED_LONG
5. TINYINT
6. UNSIGNED_TINYINT
7. SMALLINT
8. UNSIGNED_SMALLINT
9. FLOAT
10. UNSIGNED_FLOAT
11. DOUBLE
12. UNSIGNED_DOUBLE
13. DECIMAL
14. BOOLEAN
15. TIME
16. DATE
17. TIMESTAMP
18. UNSIGNED_TIME
19. UNSIGNED_DATE
20. UNSIGNED_TIMESTAMP
21. VARCHAR
22. CHAR
23. BINARY
24. VARBINARY
25. ARRAY


## 查询计划

### 操作符说明
UNION ALL: 表示union all查询，操作符后面接查询计划中涉及查询的数量
AGGREGATE INTO SINGLE ROW: 没有groupby语句情况下，聚合查询结果到一行中。例如 count(*)
AGGREGATE INTO ORDERED DISTINCT ROWS：带有group by的分组查询
FILTER BY expression: 过滤出符合表达式条件的数据
INNER-JOIN: 多表Join
MERGE SORT: 进行merge sort排序，大多是客户端对多线程查询结果进行排序
RANGE SCAN: 对主键进行范围扫描，通常有指定start key和stop key
ROUND ROBIN: 对查询没有排序要求，并发的在客户端发起扫描请求。
SKIP SCAN: Phoenix实现的一种扫描方式，通常能比Range scan获得更好的性能。
FULL SCAN: 全表扫描
LIMIT: 对查询结果取TOP N
CLIENT: 在客户端执行相关操作
X-CHUNK: 根据统计信息可以把一个region分成多个CHUNK, X在查询计划中表示将要扫描的CHUNK数量，此处是多线程并发扫描的，并发的数量是由客户端线程池的大小来决定的
PARALLEL X-WAY：描述了有X个并发对scan做merge sort之类的客户端操作
SERIAL: 单线程串行执行
SERVER: 在SERVER端(RS)执行相关操作

## 参数调优

https://blog.csdn.net/qq_36732988/article/details/87915449

