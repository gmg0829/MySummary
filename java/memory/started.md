## 堆外内存与堆内内存

Java中的对象都是在JVM堆中分配的，其好处在于开发者不用关心对象的回收。但有利必有弊，堆内内存主要有两个缺点：1.GC是有成本的，堆中的对象数量越多，GC的开销也会越大。2.使用堆内内存进行文件、网络的IO时，JVM会使用堆外内存做一次额外的中转，也就是会多一次内存拷贝。

和堆内内存相对应，堆外内存就是把内存对象分配在Java虚拟机堆以外的内存，这些内存直接受操作系统管理（而不是虚拟机），这样做的结果就是能够在一定程度上减少垃圾回收对应用程序造成的影响。
### 堆内内存（on-heap memory)

其中堆内内存是我们平常工作中接触比较多的，我们在jvm参数中只要使用-Xms，-Xmx等参数就可以设置堆的大小和最大值，理解jvm的堆还需要知道下面这个公式：

```
堆内内存 = 新生代+老年代+持久代
```

在使用堆内内存（on-heap memory）的时候，完全遵守JVM虚拟机的内存管理机制，采用垃圾回收器（GC）统一进行内存管理，GC会在某些特定的时间点进行一次彻底回收，也就是Full GC，GC会对所有分配的堆内内存进行扫描，在这个过程中会对JAVA应用程序的性能造成一定影响，还可能会产生Stop The World。


### 堆外内存(off-heap memory)

Java中分配堆外内存的方式有两种，一是通过ByteBuffer.java#allocateDirect得到以一个DirectByteBuffer对象，二是直接调用Unsafe.java#allocateMemory分配内存，但Unsafe只能在JDK的代码中调用，一般不会直接使用该方法分配内存。

#### 使用场景

- 适合注重IO效率的场景：用堆外内存读写文件性能更好
- 适合简单对象的存储：因为堆外内存只能存储字节数组，所以对于复杂的DTO对象，每次存储/读取都需要序列化/反序列化。
- 适合注重稳定的场景：堆外内存能有效避免因GC导致的暂停问题。


