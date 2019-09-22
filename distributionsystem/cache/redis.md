## 哨兵模式
Redis-Sentinel是Redis官方推荐的高可用性(HA) 解决方案，Redis-sentinel本身也是一个独立运行的进程，它能监控多个master-slave集群，发现master宕机后能进行自动切换。Sentinel可以监视任意多个主服务器（复用），以及主服务器属下的从服务器，并在被监视的主服务器下线时，自动执行故障转移操作。

为了防止sentinel的单点故障，可以对sentinel进行集群化，创建多个sentinel。

![s](
  ./redis-Sentinel.png)
## docker 安装

### docker 常规
```
docker pull redis

cd /
mkdir /redis/config
cd  /redis/config
touch redis.conf
vim redis.conf

docker run -d \
-p 6379:6379 \
-v /redis/config/redis.conf:/etc/redis/redis.conf \
--privileged=true \
--name redis \
redis \
redis-server /etc/redis/redis.conf
```


### docker-compose 
```
version: '3'
services:
   redis:
      image: redis
      container_name: redis
      restart: always
      ports:
        - 6379:6379
```

