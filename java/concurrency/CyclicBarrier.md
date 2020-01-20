CyclicBarrier，回环栅栏，它会阻塞一组线程直到这些线程同时达到某个条件才继续执行。它与CountDownLatch很类似，但又不同，CountDownLatch需要调用countDown()方法触发事件，而CyclicBarrier不需要，它就像一个栅栏一样，当一组线程都到达了栅栏处才继续往下走。

Generation，中文翻译为代，一代人的代，用于控制CyclicBarrier的循环使用。

三个线程完成后进入下一代，继续等待三个线程达到栅栏处再一起执行，而CountDownLatch则做不到这一点，CountDownLatch是一次性的，无法重置其次数。

## 总结
（1）CyclicBarrier会使一组线程阻塞在await()处，当最后一个线程到达时唤醒（只是从条件队列转移到AQS队列中）前面的线程大家再继续往下走；
（2）CyclicBarrier不是直接使用AQS实现的一个同步器；
（3）CyclicBarrier基于ReentrantLock及其Condition实现整个同步逻辑；

## CyclicBarrier与CountDownLatch的异同？

（1）两者都能实现阻塞一组线程等待被唤醒；
（2）前者是最后一个线程到达时自动唤醒；
（3）后者是通过显式地调用countDown()实现的；
（4）前者是通过重入锁及其条件锁实现的，后者是直接基于AQS实现的；
（5）前者具有“代”的概念，可以重复使用，后者只能使用一次；
（6）前者只能实现多个线程到达栅栏处一起运行；
（7）后者不仅可以实现多个线程等待一个线程条件成立，还能实现一个线程等待多个线程条件成立。

