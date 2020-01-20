CountDownLatch，可以翻译为倒计时器，但是似乎不太准确，它的含义是允许一个或多个线程等待其它线程的操作执行完毕后再执行后续的操作。

CountDownLatch中只包含了Sync一个内部类，它没有公平/非公平模式，所以它算是一个比较简单的同步器了。

## 总结

（1）CountDownLatch表示允许一个或多个线程等待其它线程的操作执行完毕后再执行后续的操作；
（2）CountDownLatch使用AQS的共享锁机制实现；
（3）CountDownLatch初始化的时候需要传入次数count；
（4）每次调用countDown()方法count的次数减1；
（5）每次调用await()方法的时候会尝试获取锁，这里的获取锁其实是检查AQS的state变量的值是否为0；
（6）当count的值（也就是state的值）减为0的时候会唤醒排队着的线程（这些线程调用await()进入队列）；

CountDownLatch与Thread.join()有何不同？

调用join方法需要等待thread执行完毕才能继续向下执行,而CountDownLatch只需要检查计数器的值为零就可以继续向下执行，相比之下，CountDownLatch更加灵活一些，可以实现一些更加复杂的业务场景。