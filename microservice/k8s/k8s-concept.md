# k8s核心概念

## API Server
k8s Api通过叫做k8s apiserver的进程提供服务，这个进程运行在单个k8s master节点上。

Api Server有如下功能：
- 提供集群管理的Api接口
- 成为集群内各个功能模块之间数据交换和通信的中心枢纽
- 拥有完备的集群安全机制

k8s还提供可命令行工具kubectl，用来将api server的api包装成简单的命令集。

在管理工具界面使用kubectl语法运行如下命令：
```
kubectl [command] [TYPE] [NAME] [flags]
```