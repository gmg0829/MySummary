### currentThread()
currentThread()方法可返回该代码正在被哪个线程调用的信息。
### start()和run()
使用t.start()方法的时候是线程自动调用的run()方法，所以输出的是Thread-0，当你直接调用run()方法时，和调用普通方法没有什么区别，所以是main线程调用run();
### isAlive()
isAlive()方法的功能是判断当前的线程是否处于活动状态
### sleep()
方法sleep()的作用是在指定的毫秒数内让当前“正在执行的线程”休眠（暂停执行），这个“正在执行的线程”是指this.currentThread()返回的线程。
main线程与thread线程是异步执行的.
### getId()
getId()方法的作用是取得线程的唯一标识
### 暂停线程
可以使用suspend()方法暂停线程，使用resume()方法恢复线程的执行
### yield方法
yield()方法的作用是放弃当前的CPU资源，将它让给其他的任务去占用CPU执行时间。但放弃的时间不确定，有可能刚刚放弃，马上又获得CPU时间片.
### 停止线程
在 Java 中有以下 3 种方法可以终止正在运行的线程：

1）使用退出标志，使线程正常退出，也就是当 run() 方法完成后线程停止。
2）使用 stop() 方法强行终止线程，但是不推荐使用这个方法，因为该方法已经作废过期，使用后可能产生不可预料的结果。
3）使用 interrupt() 方法中断线程。

interrupted() 测试当前线程是否已经中断。
isInterrupted() 测试线程是否已经中断。

interrupted() 方法 不止可以判断当前线程是否已经中断，而且可以会清除该线程的中断状态。而对于 isInterrupted() 方法，只会判断当前线程是否已经中断，不会清除线程的中断状态。


### 线程优先级
在操作系统中，线程可以划分优先级，优先级较高的线程得到的CPU资源较多，也就是CPU优先执行优先级较高的线程对象中的任务。

设置线程优先级有助于帮“线程规划器”确定在下一次选择哪一个线程来优先执行。

设置线程的优先级使用setPriority()方法.
### 守护线程
在java中有两种线程，一种是用户线程，另一种是守护线程。

守护线程是一种特殊的线程，它的特性有“陪伴”的含义，当进程中不存在非守护线程了，则守护线程自动销毁。典型的守护线程就是垃圾回收线程，当进程中没有非守护线程了，则垃圾回收线程也就没有存在的必要了，自动销毁。

### join

join方法本身是通过wait方法来实现等待的，这里判断如果线程还在运行中的话，则继续等待，如果指定时间到了，或者线程运行完成了，则代码继续向下执行，调用线程就可以执行后面的逻辑了。

## 线程状态
```
public
 
enum
 
State
 
{

    
/**

     * 新建状态，线程还未开始

     */

    NEW
,



    
/**

     * 可运行状态，正在运行或者在等待系统资源，比如CPU

     */

    RUNNABLE
,



    
/**

     * 阻塞状态，在等待一个监视器锁（也就是我们常说的synchronized）

     * 或者在调用了Object.wait()方法且被notify()之后也会进入BLOCKED状态

     */

    BLOCKED
,



    
/**

     * 等待状态，在调用了以下方法后进入此状态

     * 1. Object.wait()无超时的方法后且未被notify()前，如果被notify()了会进入BLOCKED状态

     * 2. Thread.join()无超时的方法后

     * 3. LockSupport.park()无超时的方法后

     */

    WAITING
,



    
/**

     * 超时等待状态，在调用了以下方法后会进入超时等待状态

     * 1. Thread.sleep()方法后【本文由公从号“彤哥读源码”原创】

     * 2. Object.wait(timeout)方法后且未到超时时间前，如果达到超时了或被notify()了会进入BLOCKED状态

     * 3. Thread.join(timeout)方法后

     * 4. LockSupport.parkNanos(nanos)方法后

     * 5. LockSupport.parkUntil(deadline)方法后

     */

    TIMED_WAITING
,



    
/**

     * 终止状态，线程已经执行完毕

     */

    TERMINATED
;

}
```

![](
  ./thread-state.jpg)

https://juejin.im/post/5a72d4bd518825735300f37b


