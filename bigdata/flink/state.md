# Flink 状态管理和容错

## 有状态计算
有状态计算指在程序计算过程中，在Flink内部存储计算产生的中间结果，并提供给后续Function或算子计算结果使用。

### 状态类型
- Keyed State
- Operator State

## Checkpoints
Flink中基于异步轻量级的分布式快照技术提供了Checkpoints容错机制，分布式快照可以将同一时间点Task/Operator的状态数据全局统一快照处理。当应用出现异常时，Operator就能够从上一次快照中恢复所有算子之前的状态，从而保证数据的一致性。

## 状态管理器
Flink中一共实现了三种类型的状态管理器，包括基于内存的MemoryStateBackend、基于文件系统的FsStateBackend，以及基于RockDB作为存储介质的RocksDBState-Backend。这三种类型的StateBackend都能够有效地存储Flink流式计算过程中产生的状态数据，在默认情况下Flink使用的是内存作为状态管理器。

