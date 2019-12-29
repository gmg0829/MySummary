## java并发思维导图
![](
  ./sike-juc.png)
## juc 思维导图 

J.U.C核心由5大块组成：atomic包、locks包、collections包、tools包（AQS）、executor包（线程池）。 
![](
  ./concurrent-swdt.png)
### java.util.concurrent.atomic

atomic包含原子类。
![](
  ./automic.jpg)

### java.util.concurrent.locks

locks包包含锁相关的类，如lock、condition等

![](
  ./locks.jpg)
### java.util.concurrent

concurrent包下包含一些并发工具类，如Executors、Semaphore、CountDownLatch、CyclicBarrier、BlockingQueue等。

![](
  ./concurrent-1.jpg)
  ![](
  ./concurrent-2.jpg)
  ![](
  ./concurrent-3.jpg)



## 线程安全
线程安全是编程中的术语，指某个函数、函数库在多线程环境中被调用时，能够正确地处理多个线程之间的共享变量，使程序功能正确完成。