  ![History-of-Java](
  ./History-of-Java.jpg)
## jdk 
  ![Java-Conceptual-Diagram](
  ./Java-Conceptual-Diagram.png)

## java 工具包
   ![java-source](
  ./java-source.png) 

  - applet 
  - awt 创建用户界面和绘制图形和图像的类。
  - beans JavaBean架构组件
  - io 数据流
  - lang 基础设计的类
  - math 数学
  - net 提供了实现网络应用程序的类。
  - nio 定义了缓冲器，它是数据容器，并且提供其他NIO包的概述。
  - rmi 
  - security 安全类
  - sql 数据库api
  - text 语言无关的方式处理文本、日期、数字和信息的类和接口。
  - time 日期、时间、时刻和时间段的主要API。
  - util 包含了集合框架、遗留的集合类、事件模型、日期和时间工具、国际化和各种各样的工具类。(364)
 ## openJdk
  ![openjdk-source](
  ./openjdk-source.png) 

  - hotspot：Java 虚拟机
  - jdk：java 开发工具包
 ## jvm Architecture

  ![openjdk-source](
  ./JVM-Architecture.png) 

  ## 一次编写多端运行
  ![openjdk-source](
  ./class-jvm.png) 

## JDK 8 from PermGen to Metaspace

 ![jdk7-memory](
  ./jdk7-memory.png)

 ![jdk8-memory](
  ./jdk8-memory.png)  

  ##  Major GC和Full GC
 ![Heap-Generations.png](
  ./Heap-Generations.png) 

  - Partial GC：并不收集整个GC堆的模式
    - Young GC：只收集young gen的GC
    - Old GC：只收集old gen的GC。只有CMS的concurrent collection是这个模式
    -  Mixed GC：收集整个young gen以及部分old gen的GC。只有G1有这个模式
 - Full GC：收集整个堆，包括young gen、old gen、perm gen（如果存在的话）等所有部分的模式。

Major GC通常是跟full GC是等价的，收集整个GC堆。

触发条件:
- young GC：当young gen中的eden区分配满的时候触发。注意young GC中有部分存活对象会晋升到old gen，所以young GC后old gen的占用量通常会有所升高。

- full GC：当准备要触发一次young GC时，如果发现统计数据说之前young GC的平均晋升大小比目前old gen剩余的空间大，则不会触发young GC而是转为触发full GC（因为HotSpot VM的GC里，除了CMS的concurrent collection之外，其它能收集old gen的GC都会同时收集整个GC堆，包括young gen，所以不需要事先触发一次单独的young GC）；或者，如果有perm gen的话，要在perm gen分配空间但已经没有足够空间时，也要触发一次full GC；或者System.gc()、heap dump带GC，默认也是触发full GC。

