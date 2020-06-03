## hadoop 性能调优
Hdfs所能存储的文件总数受限于NameNode的内存容量，需要处理的作业和ResourceManager内存有关，ResourceManager保存了最近100个运行在集群上的元数据信息。

Hadoop中的从节点，负责计算和存储，所以需要保证CPU和内存能够满足计算需求。
## 参数调优
- dfs.block.size 通常设为128M和256M
- dfs.datanode.max.xcievers Namenode和datanode通信的线程数
- dfs.replication 副本数 
- dfs.datanode.balance.bandwodthPerSe 带宽
- dfs.datanode.max.transfer.threads 进行文件传输的最大线程数
- io.file.buffer.size 缓冲区大小 
- yarn.nodemanager.resource.memory-mb 物理节点多少内存加入资源池

 