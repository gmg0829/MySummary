## BlockingQueue
### ArrayBlockingQueue
ArrayBlockingQueue 内部以 FIFO(先进先出)的顺序对元素进行存储。队列中的头元素在所有元素之中是放入时间最久的那个，而尾元素则是最短的那个。
### DelayQueue
DelayQueue 对元素进行持有知道一个特定的延迟到期。
### LinkedBlockingQueue
LinkedBlockingQueue 类也实现了 BlockingQueue接口。LinkedBlockingQueue 内部以一个链式结构对其元素进行存储。如果需要的话，这一链式结构可以选择一个上线。如果没有定义上线，将使用 Ingeter.MAX_VALUE 作为上线。
### PriorityBlockingQueue
PriorityBlockingQueue 是一个无界的并发队列。它使用了和 PriorityQueue 一样的排序规则。
### SynchronousQueue
SynchronousQueue 是一个特殊的队列，它的内部同时只能容纳单个元素。
### BlockingDeque
一个线程安放入和提取实例的双端队列。



