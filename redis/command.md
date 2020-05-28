## redis慢查询
Redis slowlog是Redis用来记录查询执行时间的日志系统。
### 慢查询参数
1、slowlog-log-slower-than：预设阀值，即记录超过多少时间的记录，默认为10000微秒，即10毫秒。

2、slowlog-max-len：记录慢查询的条数，默认为128条，当超过设置的条数时最早进入队列的将被移除。线上建议增大数值，如：1000，这样可减少队列移除的频率。

### 慢查询命令
- slowlog get
- slowlog get 10 参数10表示展示的条数
- slowlog len 获取慢查询列表长度
- slowlog reset 清空日志列表

## 内存分析
### 离线分析
生成内存快照会用到一个开源的工具，Redis-rdb-tools，用来做rdb文件的分析。命令为db -c memory dump.rdb > memory.csv。生成的内存快照为csv格式，包含：

-  Database：数据库ID
- Type：数据类型
- Key：
- size_in_bytes：理论内存值（比实际略低）
- Encoding：编码方式
- num_elements：成员个数
- len_largest_element：最大成员长度
### 在线分析
redis-cli -h host -p port --bigkeys

## redis-cli
redis-cli -r 5 -i 1 info | grep qps 每隔一秒，执行5次
redis-cli --stat 监控服务器状态
redis-cli monitor
## rdb 备份

## info
info
info memory 内存
info replication 复制相关信息
redis-cli info stats |grep ops 每秒操作数
redis-cli info clients 连接了多少客户端
redis-cli info stats |grep reject 拒绝的客户端
redis-cli info memory | grep used | grep human 内存占用

### info memory 
used_memory:236026888    由 Redis 分配器分配的内存总量，包含了redis进程内部的开销和数据占用的内存，以字节（byte）为单位（是你的Redis实例中所有key及其value占用的内存大小）            
used_memory_human:225.09M   已更直观的单位展示分配的内存总量（是你的Redis实例中所有key及其value占用的内存大小）
used_memory_rss:274280448     向操作系统申请的内存大小（这个值一般是大于used_memory的，因为Redis的内存分配策略会产生内存碎片。）
used_memory_rss_human:261.57M   已更直观的单位展示向操作系统申请的内存大小（这个值一般是大于used_memory的，因为Redis的内存分配策略会产生内存碎片。）
used_memory_peak:458320936   redis的内存消耗峰值(以字节为单位)
used_memory_peak_human:437.09M  以更直观的格式返回redis的内存消耗峰值
total_system_memory:33614647296    系统内存总量
total_system_memory_human:31.31G   以更直观的格式展示系统内存总量
used_memory_lua:37888   Lua脚本存储占用的内存
used_memory_lua_human:37.00K   以更直观的格式显示Lua脚本存储占用的内存
maxmemory:7000000000   Redis实例的最大内存配置（设置的最大内存）
maxmemory_human:6.52G  以更直观的格式显示最大内存配置
maxmemory_policy:noeviction   当达到maxmemory时的淘汰策略
mem_fragmentation_ratio:1.16   碎片率，used_memory_rss/ used_memory （正常情况下是1左右，如果大于1比如1.8说明内存碎片很严重了。）
mem_allocator:jemalloc-4    内存分配器

## 内存淘汰机制
- noeviction：当内存不足以容纳新写入数据时，新写入操作会报错，这个一般没人用吧
- allkeys-lru：当内存不足以容纳新写入数据时，在键空间中，移除最近最少使用的key（这个是最常用的）
- allkeys-random：当内存不足以容纳新写入数据时，在键空间中，随机移除某个key，这个一般没人用吧
- volatile-lru：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，移除最近最少使用的key（这个一般不太合适）
- volatile-random：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，随机移除某个key
- volatile-ttl：当内存不足以容纳新写入数据时，在设置了过期时间的键空间中，有更早过期时间的key优先移除


