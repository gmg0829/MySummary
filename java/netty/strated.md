https://juejin.im/post/6844903704668160008


## 概述

底层通信模块大部分是Netty，如Dubbo、Flink、Spark、Elasticsearch、HBase等流行的分布式框架。HBase从2.0版本开始默认使用NettyRPC Server，用Netty替代HBase原生的RPC Server。至于微服务Dubbo和RPC框架（如gRPC），它们的底层核心部分也都是Netty。
## Bootstrap、ServerBootstrap
Bootstrap类是Netty提供的一个便利的工厂类，可以通过它来完成Netty的客户端或服务端的Netty组件的组装，以及Netty程序的初始化和启动执行。
- ServerBootstrap用于服务端
- Bootstrap用于客户端

## Future、ChannelFuture
netty的Future接口直接继承自JDK的Future，增加了监听器模式的Listener，方便回调；Future可以通过cause方法获取任务执行异常的原因；主线程也可以通过sync()或者await()方法阻塞等待异步任务执行结束。

Netty是一个网络框架，肯定要为网络channel建立联系，ChannelFuture就是做这个事情的。
## Channel
Channel是Netty抽象出来的对网络I/O进行读/写的相关接口，与NIO中的Channel接口相似。Channel的主要功能有网络I/O的读/写、客户端发起连接、主动关闭连接、关闭链路、获取通信双方的网络地址等。Channel接口下有一个重要的抽象类——AbstractChannel，一些公共的基础方法都在这个抽象类中实现，一些特定功能可以通过各个不同的实现类去实现。最大限度地实现了功能和接口的重用。
## Selector

- 注册机制 : 选择器 ( Selector ) 可以注册多个 通道 ( Channel ) , 注册过程是以事件的方式进行注册 , 如果有事件触发 , 那么 选择器 ( Selector ) 就会针对该事件类型进行对应处理 ;

- 注册后的操作 : 通道 注册给 选择器 之后 , 每个线程对应的 选择器 ( Selector ) 才能监控客户端向服务器中对应的 通道 ( Channel ) 写出的数据 ;

- 轮询机制 : 选择器 ( Selector ) 工作时 , 不停地在轮询其所注册的 通道 ( Channel ) , 处理该 通道 所注册的对应事件 ;

- 非阻塞机制 : 只有 客户端连接 有数据写入时 , 才会触发事件 , 线程才开始处理该客户端对应的操作 , 如果没有数据写入 , 线程也不会在此阻塞 , 转而处理其它事务;
## NioEventLoop

NioEventLoop有以下5个核心功能。
- 开启Selector并初始化。
-  把ServerSocketChannel注册到Selector上。
- 处理各种I/O事件，如OP_ACCEPT、OP_CONNECT、OP_READ、OP_WRITE事件。
- 执行定时调度任务。
- 解决JDK空轮询bug
## NioEventLoopGroup

NioEventLoopGroup类主要完成以下3件事。

- 创建一定数量的NioEventLoop线程组并初始化。
- 创建线程选择器chooser。当获取线程时，通过选择器来获取。
- 创建线程工厂并构建线程执行器。

## ChannelHandler
ChannelHandler用来处理组件之间的交互，结合它的状态做各种业务，通过ChannelPipelinel来连接各个ChannelHandler。

- ChannelInboundHandler用来处理入站数据以及各种状态变化。
- ChannelInboundHandlerAdapter对接口做适配，默认简单的提交到ChannelPipeline的下一个ChannelHandler,在实现过程中只需要专注重写自己想要的方法即可，但是它不会自动的释放与池化ByteBuf相关的内存，需要手动调用 ReferenceCountUtil.release()自动的实现在SimpleChannelInboundHandler，注意如果要传递给下一个ChannelHandler需要调用 ReferenceCountUtil.retain()-
- ChannelOutboundHandler处理出站数据并且允许拦截所有的操作。
- ChannelOutboundHandlerAdapter对接口做了适配，默认调用ChannelHandlerContext相同的方法，实现转发到ChannelPipeline中的先一个ChannelHandler

