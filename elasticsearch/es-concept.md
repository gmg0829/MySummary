   Elasticsearch 是基于 JSON 的分布式搜索和分析引擎，专为实现水平扩展、高可用和管理便捷性而设计。
   ## es concept
   ### 索引
   索引是文档的容器，是一类文档的集合。一个es集群中多个索引。
   - Mapping 定义了文档字段的类型
   - Setting 定义不同数据的分布
   ### 文档
   es是面向文档的，文档是可搜索数据的最小单位。可以理解为关系数据库中的一条记录。

   文档会被序列化成json格式，每个字段有自己的数据类型。

   每个文档有自己的unique id。可以自己指定或es自动生成。

   ### 节点
   节点是一个es的实例，每个节点都有名字。通过配置文件配置或者启动的时候(-E node.name=node1)指定。每个节点启动之后会分配一个uid,保存在data目录下。
   - data node 数据节点，在数据拓展上起到了重要作用. 
   - coordinating node 负责接收client请求,将请求发送到合适的节点。最终将结果汇聚在一起。每个节点都起到了
   coordinating 的职责。
   - Hot & Warm node 不同硬件配置的Data node.
   - machine leraning  node 负责机器学习的job,用来做异常检测。

   #### 配置节点类型

   ### 分片

   - 主分片 用来解决数据水平扩展的问题。通过主分片，可以将数据分布到集群内的所有节点之上。
      - 一个分片是一个运行的lunence的实例。
      - 主分片数在索引创建时指定，后续不允许修改。
   - 副本，用以结局数据高可用的问题。分片是主分片的拷贝
   。
      - 副分片数可以动态调整。

   ### 解释
   一个node对应一个es instance
   一个node可以有多个index
   一个index可以有多个shard
   一个shard是一个lucene index（这个index是lucene自己的概念、和es的index不是一回事）     





