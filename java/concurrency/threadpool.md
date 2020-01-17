## 线程池原理

- Executors.newCachedThreadPool()：无限线程池。
- Executors.newFixedThreadPool(nThreads)：创建固定大小的线程池。
- Executors.newSingleThreadExecutor()：创建单个线程的线程池。

ThreadPoolExecutor(int corePoolSize, int maximumPoolSize, long keepAliveTime, TimeUnit unit, BlockingQueue<Runnable> workQueue, RejectedExecutionHandler handler)

- corePoolSize 为线程池的基本大小。
- maximumPoolSize 为线程池最大线程大小。
- keepAliveTime 和 unit 则是线程空闲后的存活时间。 线程空闲下来之后，保持存活的持续时间，超过这个时间还没有任务执行，该工作线程结束。
- workQueue 用于存放任务的阻塞队列。
- handler 当队列和最大线程池都满了之后的饱和策略。


线程池基本流程
1、有新任务提交时，首先检查核心线程数，如果核心线程都在工作，而且数量也已经达到最大核心线程数，则不会继续新建核心线程，而会将任务放入等待队列。
2、当等待队列满了，如果当前线程数没有超过最大线程数，则会新建线程执行任务，否则线程池会根据饱和策略来执行后续操作，默认的策略是抛弃要加入的任务。
![](
  ./xcc.png)

### execute/submit


### 如何配置线程
- IO 密集型任务：由于线程并不是一直在运行，所以可以尽可能的多配置线程，比如 CPU 个数 * 2
- CPU 密集型任务（大量复杂的运算）应当分配较少的线程，比如 CPU 个数相当的大小。

### 优雅的关闭线程池
- shutdown() 执行后停止接受新任务，会把队列的任务执行完毕。
- shutdownNow() 也是停止接受新任务，但会中断所有的任务，将线程池状态变为 stop。

