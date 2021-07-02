service aerospike start
service aerospike stop
service aerospike restrart
asadm -> info
aerospike.conf
AQL连接
aql -h 192.168.1.100 -p 3000

namespace bsfit {         #bsift为命名空间的名称

replication-factor 2 #复制因子，代表每条数据在集群中保留的个数。如2表示每条数据存两份，这样集群中某一个节点挂掉后是不会丢数据的

memory-size 4G #最大可以使用的内存数量

default-ttl 30d # 30 days, use 0 to never expire/evict.

high-water-memory-pct 70 #内存使用率达到70%，将启动LRU，清理设置过期时间的数据。默认60%

high-water-disk-pct 90 #磁盘使用率达到90%，新的key将不可以再写入，已经写入的key可以修改。默认50%

stop-writes-pct 90 #内存使用率达到90%，将不可以再写入（可以删除）。默认90%

storage-engine memory #数据存储模式，memory表示数据全部存放在内存中，这也是流立方最推荐的配置方式
}
ps -aux | grep aerospike



