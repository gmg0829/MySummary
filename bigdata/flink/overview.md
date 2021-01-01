# Flink 概述
Flink通过实现Google Dataflow流式计算模型实现了高吞吐、低延迟、高性能兼具实时流式计算框架。Flink近年来逐步被人们所熟知，不仅是因为Flink提供同时支持高吞吐、低延迟和exactly-once语义的实时计算能力，同时Flink还提供了基于流式计算引擎处理批量数据的计算能力，真正意义上实现了批流统一，同时随着阿里对Blink的开源，极大地增强了Flink对批计算领域的支持。

## 优势
- 同时支持高吞吐、低延迟、高性能
- 支持事件时间（Event Time）
- 支持有状态计算
- 支持高度灵活的窗口（Window）操作
- 基于轻量级分布式快照（Snapshot）实现的容错
- 基于JVM实现独立的内存管理

## 应用场景
- 实时智能推荐
- 复杂事件处理
- 实时欺诈检测
- 实时数仓与ETL
- 流数据分析
- 实时报表分析

## 架构模型
![啡海报](
  ./flink-Architecture.png)

大多数应用程序不需要上图中的最低级别的 Low-level 抽象，而是针对 Core API 编程， 比如 DataStream API（有界/无界流）和 DataSet API （有界数据集）。Table API 和 SQL 是 Flink 提供的更为高级的 API 操作。

## 基本组件
### Client客户端
客户端负责将任务提交到集群，与JobManager构建Akka连接，然后将任务提交到JobManager，通过和JobManager之间进行交互获取任务执行状态。
### JobManager
JobManager负责整个Flink集群任务的调度以及资源的管理，从客户端中获取提交的应用，然后根据集群中TaskManager上TaskSlot的使用情况，为提交的应用分配相应的TaskSlots资源并命令TaskManger启动从客户端中获取的应用。
### TaskManager
TaskManager相当于整个集群的Slave节点，负责具体的任务执行和对应任务在每个节点上的资源申请与管理。客户端通过将编写好的Flink应用编译打包，提交到JobManager，然后JobManager会根据已经注册在JobManager中TaskManager的资源情况，将任务分配给有资源的TaskManager节点，然后启动并运行任务。

## 参考

- 42讲轻松通关 Flink
- Flink 原理、实战与性能优化