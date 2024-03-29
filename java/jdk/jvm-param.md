#JVM参数解读

   虚拟机给每个对象定义了一个对象年龄（Age）计数器。如果对象在 Eden 出生并经过第一次 Minor GC 后仍然存活，并且能被 Survivor 容纳的话，将被移动到 Survivor 空间中，并将对象年龄设为 1。对象在 Survivor 区中每熬过一次 Minor GC，年龄就增加 1 岁，当它的年龄增加到一定程度（默认为 15 岁）时，就会被晋升到老年代中。

## 1、堆设置

```
-Xms 初始堆大小（默认值，物理内存的1/64）
-Xmx 最大堆大小（默认值，物理内存的1/4）
-Xmn  年轻代大小(Sun官方推荐年轻代配置为整个堆的3/8)  。【使用此参数相当于同时使用-XX:NewSize=n和-XX:MaxNewSize=n】
-XX:NewSize=n 设置年轻代大小
-XX:MaxNewSize=n 设置年轻代最大值
-XX:NewRatio=n 设置老年代和年轻代的比值。如:为3，表示年老代与年轻代比值为3：1，年轻代占整个年轻代年老代和的1/4
-XX:SurvivorRatio=n 年轻代中Eden区与两个Survivor区的比值。注意Survivor区有两个。如：3，表示Eden：Survivor=3：2，一个Survivor区占整个年轻代的1/5
-Xss  每个线程的堆栈大小,JDK5.0以后每个线程堆栈大小为1M,以前每个线程堆栈大小为256K.更具应用的线程所需内存大小进行 调整.在相同物理内存下,减小这个值能生成更多的线程.
-XX:PermSize=n 设置持久代的大小 (物理内存的1/64 JDK 7)
-XX:MaxPermSize=n 设置持久代大小最大值(物理内存的1/4  JDK 7)
-XX:MetaSpaceSize=n 设置元空间大小(JDK 8)
-XX:MaxMetaspaceSize=n 设置元空间最大值(JDK 8)
```
## 2、收集器

JVM给了三种选择：串行收集器、并行收集器、并发收集器，但是串行收集器只适用于小数据量的情况，所以这里的选择主要针对并行收集器和并发收集器。

收集器设置 
```
-XX:+UseSerialGC:设置串行收集器 
-XX:+UseParallelGC:设置并行收集器 （此配置仅对年轻代有效）-XX:+UseParallelOldGC :设置并行年老代收集器
-XX:+UseG1GC
-XX:+UseConcMarkSweepGC:设置并发收集器(参数表示对于老年代的回收采用CMS。CMS采用的基础算法是：标记—清除。)
```
垃圾回收统计信息
```
-XX:+PrintGC 每次GC时打印相关信息
-XX:+PrintGCDetails 每次GC时打印详细信息
-XX:+PrintGCTimeStamps 打印每次GC的时间戳
-XX:-TraceClassLoading 跟踪类的加载信息
-XX:-PrintCompilation 当一个方法被编译时打印相关信息    
-XX:-HeapDumpOnOutOfMemoryError	 当首次遭遇OOM时导出此时堆中相关信息
-XX:+HeapDumpBeforeFullGC 实现在Full GC前dump。
-XX:+HeapDumpAfterFullGC 实现在Full GC后dump。
-XX:HeapDumpPath=./java_pid<pid>.hprof	指定导出堆信息时的路径或文件名
```

-Xms200m -Xmx200m -Xmn50m -XX:PermSize=30m -XX:+HeapDumpBeforeFullGC -XX:+HeapDumpAfterFullGC -XX:HeapDumpPath=e:\dump

使用时间戳命名文件
-XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:/path/to/gc-%t.log


-XX:+UseParNewGC -XX:+UseConcMarkSweepGC -Xms10m -Xmx10m -XX:+PrintGCDetails -Xloggc:gc_dandan.log -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./

第一，哪些对象占用大量内存。
第二，对象被谁引用。（就是要知道为什么它无法释放的意思）
第三，定位到具体哪行代码，进行分析问题


## 常用的JVM调优方案


### 1. 将新对象预留在新生代

  一般来说，当survivor区空间不够，或者占用量达到50%时，就会将对象进入老年代（不管对象年龄有多大）。

由于Full GC的成本要远远高于Minor GC,因此尽可能的将对象分配在新生代是一项明智的做法，在JVM调优中，可以为应用程序分配一个合理的新生代空间，以最大限度的避免新对象直接进入老年代的情况。

    -XX:NewRatio=n    可以设置新生代的大小比例

  当对象占用年轻代里的from区的一半时，对象会被直接送入老年代 。

    解决办法是

    通过设置 -XX:TargetSurvivorRatio=95  增大from区的利用率，使用from 区到95%是才将对象送入老年代。

    通过设置  -XX:SurvivorRatio=n  设置更大from区空间比例。
### 2、 大对象进入老年代

开发中要避免短命的大对象，目前没有特别好的方法回收短命大对象，大对象最好直接进入老年区，因为大对象在新生区，占用空间大，会由于空间不足而导致很多小对象进入到老年区。

-XX:PretenureSizeThreshold：设置大对象直接进入老年代的阈值，当对象的大小超过这个值将直接分配在老年代.

当创建的对象超过指定大小时，直接把对象分配在老年代中。
  -XX:PretenureSizeThreshold=3145728      参数设定超过对象超过多少时，分配到老年代中，此例为3M（3*1024*1024）。

### 3、 设置对象进入老年代 的年龄

 如果对象在eden区，经过一次GC后还存活，则被移动到survivior区中，对象年龄增加1，以后没经过一次GC，对象还存活，则年龄加1，当对象年龄达到阈值后，就移入老年代，成为老年对象。

  -XX:MaxTenuringThreshold=n，设置对象进入老年代的年龄，默认值时15，但是如果空间不够，还是会将对象移到老年代。推荐30.



Xmx 和 Xms设置为老年代存活对象的3-4倍，即FullGC之后的老年代内存占用的3-4倍
年轻代Xmn的设置为老年代存活对象的1-1.5倍。
老年代的内存大小设置为老年代存活对象的2-3倍。

