读写锁是一种特殊的锁，它把对共享资源的访问分为读访问和写访问，多个线程可以同时对共享资源进行读访问，但是同一时间只能有一个线程对共享资源进行写访问，使用读写锁可以极大地提高并发量。

ReentrantReadWriteLock中的类分成三个部分：
（1）ReentrantReadWriteLock本身实现了ReadWriteLock接口，这个接口只提供了两个方法readLock()和writeLock（）；
（2）同步器，包含一个继承了AQS的Sync内部类，以及其两个子类FairSync和NonfairSync；
（3）ReadLock和WriteLock两个内部类实现了Lock接口，它们具有锁的一些特性。