##  ChannelHandlerContext

ChannelHandlerContext用于管理它所关联的ChannelHandler和同一个ChannelPipeline中的下一个ChannelHandler的交互【每当有handler添加到pipleline时，都会创建context，创建之后context和handler的关系永远都不会变，因而可以缓存context的引用】，如果事件从channel或者channelpipeline上触发将沿整个pipeline传播，但是context上的相同触发方式只会传递给pipeline上的下一个能够处理的handler。
## ChannelPipline

- addFirst(addLast):将channelhandler作为第一个(最后一个)处理器
- addBefore(addAfter):在已经存在的channelhandler之前(之后)添加一个处理器
- remove:从channelpipeline中删除一个已经存在的channelhandler
- replace:将原channelpipeline中的channelhandler替换成新的
- fire开头的方法：一般是调用channelpipeline中的下一个channelinboundchannelhandler对应的方法
## ByteBuf
在网络传输中，字节是基本单位，NIO使用ByteBuffer作为Byte字节容器，但是其使用过于复杂。因此Netty写了一套Channel，代替了NIO的Channel。Netty缓冲区又采用了一套ByteBuf代替了NIO的ByteBuffer。Netty的ByteBuf子类非常多，这里只对核心的ByteBuf进行详细的剖析。

## 原理
## 多路复用器

NIO有一个非常重要的组件——多路复用器，其底层有3种经典模型，分别是epoll、select和poll。与传统I/O相比，一个多路复用器可以处理多个Socket连接，而传统I/O对每个Socket连接都需要一条线程去同步阻塞处理。NIO有了多路复用器后，只需一条线程即可管理多个Socket连接的接入和读写事件。Netty的多路复用器默认调用的模型是epoll模型。

## Netty线程模型
讲到过两个线程组，即Boss线程组和Worker线程组。其中，Boss线程组一般只开启一条线程，除非一个Netty服务同时监听多个端口。Worker线程数默认是CPU核数的两倍，Boss线程主要监听SocketChannel的OP_ACCEPT事件和客户端的连接（主线程）。

当Boss线程监听到有SocketChannel连接接入时，会把SocketChannel包装成NioSocketChannel，并注册到Worker线程的Selector中，同时监听其OP_WRITE和OP_READ事件。当Worker线程监听到某个SocketChannel有就绪的读I/O事件。

## 编码和解码
Netty对编码和解码进行了抽象处理。编码器和解码器大部分都有共同的编码和解码父类，即MessageToMessageEncoder与ByteToMessageDecoder。

Netty的编码和解码除了解决TCP协议的粘包和拆包问题，还有一些编解码器做了很多额外的事情，如StringEncode（把字符串转换成字节流）、ProtobufDecoder（对Protobuf序列化数据进行解码）；还有各种常用的协议编解码器，如HTTP2、Websocket等。

## 序列化
为了解决Java自带序列化的缺点，会引入比较流行的序列化方式，如Protobuf、Kryo、JSON等。。但JSON序列化后的数据体积较大，不适合网络传输和海量数据存储。Protobuf和Kryo序列化后的体积与JSON相比要小很多。

## 零拷贝
拷贝是Netty的一个特性，主要发生在操作数据上，无须将数据Buffer从一个内存区域拷贝到另一个内存区域，少一次拷贝，CPU效率就会提升。

Netty底层运用Java NIO的FileChannel.transfer()方法，该方法依赖操作系统实现零拷贝，可以直接将文件缓冲区的数据发送到目标Channel中，避免了传统的通过循环写方式导致的内存数据拷贝问题。

## 背压

Netty的背压主要运用TCP的流量控制来完成整个链路的背压效果，而在TCP的流量控制中有个非常重要的概念——TCP窗口。TCP窗口的大小是可变的，因此也叫滑动窗口。TCP窗口本质上就是描述接收方的TCP缓存区能接收多少数据的，发送方可根据这个值来计算最多可以发送数据的长度。




