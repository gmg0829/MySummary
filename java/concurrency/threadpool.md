## 体系结构
![](
  ./executor.png)
（1）Executor，线程池顶级接口；
（2）ExecutorService，线程池次级接口，对Executor做了一些扩展，增加一些功能；
（3）ScheduledExecutorService，对ExecutorService做了一些扩展，增加一些定时任务相关的功能；
（4）AbstractExecutorService，抽象类，运用模板方法设计模式实现了一部分方法；
（5）ThreadPoolExecutor，普通线程池类，这也是我们通常所说的线程池，包含最基本的一些线程池操作相关的方法实现；
（6）ScheduledThreadPoolExecutor，定时任务线程池类，用于实现定时任务相关功能；
（7）ForkJoinPool，新型线程池类，java7中新增的线程池类，基于工作窃取理论实现，运用于大任务拆小任务、任务无限多的场景；
（8）Executors，线程池工具类，定义了一些快速实现线程池的方法（谨慎使用）；
### Executor
```
public interface Executor {
    // 执行无返回值任务【本篇文章由公众号“彤哥读源码”原创】
    void execute(Runnable command);
}
```
### ExecutorService
```
public interface ExecutorService extends Executor {
    // 关闭线程池，不再接受新任务，但已经提交的任务会执行完成
    void shutdown();

    // 立即关闭线程池，尝试停止正在运行的任务，未执行的任务将不再执行
    // 被迫停止及未执行的任务将以列表的形式返回
    List<Runnable> shutdownNow();

    // 检查线程池是否已关闭
    boolean isShutdown();

    // 检查线程池是否已终止，只有在shutdown()或shutdownNow()之后调用才有可能为true
    boolean isTerminated();
    
    // 在指定时间内线程池达到终止状态了才会返回true
    boolean awaitTermination(long timeout, TimeUnit unit)
        throws InterruptedException;
    
    // 执行有返回值的任务，任务的返回值为task.call()的结果
    <T> Future<T> submit(Callable<T> task);

    // 执行有返回值的任务，任务的返回值为这里传入的result
    // 当然只有当任务执行完成了调用get()时才会返回
    <T> Future<T> submit(Runnable task, T result);
    
    // 执行有返回值的任务，任务的返回值为null
    // 当然只有当任务执行完成了调用get()时才会返回
    Future<?> submit(Runnable task);

    // 批量执行任务，只有当这些任务都完成了这个方法才会返回
    <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks)
        throws InterruptedException;

    // 在指定时间内批量执行任务，未执行完成的任务将被取消
    // 这里的timeout是所有任务的总时间，不是单个任务的时间
    <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks,
                                  long timeout, TimeUnit unit)
        throws InterruptedException;
    
    // 返回任意一个已完成任务的执行结果，未执行完成的任务将被取消
    <T> T invokeAny(Collection<? extends Callable<T>> tasks)
        throws InterruptedException, ExecutionException;

    // 在指定时间内如果有任务已完成，则返回任意一个已完成任务的执行结果，未执行完成的任务将被取消
    <T> T invokeAny(Collection<? extends Callable<T>> tasks,
                    long timeout, TimeUnit unit)
        throws InterruptedException, ExecutionException, TimeoutException;
}
``` 
### ScheduledExecutorService
```
public interface ScheduledExecutorService extends ExecutorService {

    // 在指定延时后执行一次
    public ScheduledFuture<?> schedule(Runnable command,
                                       long delay, TimeUnit unit);
    // 在指定延时后执行一次
    public <V> ScheduledFuture<V> schedule(Callable<V> callable,
                                           long delay, TimeUnit unit);
                                           
    // 在指定延时后开始执行，并在之后以指定时间间隔重复执行（间隔不包含任务执行的时间）
    // 相当于之后的延时以任务开始计算【本篇文章由公众号“彤哥读源码”原创】
    public ScheduledFuture<?> scheduleAtFixedRate(Runnable command,
                                                  long initialDelay,
                                                  long period,
                                                  TimeUnit unit);

    // 在指定延时后开始执行，并在之后以指定延时重复执行（间隔包含任务执行的时间）
    // 相当于之后的延时以任务结束计算
    public ScheduledFuture<?> scheduleWithFixedDelay(Runnable command,
                                                     long initialDelay,
                                                     long delay,
                                                     TimeUnit unit);

}
```
### AbstractExecutorService
```
public abstract class AbstractExecutorService implements ExecutorService {

    protected <T> RunnableFuture<T> newTaskFor(Runnable runnable, T value) {
        return new FutureTask<T>(runnable, value);
    }

    protected <T> RunnableFuture<T> newTaskFor(Callable<T> callable) {
        return new FutureTask<T>(callable);
    }

    public Future<?> submit(Runnable task) {
        if (task == null) throw new NullPointerException();
        RunnableFuture<Void> ftask = newTaskFor(task, null);
        execute(ftask);
        return ftask;
    }

    public <T> Future<T> submit(Runnable task, T result) {
        if (task == null) throw new NullPointerException();
        RunnableFuture<T> ftask = newTaskFor(task, result);
        execute(ftask);
        return ftask;
    }

    public <T> Future<T> submit(Callable<T> task) {
        if (task == null) throw new NullPointerException();
        RunnableFuture<T> ftask = newTaskFor(task);
        execute(ftask);
        return ftask;
    }

    public <T> T invokeAny(Collection<? extends Callable<T>> tasks)
        throws InterruptedException, ExecutionException {
        // 略...
    }

    public <T> T invokeAny(Collection<? extends Callable<T>> tasks,
                           long timeout, TimeUnit unit)
        throws InterruptedException, ExecutionException, TimeoutException {
        // 略...
    }

    public <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks)
        throws InterruptedException {
        // 略...
    }

    public <T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks,
                                         long timeout, TimeUnit unit)
        throws InterruptedException {
        // 略...
    }

}
```
### ForkJoinPool
新型线程池类，java7中新增的线程池类，这个线程池与Go中的线程模型特别类似，都是基于工作窃取理论，特别适合于处理归并排序这种先分后合的场景。

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

### 构造方法
ThreadPoolExecutor有四个构造方法，其中前三个最终都是调用最后一个，它有7个参数，分别为corePoolSize、maximumPoolSize、keepAliveTime、unit、workQueue、threadFactory、handler。
### 拒绝策略
#### JDK内置4种线程池拒绝策略
ThreadPoolExecutor.*   RejectedExecutionHandler

CallerRunsPolicy（调用者运行策略）

AbortPolicy（中止策略）当触发拒绝策略时，直接抛出拒绝执行的异常，中止策略的意思也就是打断当前执行流程

DiscardPolicy（丢弃策略） 直接静悄悄的丢弃这个任务，不触发任何动作

DiscardOldestPolicy（弃老策略）如果线程池未关闭，就弹出队列头部的元素，然后尝试执行


### 如何配置线程
- IO 密集型任务：由于线程并不是一直在运行，所以可以尽可能的多配置线程，比如 CPU 个数 * 2
- CPU 密集型任务（大量复杂的运算）应当分配较少的线程，比如 CPU 个数相当的大小。

### 优雅的关闭线程池
- shutdown() 执行后停止接受新任务，会把队列的任务执行完毕。
- shutdownNow() 也是停止接受新任务，但会中断所有的任务，将线程池状态变为 stop。

