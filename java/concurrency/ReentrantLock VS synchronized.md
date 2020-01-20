synchronized是Java原生提供的用于在多线程环境中保证同步的关键字，底层是通过修改对象头中的MarkWord来实现的。
ReentrantLock是Java语言层面提供的用于在多线程环境中保证同步的类，底层是通过原子更新状态变量state来实现的。

![](
  ./reen-synch.jpg)
