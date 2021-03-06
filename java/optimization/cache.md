## 缓存穿透、缓存击穿、缓存雪崩
### 缓存穿透
正常情况下，查询的数据都存在，如果请求一个不存在的数据，也就是缓存和数据库都查不到这个数据，每次都会去数据库查询，这种查询不存在数据的现象我们称为缓存穿透

### 解决办法

- 缓存空值
 之所以发生穿透，是因为缓存中没有存储这些数据的key，从而每次都查询数据库我们可以为这些key在缓存中设置对应的值为null，后面查询这个key的时候就不用查询数据库了,当然为了健壮性，我们要对这些key设置过期时间，以防止真的有数据
- BloomFilter
BloomFilter 类似于一个hbase set 用来判断某个元素（key）是否存在于某个集合中
我们把有数据的key都放到BloomFilter中，每次查询的时候都先去BloomFilter判断，如果没有就直接返回null
注意BloomFilter没有删除操作，对于删除的key，查询就会经过BloomFilter然后查询缓存再查询数据库，所以BloomFilter可以结合缓存空值用，对于删除的key，可以在缓存中缓存null

### 缓存击穿
在高并发的情况下，大量的请求同时查询同一个key时，此时这个key正好失效了，就会导致同一时间，这些请求都会去查询数据库，这样的现象我们称为缓存击穿

### 解决办法
采用分布式锁，只有拿到锁的第一个线程去请求数据库，然后插入缓存，当然每次拿到锁的时候都要去查询一下缓存有没有

### 缓存雪崩
当某一时刻发生大规模的缓存失效的情况，比如你的缓存服务宕机了。

### 解决办法
使用集群缓存，保证缓存服务的高可用
使用 Hystrix进行限流 & 降级 ，比如一秒来了5000个请求，我们可以设置假设只能有一秒 2000个请求能通过这个组件，那么其他剩余的 3000 请求就会走限流逻辑。

