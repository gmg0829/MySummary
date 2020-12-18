- ConcurrentLinkedQueue

ConcurrentLinkedQueue : 是一个适用于高并发场景下的队列，通过无锁的方式，实现了高并发状态下的高性能，通常ConcurrentLinkedQueue性能好于BlockingQueue。 
它是一个基于链接节点的无界线程安全队列。该队列的元素遵循先进先出的原则。 
头是最先加入的，尾是最近加入的，该队列不允许null元素。

add 和offer() ：都是加入元素的方法(在ConcurrentLinkedQueue中这俩个方法没有任何区别) 
poll() 和peek() ：都是取头元素节点，区别在于前者会删除元素，后者不会。

- BlockingQueue

阻塞队列（BlockingQueue）是一个支持两个附加操作的队列。这两个附加的操作是： 
1、在队列为空时，获取元素的线程会等待队列变为非空。 
2、当队列满时，存储元素的线程会等待队列可用。 
阻塞队列是线程安全的。 
用途： 
阻塞队列常用于生产者和消费者的场景，生产者是往队列里添加元素的线程，消费者是从队列里拿元素的线程。阻塞队列就是生产者存放元素的容器，而消费者也只从容器里拿元素。

- ArrayBlockingQueue
ArrayBlockingQueue是一个有边界的阻塞队列，它的内部实现是一个数组。 
有边界的意思是它的容量是有限的，我们必须在其初始化的时候指定它的容量大小，容量大小一旦指定就不可改变。 
ArrayBlockingQueue是以先进先出的方式存储数据，最新插入的对象是尾部，最新移出的对象是头部。

- LinkedBlockingQueue

LinkedBlockingQueue阻塞队列大小的配置是可选的， 
如果我们初始化时指定一个大小，它就是有边界的，如果不指定，它就是无边界的。 
说是无边界，其实是采用了默认大小为Integer.MAX_VALUE的容量 。它的内部实现是一个链表。 
和ArrayBlockingQueue一样，LinkedBlockingQueue 也是以先进先出的方式存储数据，最新插入的对象是尾部，最新移出的对象是头部。

- PriorityBlockingQueue
PriorityBlockingQueue是一个没有边界的队列，它的排序规则和 java.util.PriorityQueue一样。需要注意，PriorityBlockingQueue中允许插入null对象。 
所有插入PriorityBlockingQueue的对象必须实现 java.lang.Comparable接口，队列优先级的排序规则就是按照我们对这个接口的实现来定义的。 
另外，我们可以从PriorityBlockingQueue获得一个迭代器Iterator，但这个迭代器并不保证按照优先级顺序进行迭代。

- SynchronousQueue

SynchronousQueue队列内部仅允许容纳一个元素。当一个线程插入一个元素后会被阻塞，除非这个元素被另一个线程消费


https://cloud.tencent.com/developer/article/1636024