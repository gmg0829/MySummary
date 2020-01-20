synchronized关键字是Java里面最基本的同步手段，它经过编译之后，会在同步块的前后分别生成 monitorenter 和 monitorexit 字节码指令，这两个字节码指令都需要一个引用类型的参数来指明要锁定和解锁的对象。

lock，锁定，作用于主内存的变量，它把主内存中的变量标识为一条线程独占状态。
unlock，解锁，作用于主内存的变量，它把锁定的变量释放出来，释放出来的变量才可以被其它线程锁定。

但是这两个指令并没有直接提供给用户使用，而是提供了两个更高层次的指令 monitorenter 和 monitorexit 来隐式地使用 lock 和 unlock 指令。

根据JVM规范的要求，在执行monitorenter指令的时候，首先要去尝试获取对象的锁，如果这个对象没有被锁定，或者当前线程已经拥有了这个对象的锁，就把锁的计数器加1，相应地，在执行monitorexit的时候会把计数器减1，当计数器减小为0时，锁就释放了。

synchronized是一个非公平锁。

ConcurrentHashMap在jdk7的时候还是使用ReentrantLock加锁的，在jdk8的时候已经换成了原生的synchronized了，可见synchronized有原生的支持，它的进化空间还是很大的。

（1）偏向锁，是指一段同步代码一直被一个线程访问，那么这个线程会自动获取锁，降低获取锁的代价。
（2）轻量级锁，是指当锁是偏向锁时，被另一个线程所访问，偏向锁会升级为轻量级锁，这个线程会通过自旋的方式尝试获取锁，不会阻塞，提高性能。
（3）重量级锁，是指当锁是轻量级锁时，当自旋的线程自旋了一定的次数后，还没有获取到锁，就会进入阻塞状态，该锁升级为重量级锁，重量级锁会使其他线程阻塞，性能降低。

## 总结

（1）synchronized在编译时会在同步块前后生成monitorenter和monitorexit字节码指令；
（2）monitorenter和monitorexit字节码指令需要一个引用类型的参数，基本类型不可以哦；
（3）monitorenter和monitorexit字节码指令更底层是使用Java内存模型的lock和unlock指令；
（4）synchronized是可重入锁；
（5）synchronized是非公平锁；
（6）synchronized可以同时保证原子性、可见性、有序性；
（7）synchronized有三种状态：偏向锁、轻量级锁、重量级锁；。

这个引用类型的参数在Java中其实可以分成三大类：类对象、实例对象、普通引用。

